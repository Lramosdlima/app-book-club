import 'dart:js';
import 'package:bookclub/common/book_card.dart';
import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/book.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:bookclub/view/home/collection/my_collections.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:flutter/material.dart';

class CollectionAddBook extends StatefulWidget {
  const CollectionAddBook({super.key});

  @override
  State<CollectionAddBook> createState() => _CollectionAddBookState();
}

class _CollectionAddBookState extends State<CollectionAddBook> {
  bool _isLoading = false;
  Loader loader = Loader();
  late List<Book> books = [];



  List<Book> foundedBooks = [];
  List<Book> selectedBooks = [];

  Map<int, bool> selectedFlag = {};
  bool isSelectionMode = false;
  
  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;

  
      void initState() {
    super.initState();
    setState(() {
      // selectedFilter = filters[0];
      selectedItem = navigationItems[0];
    });
    Future.delayed(Duration.zero, () {
      _getBooks();
    });
     selectedFlag = {for (var i = 0; i < books.length; i++) i: false};
  }

  onSearch(String search) {
    setState(() {
      foundedBooks = books
          .where(
              (book) => book.title!.toLowerCase().contains(search))
          .toList();
    });
  }

void onLongPress(bool isSelected, int index) {
  setState(() {
    selectedFlag[index] = !isSelected;
    if (selectedFlag[index]!) {
      if (!selectedBooks.contains(books[index])) {
        selectedBooks.add(books[index]);
      }
    } else {
      selectedBooks.remove(books[index]);
    }
    isSelectionMode = selectedFlag.containsValue(true);
  });
}

void onTap(bool isSelected, int index) {
  if (isSelectionMode) {
    setState(() {
      selectedFlag[index] = !isSelected;
      if (selectedFlag[index]!) {
        if (!selectedBooks.contains(books[index])) {
          selectedBooks.add(books[index]);
        }
      } else {
        selectedBooks.remove(books[index]);
      }
      isSelectionMode = selectedFlag.containsValue(true);
    });
  } else {
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => BookDetail(book: books[index]),
      ),
    );
  }
}


 _buildSelectIcon(bool isSelected, Book books) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context as BuildContext).primaryColor,
      );
    } else {
        return null;
    }
  }
   
    
  @override
 Widget build(BuildContext context) {
  final Collection? collection = ModalRoute.of(context)!.settings.arguments as Collection?; 
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
              borderSide: BorderSide.none
            ),
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            hintText: "Procure Livros"
          ),
        ),
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              selectedFlag[index] = selectedFlag[index] ?? false;  
              bool? isSelected = selectedFlag[index];
              return Column(
                children: [
                  const SizedBox(height: 15),
                  ListTile(
                    onLongPress: () => onLongPress(isSelected, index),
                    onTap: () => onTap(isSelected, index),
                    title: Text(books[index].title ?? ''),
                    subtitle: Text(books[index].author?.name ?? ''),
                    leading: _buildSelectIcon(isSelected!, Book()),
                    tileColor: Colors.grey.shade800,
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        AppButton(
          text: "Criar Coleção",
          onPressed: () {
            _goToMyCollections();
            _createCollection(
              collection?.owner_id, 
              collection?.title, 
              collection?.description, 
              selectedBooks
            );
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
    setState(() => _isLoading = true);
    final response = await BookRepository().getBooks();

    if (response.status == true) {
      setState(() {
        books = List<Book>.from(response.data);
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }

  _goToMyCollections() {
    Navigator.push(
            context as BuildContext,
            MaterialPageRoute(builder: (context) => const MyCollectionPage()),
          );
  }

  _createCollection( owner_id ,title, description, selectedBooks ) async {
     if ( owner_id == null) return;

  try {
    final response = await CollectionRepository().createCollection(owner_id, title, description, selectedBooks);

    if (response.status == true) {
      Modal().successAlert(response.data.toString(), context as BuildContext);
    } else {
      // ignore: avoid_print
      print(response.error);
      Modal().errorAlert(response.error.toString(), context as BuildContext);
    }
  } catch (e) {
    // ignore: avoid_print
    print(e);
    Modal().errorAlert(e.toString(), context as BuildContext);
  }
}

}

