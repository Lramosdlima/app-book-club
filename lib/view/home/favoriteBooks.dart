import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book(this.title, this.author, this.imageUrl);
}

class FavoriteBook extends StatelessWidget {
  final List<Book> books = [
    Book("Cosmos", " Carl Sagan",
        "https://m.media-amazon.com/images/I/41-v23uy6GL._SY344_BO1,204,203,200_QL70_ML2_.jpg"),
    Book("Sapiens", " Yuval Noah Harari",
        "https://m.media-amazon.com/images/I/41FU42ESk5L._SY344_BO1,204,203,200_QL70_ML2_.jpg"),
    Book("Sociedade do cansaço", " Byung-Chul Han",
        "https://m.media-amazon.com/images/I/411MEkpTzwL._SY344_BO1,204,203,200_QL70_ML2_.jpg"),
    Book("Refatoração", "Martin Fowler ",
        "https://m.media-amazon.com/images/I/4125lRe2M9L._SY344_BO1,204,203,200_QL70_ML2_.jpg"),
    Book("Algoritmos", "Thomas Thomas Cormen",
        "https://m.media-amazon.com/images/I/41Qd%2BbMbjCL._SY344_BO1,204,203,200_QL70_ML2_.jpg"),
    Book("Ficções", "Jorge Luis Borges",
        "https://m.media-amazon.com/images/I/41Gzkl2ZTDL._SY344_BO1,204,203,200_QL70_ML2_.jpg"),
    Book("O Livro do Desassosego", "Fernando Pessoas",
        "https://m.media-amazon.com/images/I/91d09o66Z9L._SY522_.jpg"),
    Book("Harry Potter", "J.K. Rowling",
        "https://m.media-amazon.com/images/I/518mqZ7A31L._SY445_SX342_.jpg"),
    Book("Cem Anos de Solidão", "Gabriel García Márquez",
        "https://m.media-amazon.com/images/I/51cfxI-51mL._SY445_SX342_.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
          mainAxisSpacing: 10,
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
      margin: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Image.network(
            book.imageUrl,
            height: 220,
          ),
          const SizedBox(height: 10),
          Text(
            book.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            book.author,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
