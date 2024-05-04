import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const urlDefault =
        'https://ayine.com.br/wp-content/uploads/2022/03/Miolo-diagonal-O-livro-dos-amigos-site.png';

    const width = 210.0;
    const height = width * 1.28;

    return Padding(
      padding: const EdgeInsets.only(left: 13.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookDetail(book: book)),
          );
        },
        child: Card(
          color: StyleManager.instance.backgroundColor,
          elevation: 4,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: height,
                  width: width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      book.url_image ?? urlDefault,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 130,
                  child: Text(
                    book.title ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 5),
                RatingBarIndicator(
                  rating: 3.5,
                  itemSize: 18,
                  itemBuilder: (_, __) => Icon(
                    Icons.star,
                    color: StyleManager.instance.primary,
                  ),
                )
              ],
            ),
            // SizedBox(
            //   width: 200,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       IconButton.filledTonal(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.workspace_premium,
            //           size: 30,
            //           color: Colors.white,
            //         ),
            //       ),
            //       IconButton.filledTonal(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.menu_book,
            //           size: 30,
            //           color: Colors.white,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}
