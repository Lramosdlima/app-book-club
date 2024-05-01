import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/view/home/newhome/comments.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  final List<Comment> comments;

  BookDetail({required this.book}) : comments = getCommentList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 550,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                book.title ?? '',
                style: TextStyle(fontSize: 18),
              ),
              centerTitle: false,
              expandedTitleScale: 1,
              background: Hero(
                tag: book.title ?? '',
                child: Image.network(
                    book.imageUrl ?? '',
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
                if (index == 0) {
                  // Primeiro item é o container
                  return Container(
                    padding: EdgeInsets.all(20.0),
                    color: StyleManager.instance.backgroundColor,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ReadMoreText(
                        book.synopsis ?? '',
                        trimLines: 4, 
                        trimMode: TrimMode.Line,
                        trimExpandedText: 'mostra menos',
                        trimCollapsedText: 'mostrar mais',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                } else {
                  // Outros itens da lista são comentários
                  return CommentsPage();
                }
              },
              childCount: 2, // Apenas um item (os comentários)
            ),
          ),
        ],
      ),
    );
  }

}
