import 'package:bookclub/common/book_card.dart';
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/repository/book.dart';
import 'package:flutter/material.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  bool _isLoading = false;
  Loader loader = Loader();

  late List<Book> booksPopular = [];
  late List<Book> booksRecent = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getBooksRecent();
      _getBooksPopular();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loader().pageLoading()
        : SingleChildScrollView(
          child: Column(
              children: [
                _books("recent"),
                _books("popular"),
              ],
            ),
        );
  }

  _books(String type) {
    String title;
    List<Widget> buildBooks;

    switch (type) {
      case "recent":
        title = "Recentes";
        buildBooks = buildBooksRecent();
        break;
      case "popular":
        title = "Populares";
        buildBooks = buildBooksPopular();
        break;
      default:
        title = "Livros";
        buildBooks = buildBooksRecent();
    }

    return Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      Text(
        title,
        style: const TextStyle(fontSize: 25),
      ),
      const Divider(),
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              child: booksRecent.isNotEmpty
                  ? ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: buildBooks,
                    )
                  : const EmptyPage(text: "Livros não encontrados!"),
            ),
          ],
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
    ]);
  }

  List<Widget> buildBooksRecent() {
    List<Widget> list = [];
    for (var i = 0; i < booksRecent.length; i++) {
      list.add(BookCard(book: booksRecent[i]));
    }
    return list;
  }

  List<Widget> buildBooksPopular() {
    List<Widget> list = [];
    for (var i = 0; i < booksPopular.length; i++) {
      list.add(BookCard(book: booksPopular[i]));
    }
    return list;
  }

  _getBooksRecent() async {
    setState(() => _isLoading = true);
    final response = await BookRepository().getBooks();

    if (response.status == true) {
      setState(() {
        booksRecent = List<Book>.from(response.data);
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }

  _getBooksPopular() async {
    setState(() => _isLoading = true);
    final response = await BookRepository().getBooksPopular();

    if (response.status == true) {
      setState(() {
        booksPopular = List<Book>.from(response.data);
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }
}
