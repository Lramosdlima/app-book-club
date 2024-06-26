import 'package:bookclub/common/book_card.dart';
import 'package:bookclub/common/book_collection_card.dart';
import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/repository/book.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:flutter/material.dart';

class CollectionAddBook extends StatefulWidget {
  const CollectionAddBook({super.key});

  @override
  State<CollectionAddBook> createState() => _CollectionAddBookState();
}

class _CollectionAddBookState extends State<CollectionAddBook> {
  Loader loader = Loader();
  late List<Book> books = [];

  List<Book> foundedBooks = [];
  List<Book> selectedBooks = [];

  Map<int, bool> selectedFlag = {};
  bool isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getBooks();
    });
    selectedFlag = {for (var i = 0; i < books.length; i++) i: false};
  }

  onSearch(String search) {
    setState(() {
      foundedBooks = books
          .where((book) => book.title!.toLowerCase().contains(search))
          .toList();
    });
  }

  void onLongPress(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      if (selectedFlag[index]!) {
        if (!selectedBooks.contains(foundedBooks[index])) {
          selectedBooks.add(foundedBooks[index]);
        }
      } else {
        selectedBooks.remove(foundedBooks[index]);
      }
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  void onTap(bool isSelected, int index) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        if (selectedFlag[index]!) {
          if (!selectedBooks.contains(foundedBooks[index])) {
            selectedBooks.add(foundedBooks[index]);
          }
        } else {
          selectedBooks.remove(foundedBooks[index]);
        }
        isSelectionMode = selectedFlag.containsValue(true);
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetail(book: foundedBooks[index]),
        ),
      );
    }
  }

  _buildSelectIcon(bool isSelected, Book books) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> collection =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: SizedBox(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Procure Livros"),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: StyleManager.instance.backgroundColor,
            child: const Text(
                'Aperte e segure para adicionar livros ou apenas aperte para ver a informação dos livros.'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foundedBooks.length,
              itemBuilder: (BuildContext context, int index) {
                Book book = foundedBooks[index];
                selectedFlag[index] = selectedFlag[index] ?? false;
                bool? isSelected = selectedFlag[index];
                return Column(
                  children: [
                    const SizedBox(height: 15),
                    BookCollectionCard(
                      book: book,
                      onTap: () => onTap(isSelected, index),
                      onLongPress: () => onLongPress(isSelected, index),
                      leading: _buildSelectIcon(isSelected!, Book()),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          AppButton(
            text: "Criar Coleção",
            icon: const Icon(Icons.check),
            backgroundColor: Colors.green,
            onPressed: () {
              if (selectedBooks.isNotEmpty) {
                _createCollection(
                  collection["title"] ?? '',
                  collection["description"] ?? '',
                  selectedBooks,
                );
              } else {
                Modal().errorAlert("Selecione pelo menos 1 livro", context);
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  List<Widget> buildBooks() {
    List<Widget> list = [];
    for (var i = 0; i < books.length; i++) {
      list.add(BookCard(book: books[i]));
    }
    return list;
  }

  _getBooks() async {
    loader.show(context);
    try {
      final response = await BookRepository().getBooks();
      loader.hide();
      books = List<Book>.from(response.data);

      if (response.status == true) {
        setState(() {
          foundedBooks = books;
        });
      } else {
        // ignore: avoid_print
        print(response.error);
      }
    } catch (e) {
      print(e);
    }
  }

  _goToMyCollections() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  _createCollection(
      String title, String description, List<Book> selectedBooks) async {
    try {
      loader.show(context);
      final response = await CollectionRepository()
          .createCollection(title, description, selectedBooks);
      loader.hide();

      if (response.status == true) {
        await Modal().successAlert(response.data.toString(), context);
        await _goToMyCollections();
      } else {
        // ignore: avoid_print
        print(response.error);
        Modal().errorAlert(response.error.toString(), context);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Modal().errorAlert(e.toString(), context as BuildContext);
    }
  }
}
