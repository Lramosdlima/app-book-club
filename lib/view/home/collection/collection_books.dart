import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:flutter/material.dart';

class CollectionBooksPage extends StatefulWidget {
  const CollectionBooksPage({super.key});

  @override
  State<CollectionBooksPage> createState() => _CollectionBooksPageState();
}

class _CollectionBooksPageState extends State<CollectionBooksPage> {
  @override
  Widget build(BuildContext context) {
    final Collection? collection =
        ModalRoute.of(context)!.settings.arguments as Collection?;

    final List<Book> foundedbooks = collection!.books!;

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade900,
            title: Container(height: 38)),
        body: ListView.builder(
          itemCount: foundedbooks.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                const SizedBox(height: 15),
                ListTile(
                  title: Text(foundedbooks[index].title ?? ''),
                  subtitle: Text(foundedbooks[index].author?.name ?? ''),
                  leading: const Icon(Icons.book),
                  tileColor: Colors.grey.shade800,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetail(book: foundedbooks[index])),
                    );
                  },
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ));
  }
}
