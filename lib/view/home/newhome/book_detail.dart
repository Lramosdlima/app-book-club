import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/expandable_fab.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:bookclub/repository/rate.dart';
import 'package:bookclub/view/home/newhome/comments.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class BookDetail extends StatefulWidget {
  final Book book;

  const BookDetail({super.key, required this.book});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  List<UserBookRate> _comments = [];
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
     Future.delayed(Duration.zero, () {
      _fetchComments();
    });
  }

  @override
  Widget build(BuildContext context) {
    const urlDefault =
        'https://ayine.com.br/wp-content/uploads/2022/03/Miolo-diagonal-O-livro-dos-amigos-site.png';

    return Scaffold(
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () => _addCommentPage(context, widget.book.id ?? 0),
            icon: const Icon(Icons.add_comment_outlined),
          ),
          ActionButton(
            onPressed: () => _dialogWantRead(context),
            icon: const Icon(Icons.event_available_outlined),
          ),
          ActionButton(
            onPressed: () => _dialogAlreadyRead(context),
            icon: const Icon(Icons.add_task),
          ),
          ActionButton(
            onPressed: () => _dialogLike(context),
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 550,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.book.title ?? '',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: StyleManager.instance.primary),
              ),
              centerTitle: false,
              expandedTitleScale: 1.5,
              background: Stack(fit: StackFit.expand, children: [
                Image.network(
                  widget.book.url_image ?? urlDefault,
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
                  return _isLoading
                      ? Loader().pageLoading()
                      : _comments.isEmpty
                          ? const EmptyPage(text: "Sem comentários")
                          : CommentsPage(comments: _comments);
                }
              },
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  _addCommentPage(BuildContext context, int bookId) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sua Avaliação'),
          content: Container(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Faça um comentário",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              maxLines: 3,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Enviar'),
              onPressed: () async {
                final comment = _controller.text;
                if (comment.isNotEmpty) {
                  await _postComment(bookId, 0, comment);
                  Navigator.of(context).pop();
                  await _fetchComments(); // Refresh the comments
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _postComment(int bookId, int rate, String? comment) async {
    final response = await RateRepository().createRate(bookId, rate, comment);

    if (response.status == true) {
      print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Comentário enviado com sucesso!'),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () {
              // Código para desfazer a ação
            },
          ),
        ),
      );
    } else {
      print(response.error);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao enviar o comentário.'),
        ),
      );
    }
  }

  _dialogWantRead(context) {
    // ... (existing code for the dialog)
  }

  _dialogLike(context) {
    // ... (existing code for the dialog)
  }

  _dialogAlreadyRead(context) {
    // ... (existing code for the dialog)
  }

  _synopsis() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: StyleManager.instance.backgroundColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ReadMoreText(
          widget.book.synopsis ?? '',
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

  Future<void> _fetchComments() async {
    setState(() => _isLoading = true);
    final response =
        await RateRepository().getRateByBookId(widget.book.id ?? 0);

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

}
