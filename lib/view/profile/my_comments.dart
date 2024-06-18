import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:bookclub/repository/rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class MyCommentsPage extends StatefulWidget {
  const MyCommentsPage({super.key});

  @override
  State<MyCommentsPage> createState() => _MyCommentsPageState();
}

class _MyCommentsPageState extends State<MyCommentsPage> {
  bool _isLoading = false;
  Loader loader = Loader();
  List<UserBookRate> _comments = [];

  @override
  void initState() {
    _fetchComments();
    super.initState();
  }

  Future<void> _fetchComments() async {
    setState(() => _isLoading = true);
    final response = await RateRepository().getRateByUserId();

    if (response.status == true) {
      setState(() {
        _comments = List<UserBookRate>.from(response.data);
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Minhas Avaliações',
            style: TextStyle(color: StyleManager.instance.primary),
          ),
        ),
        body: Container(
          child: _isLoading
              ? Loader().pageLoading()
              : _comments.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _comments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildComment(_comments[index]);
                      },
                    )
                  : const EmptyPage(
                      text: "Nenhuma avaliação sua foi encontrada..."),
        ));
  }

  Widget buildComment(UserBookRate comment) {
  return ListTile(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            comment.user?.profile_picture != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(comment.user?.profile_picture ?? ''))
                : const CircleAvatar(
                    child: Icon(Icons.person, color: Colors.white, size: 30)),
            const SizedBox(width: 16.0),
            Text(comment.user?.name ?? ''),
            const SizedBox(width: 8.0), // Espaço entre o nome e a data
            Text(
              '${comment.created_at?.day.toString() ?? '-'}/${comment.created_at?.month.toString() ?? '-'}/${comment.created_at?.year.toString() ?? '-'}',
            ),
          ],
        ),
        const SizedBox(height: 16.0),
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
            const SizedBox(width: 16.0),
          ],
        ),
        const SizedBox(height: 16.0),
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
