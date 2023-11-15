import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book(this.title, this.author, this.imageUrl);
}

class FavoriteBook extends StatelessWidget {
  final List<Book> books = [
    Book("O Senhor dos Anéis", "J.R.R. Tolkien",
        "https://m.media-amazon.com/images/I/71ZLavBjpRL._AC_UF1000,1000_QL80_.jpg"),
    Book("Harry Potter e a Pedra Filosofal", "J.K. Rowling",
        "https://m.media-amazon.com/images/I/518mqZ7A31L._SY445_SX342_.jpg"),
    Book("Cem Anos de Solidão", "Gabriel García Márquez",
        "https://m.media-amazon.com/images/I/51cfxI-51mL._SY445_SX342_.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return buildBookCard(books[index]);
        },
      ),
    );
  }

  Widget buildBookCard(Book book) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Image.network(
            book.imageUrl,
            height: 220,
          ),
          SizedBox(height: 10),
          Text(
            book.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            book.author,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
