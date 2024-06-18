import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:bookclub/repository/rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:bookclub/util/network/http.dart';

class MyCommentsPage extends StatefulWidget {
  const MyCommentsPage({super.key});

  @override
  State<MyCommentsPage> createState() => _MyCommentsPageState();
}

class _MyCommentsPageState extends State<MyCommentsPage> {
  bool _isLoading = false;
  Loader loader = Loader();
  List<UserBookRate> _comments = [];
  Map<int, String> _bookTitles = {};

  @override
  void initState() {
    _fetchComments();
    super.initState();
  }

  Future<void> _fetchComments() async {
    setState(() => _isLoading = true);
    final response = await RateRepository().getRateByUserId();

    if (response.status == true) {
      List<UserBookRate> comments = List<UserBookRate>.from(response.data);
      setState(() {
        _comments = comments;
      });

      // Fetch book titles for each comment
      for (var comment in comments) {
        if (comment.book_id != null) {
          _fetchBookTitle(comment.book_id!);
        }
      }
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }

  Future<void> _fetchBookTitle(int bookId) async {
    try {
      final request = await HttpHelper.get('/book/$bookId');
      final result = request.data;

      if (result["status"] == true) {
        setState(() {
          _bookTitles[bookId] = result["data"]["title"];
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minhas Avaliações',
          style: TextStyle(color: StyleManager.instance.primary),
        ),
      ),
      body: _isLoading
          ? Loader().pageLoading()
          : _comments.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: _comments.map((comment) => buildComment(comment)).toList(),
                  ),
                )
              : const EmptyPage(text: "Nenhuma avaliação sua foi encontrada..."),
    );
  }

  Widget buildComment(UserBookRate comment) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _bookTitles[comment.book_id] ?? 'Carregando...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: StyleManager.instance.primary,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                comment.user?.profile_picture != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(comment.user?.profile_picture ?? ''))
                    : const CircleAvatar(
                        child: Icon(Icons.person, color: Colors.white, size: 30)),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.user?.name ?? '',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: comment.rate?.toDouble() ?? 0.0,
                          itemSize: 20,
                          itemBuilder: (_, __) => Icon(
                            Icons.star,
                            color: StyleManager.instance.secondary,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${comment.created_at?.day.toString() ?? '-'}/${comment.created_at?.month.toString() ?? '-'}/${comment.created_at?.year.toString() ?? '-'}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ReadMoreText(
              comment.comment ?? '',
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimExpandedText: 'mostrar menos',
              trimCollapsedText: 'mostrar mais',
            ),
          ],
        ),
      ),
    );
  }
}
