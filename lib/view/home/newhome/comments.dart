import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:bookclub/repository/rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class CommentsPage extends StatefulWidget {
  final int? bookId;
  const CommentsPage({super.key, required this.bookId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  bool _isLoading = false;
  late List<UserBookRate> comments = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getComments(widget.bookId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loader().pageLoading()
        : comments.isEmpty
            ? const EmptyPage(text: "Sem comentários")
            : SingleChildScrollView(child: buildComments());
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

  Widget buildComment(UserBookRate comment) {
    return ListTile(
      title: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(comment.user?.profile_picture ?? '')),
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
                comment.created_at?.year.toString() ?? '',
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
            trimExpandedText: 'mostra menos',
            trimCollapsedText: 'mostrar mais',
          )
        ],
      ),
    );
  }

  _getComments(int bookId) async {
    setState(() => _isLoading = true);
    final response = await RateRepository().getRateByBookId(bookId);

    if (response.status == true) {
      setState(() {
        comments = List<UserBookRate>.from(response.data);
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }
}
