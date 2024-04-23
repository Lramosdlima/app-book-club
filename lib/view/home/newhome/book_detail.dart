import 'dart:html';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/view/home/newhome/constants.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                book.title,
                style: TextStyle(fontSize: 18),
              ),
              centerTitle: false,
              expandedTitleScale: 1,
              background: Hero(
                tag: book.title,
                child: Image.asset(book.image, fit: BoxFit.fitWidth),
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
                    color: StyleManager.instance.darkBackgroundColor,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ReadMoreText(
                        book.description,
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
                  return buildComments();
                }
              },
              childCount: 2, // Apenas um item (os comentários)
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComments() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        return buildComment(comments[index]);
      },
    );
  }

  Widget buildComment(Comment comment) {
    return ListTile(
      title: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: AssetImage(comment.userImage)),
                  SizedBox(width: 16.0),
                  Text(comment.name)
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0,),
          Row(
            children: [
              RatingBarIndicator(
                rating: 3.5,
                itemSize: 13,
                itemBuilder: (_, __) => Icon(Icons.star, color: StyleManager.instance.secondary ,),
              ),
              SizedBox(width: 16.0,),
              Text(comment.date,),

            ],
          ),
          const SizedBox(height: 16.0,),
          ReadMoreText(
            comment.commentText,
            trimLines: 2, 
            trimMode: TrimMode.Line,
            trimExpandedText: 'mostra menos',
            trimCollapsedText: 'mostrar mais',
            )
        ],
      ),
    );
  }
}
