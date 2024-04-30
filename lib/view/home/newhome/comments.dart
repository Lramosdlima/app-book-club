import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<Comment> comments = getCommentList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: buildComments());
  }

  Widget buildComments() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
                  const SizedBox(width: 16.0),
                  Text(comment.name)
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              RatingBarIndicator(
                rating: 3.5,
                itemSize: 13,
                itemBuilder: (_, __) => Icon(
                  Icons.star,
                  color: StyleManager.instance.secondary,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Text(
                comment.date,
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
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
