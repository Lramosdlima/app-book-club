import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:flutter/material.dart';

class BookCollectionCard extends StatelessWidget {
  final Book book;
  final Function()? onTap;
  final Function()? onLongPress;

  final Widget? leading;

  const BookCollectionCard(
      {Key? key,
      required this.book,
      this.onTap,
      this.onLongPress,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(book.title ?? '',
            style: TextStyle(color: StyleManager.instance.primary)),
        subtitle: Text(
          book.author?.name ?? '',
          style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        leading: leading ??
            (book.url_image != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Image.network(
                      book.url_image!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.book,
                    size: 40,
                  )),
        tileColor: Colors.grey.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: onTap != null
            ? onTap!
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDetail(book: book)),
                );
              },
        onLongPress: onLongPress,
      ),
    );
  }
}
