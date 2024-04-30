import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/repository/book.dart';
import 'package:bookclub/view/home/collection/collection.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:bookclub/view/home/newhome/comments.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Bookstore extends StatefulWidget {
  const Bookstore({super.key});

  @override
  _BookstoreState createState() => _BookstoreState();
}

class _BookstoreState extends State<Bookstore> {
  bool _isLoading = false;
  Loader loader = Loader();
  late List<Book> books = [];

  List<Filter> filters = getFilterList();
  Filter? selectedFilter;

  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;

  // List<Book> books = getBookList();
  // List<Author> authors = getAuthorList();
  // List<Comment> comments = getCommentList();

  @override
  void initState() {
    super.initState();
    setState(() {
      // selectedFilter = filters[0];
      selectedItem = navigationItems[0];
    });
    Future.delayed(Duration.zero, () {
      _getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                _logo(),
                const SizedBox(width: 10),
                const Text('Book Club'),
              ],
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: "Livros",
              ),
              Tab(
                text: "Avaliações",
              ),
              Tab(
                text: "Coleções",
              )
            ]),
          ),
          body: TabBarView(children: [
            _isLoading ? Loader().pageLoading() : _buildList(),
            const CommentsPage(),
            const CollectionPage(),
          ])),
    );
  }

  Widget _buildList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            "Livros Populares",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: books.isNotEmpty
              ? ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: buildBooks(),
                )
              : const EmptyPage(text: "Livros não encontrados!"),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            "Atividades Recentes",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: books.isNotEmpty
              ? ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: buildBooks(),
                )
              : const EmptyPage(text: "Livros não encontrados!"),
        ),
      ],
    );
  }

  List<Widget> buildBooks() {
    List<Widget> list = [];
    for (var i = 0; i < books.length; i++) {
      list.add(buildBook(books[i], i));
    }
    return list;
  }

  Widget buildBook(Book book, int index) {
    const urlDefault =
        'https://ayine.com.br/wp-content/uploads/2022/03/Miolo-diagonal-O-livro-dos-amigos-site.png';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetail(book: book)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 190.0,
              width: 120.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  book.imageUrl ?? urlDefault,
                  height: 190.0,
                  width: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 130,
              child: Text(
                book.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            RatingBarIndicator(
              rating: 3.5,
              itemSize: 15,
              itemBuilder: (_, __) => Icon(
                Icons.star,
                color: StyleManager.instance.primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget buildBook(Book book, int index) {
  //   const urlDefault =
  //       'https://ayine.com.br/wp-content/uploads/2022/03/Miolo-diagonal-O-livro-dos-amigos-site.png';

  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => BookDetail(book: book)),
  //       );
  //     },
  //     child: Container(
  //       margin:
  //           const EdgeInsets.only(right: 16, left: 16, bottom: 8),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           Expanded(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.5),
  //                     spreadRadius: 8,
  //                     blurRadius: 12,
  //                     offset: const Offset(0, 3),
  //                   ),
  //                 ],
  //               ),
  //               margin: const EdgeInsets.only(
  //                 bottom: 16,
  //                 top: 24,
  //               ),
  //               child: Hero(
  //                 tag: book.title ?? '',
  //                 child: Image.network(
  //                   book.imageUrl ?? urlDefault,
  //                   height: 180,
  //                   width: 120,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Text(
  //             book.title ?? '',
  //             style: TextStyle(
  //               fontSize: 12,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           Text(
  //             book.author?.name ?? '',
  //             style: const TextStyle(
  //               fontSize: 10,
  //               color: Colors.grey,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // List<Widget> buildAuthors() {
  //   List<Widget> list = [];
  //   for (var i = 0; i < authors.length; i++) {
  //     list.add(buildAuthor(authors[i], i));
  //   }
  //   return list;
  // }

  // Widget buildAuthor(Author author, int index) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.grey[200],
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(15),
  //       ),
  //     ),
  //     padding: const EdgeInsets.all(12),
  //     margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
  //     width: 255,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         Card(
  //           elevation: 4,
  //           margin: const EdgeInsets.all(0),
  //           clipBehavior: Clip.antiAlias,
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(15),
  //             ),
  //           ),
  //           child: Container(
  //             width: 75,
  //             height: 75,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: AssetImage(author.image),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(
  //           width: 12,
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               author.fullname,
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Row(
  //               children: [
  //                 const Icon(
  //                   Icons.library_books,
  //                   color: Colors.grey,
  //                   size: 14,
  //                 ),
  //                 const SizedBox(
  //                   width: 8,
  //                 ),
  //                 Text(
  //                   author.books.toString() + " books",
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

  Widget _logo() {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          shape: BoxShape.circle),
      child: const Icon(Icons.auto_stories, color: Colors.white, size: 20),
    );
  }
}
