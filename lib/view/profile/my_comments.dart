import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class MyCommentsPage extends StatefulWidget {

  const MyCommentsPage({super.key});

  @override
  State<MyCommentsPage> createState() => _MyCommentsPageState();
}

class _MyCommentsPageState extends State<MyCommentsPage> {

  late List<UserBookRate> comments;

  @override
  void initState() {
    // CHAMADA ENDPOINT
    super.initState();
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  comment.user?.profile_picture != null
                  ? CircleAvatar(backgroundImage:  NetworkImage(comment.user?.profile_picture ?? ''))
                  : const CircleAvatar(child: Icon(Icons.person, color: Colors.white, size: 30)),
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
                '${comment.created_at?.day.toString() ?? '-'}/${comment.created_at?.month.toString() ?? '-'}/${comment.created_at?.year.toString() ?? '-'}',
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
