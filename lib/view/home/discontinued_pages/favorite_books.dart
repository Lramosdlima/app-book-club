import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/text.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/repository/favorite_book.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class FavoriteBook extends StatefulWidget {
  const FavoriteBook({Key? key}) : super(key: key);

  @override
  State<FavoriteBook> createState() => _FavoriteBookState();
}

class _FavoriteBookState extends State<FavoriteBook> {
  bool _isLoading = false;
  Loader loader = Loader();
  late List<Book> books = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getFavoriteBooks();
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
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              mainAxisSpacing: 10,
            ),
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              return buildBookCard(books[index]);
            },
          )
        : const EmptyPage(text: "Livros não encontrados!");
  }

  Widget buildBookCard(Book book) {
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
            book.url_image != null
                ? Image.network(
                    book.url_image!,
                    height: 220,
                  )
                : Image.asset(
                    'assets/img/book_default.png',
                    height: 220,
                  ),
            const SizedBox(height: 10),
            AppText(book.title ?? '', type: TextType.title),
            const SizedBox(height: 5),
            AppText(book.author?.name ?? ''),
            const SizedBox(height: 5),
            AppText('Gênero: ${book.genre?.name ?? ''}'),
          ],
        ),
      ),
    );
  }

  _getFavoriteBooks() async {
    setState(() => _isLoading = true);
    final response = await FavoriteBookRepository().getFavoriteBooks();

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
}
