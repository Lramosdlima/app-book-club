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

    const width = 150.0;
    const height = width * 1.25;

    return SizedBox(
      child: Padding(
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
                children: [
                  SizedBox(
                    height: height,
                    width: width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      child: Image.network(
                        book.url_image ?? urlDefault,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        book.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RatingBarIndicator(
                    rating: double.parse((book.rate ?? 0).toString()),
                    itemSize: 20,
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
      ),
    );
  }
}
