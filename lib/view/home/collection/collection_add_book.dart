import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:flutter/material.dart';

class CollectionAddBook extends StatefulWidget {
  const CollectionAddBook({super.key});

  @override
  State<CollectionAddBook> createState() => _CollectionAddBookState();
}

class _CollectionAddBookState extends State<CollectionAddBook> {
  bool _isLoading = false;
  Loader loader = Loader();

  late List<Book> _books = [];

  List<Book> _foundedBooks = [];

  onSearch(String search) {
    setState(() {
      _foundedBooks = _books
          .where(
              (book) => book.title!.toLowerCase().contains(search))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: SizedBox(
          height: 38,
          child: TextField(
            //onChanged: (value) => onSearch(value),
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
      body: Container(
          color: Colors.grey.shade900,
          child: _isLoading
              ? Loader().pageLoading()
              : _foundedMyCollections.isNotEmpty
               : const Center(child: Text("Nenhuma livro foi adicionado ainda"))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // adiciona os livros a coleção
        },
        backgroundColor: StyleManager.instance.primary,
        child: Icon(Icons.add),
      ),
      );
    
    
  }
}