import 'package:bookclub/common/book_card.dart';
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/repository/book.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:flutter/material.dart';

class BookPopular extends StatefulWidget {
  const BookPopular({super.key});

  @override
  _BookPopularState createState() => _BookPopularState();
}

class _BookPopularState extends State<BookPopular> {
  bool _isLoading = false;
  Loader loader = Loader();
  late List<Book> books = [];

  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      // selectedFilter = filters[0];
      selectedItem = navigationItems[0];
    });
    Future.delayed(Duration.zero, () {
      _getBooksPopular();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loader().pageLoading()
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Livros Mais Populares",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const Divider(),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: books.isNotEmpty
                      ? ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: buildBooks(),
                        )
                      : const EmptyPage(text: "Livros não encontrados!"),
                )
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

  _getBooksPopular() async {
    setState(() => _isLoading = true);
    final response = await BookRepository().getBooksPopular();

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
