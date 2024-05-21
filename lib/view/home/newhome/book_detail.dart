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
            floating: false,
            expandedHeight: 550,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                book.title ?? '',
                style: const TextStyle(fontSize: 18),
              ),
              centerTitle: false,
              expandedTitleScale: 1,
              background: Hero(
                tag: book.title ?? '',
                child: Image.network(
                  book.url_image ?? urlDefault,
                  height: 220,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return const CommentsPage();
              },
              childCount: 2, // Apenas um item (os comentários)
            ),
          ),
        ],
      ),
    );
  }
}
