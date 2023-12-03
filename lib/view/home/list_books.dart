import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/repository/book.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class BookGrid extends StatefulWidget {
  @override
  State<BookGrid> createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  bool _isLoading = false;
  Loader loader = Loader();
  late List<Book> books = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Loader().pageLoading() : _buildList(),
    );
  }

  Widget _buildList() {
    return books.isNotEmpty
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              return buildBookCard(books[index]);
            },
          )
        : const EmptyPage(text: "Livros não encontrados!");
  }

  Widget buildBookCard(Book book) {
    const urlDefault =
        'https://ayine.com.br/wp-content/uploads/2022/03/Miolo-diagonal-O-livro-dos-amigos-site.png';
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.BOOK, arguments: book);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            book.imageUrl != null
                ? Image.network(
                    book.imageUrl ?? urlDefault,
                    height: 220,
                  )
                : Image.asset(
                    'assets/img/book_default.png',
                    height: 220,
                  ),
            const SizedBox(height: 10),
            Text(
              book.title ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              book.authors?[0] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              'Gênero: ${book.genre ?? ''}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  _getBooks() async {
    setState(() => _isLoading = true);
    final response = await BookRepository().getBooks();

    if (response.status == true) {
      setState(() {
        books = List<Book>.from(response.data);
      });
    } else {
      print(response.error);
    }
    setState(() => _isLoading = false);
  }
}
