import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/view/home/newhome/comments.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  final List<Comment> comments;

  BookDetail({super.key, required this.book}) : comments = getCommentList();

  @override
  Widget build(BuildContext context) {
    const urlDefault =
        'https://ayine.com.br/wp-content/uploads/2022/03/Miolo-diagonal-O-livro-dos-amigos-site.png';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_comment, color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 550,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                book.title ?? '',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: StyleManager.instance.primary),
              ),
              centerTitle: false,
              expandedTitleScale: 1.5,
              background: Stack(fit: StackFit.expand, children: [
                Image.network(
                  book.url_image ?? urlDefault,
                  height: 220,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(80, 0, 0, 0),
                    Color.fromARGB(245, 15, 9, 0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return _synopsis();
                } else {
                  return const CommentsPage();
                }
              },
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  _synopsis() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: StyleManager.instance.backgroundColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ReadMoreText(
          book.synopsis ?? '',
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimExpandedText: '  mostra menos',
          trimCollapsedText: '  mostrar mais',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
