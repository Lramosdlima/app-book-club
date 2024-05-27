import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class CommentsPage extends StatelessWidget {
  final List<UserBookRate> comments;

  const CommentsPage({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        return buildComment(comments[index]);
      },
    );
  }

  Widget buildComment(UserBookRate comment) {
    return ListTile(
      title: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(comment.user?.profilePicture ?? '')),
                  const SizedBox(width: 16.0),
                  Text(comment.user?.name ?? ''),
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
                rating: comment.rate?.toDouble() ?? 0.0,
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
                '${comment.created_at?.year.toString() ?? '-'}/${comment.created_at?.month.toString() ?? '-'}',
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          ReadMoreText(
            comment.comment ?? '',
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimExpandedText: 'mostrar menos',
            trimCollapsedText: 'mostrar mais',
          )
        ],
      ),
    );
  }
}
