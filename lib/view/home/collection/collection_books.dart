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
            title: collection.title != null ? Text(collection.title!) : null),
        body: ListView.builder(
          itemCount: foundedbooks.length,
          itemBuilder: (BuildContext context, int index) {
            final book = foundedbooks[index];
            return Column(
              children: [
                const SizedBox(height: 15),
                ListTile(
                  title: Text(book.title ?? ''),
                  subtitle: Text(book.author?.name ?? ''),
                  leading: book.url_image != null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  child: Image.network(
                                    book.url_image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.book),
                  tileColor: Colors.grey.shade800,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetail(book: book)),
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
