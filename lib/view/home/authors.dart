import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book(this.title, this.author, this.imageUrl);
}

class AuthorList extends StatelessWidget {
  final List<Book> books = [
    Book("Dom Casmurro", "Machado de Assis",
        "https://example.com/dom_casmurro.jpg"),
    Book("1984", "George Orwell", "https://example.com/1984.jpg"),
    Book("O Senhor dos Anéis", "J.R.R. Tolkien",
        "https://example.com/senhor_aneis.jpg"),
    Book("Harry Potter e a Pedra Filosofal", "J.K. Rowling",
        "https://example.com/harry_potter.jpg"),
    Book("Cem Anos de Solidão", "Gabriel García Márquez",
        "https://example.com/cem_anos_solidao.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(books[index].author),
          );
        },
      ),
    );
  }
}
