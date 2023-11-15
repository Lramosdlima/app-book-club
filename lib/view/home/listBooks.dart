import 'package:bookclub/repository/book.dart';
import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book(this.title, this.author, this.imageUrl);
}

class BookGrid extends StatelessWidget {
  final List<Book> books = [
    Book("Dom Casmurro", "Machado de Assis",
        "https://m.media-amazon.com/images/I/416E0ngf0xL._SY445_SX342_.jpg"),
    Book("1984", "George Orwell",
        "https://m.media-amazon.com/images/I/51VXYaKO-sL._SY445_SX342_.jpg"),
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Image.network(
            book.imageUrl,
            height: 220,
          ),
          const SizedBox(height: 10),
          Text(
            book.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            book.author,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// _getBooks() async {
//   setState(() => _isLoading = true);
//   final response = await BookRepository().getBooks();

//   if (response.status == true) {
//     setState(() {
//       listBooks = List<Book>.from(response.data['listBooks']);
//     });
//   } else {
//     (response.message);
//   }
//   setState(() => _isLoading = false);
// }
