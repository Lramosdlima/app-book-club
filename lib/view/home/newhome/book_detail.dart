import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/expandable_fab.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:bookclub/repository/interaction.dart';
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
  Interaction interaction = Interaction();
  bool alreadyRead = false;
  bool wantToRead = false;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _fetchComments();
      _getBookInteraction(widget.book.id!);
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
            icon: wantToRead
                ? const Icon(Icons.event_available, color: Colors.green)
                : const Icon(Icons.event_available_outlined),
          ),
          ActionButton(
            onPressed: () => _dialogAlreadyRead(context),
            icon: alreadyRead
                ? const Icon(Icons.add_task, color: Colors.green)
                : const Icon(Icons.add_task),
          ),
          ActionButton(
            onPressed: () => _dialogLike(context),
            icon: liked
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border_outlined),
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
        const SnackBar(
          content: Text('Comentário enviado com sucesso!'),
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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Quero Ler'),
            content: const Text(
                'Isso significa que você quer ler esse livro. Deseja marcar esse livro como quero ler?'),
            actions: [
              TextButton(
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Sim!'),
                onPressed: () async {
                  _addInteraction(widget.book.id!, wantToRead: true);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _dialogLike(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Gostei'),
            content: const Text(
                'Isso significa que deseja salvar esse livro nos seus favoritos. Deseja marcar esse livro como gostei?'),
            actions: [
              TextButton(
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Sim!'),
                onPressed: () async {
                  _addInteraction(widget.book.id!, liked: true);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _dialogAlreadyRead(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Já Lido'),
            content: const Text(
                'Isso significa que você terminou de ler esse livro. Deseja marcar esse livro como já lido?'),
            actions: [
              TextButton(
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Sim!'),
                onPressed: () async {
                  _addInteraction(widget.book.id!, alreadyRead: true);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _addInteraction(
    int bookId, {
    bool? alreadyRead,
    bool? wantToRead,
    bool? liked,
  }) async {
    try {
      final response = await InteractionRepository().addInteraction(
        bookId,
        alreadyRead: alreadyRead,
        wantToRead: wantToRead,
        liked: liked,
      );

      if (response.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Comentário enviado com sucesso!\n${response.data.toString()}'),
          ),
        );
      } else {
        // ignore: avoid_print
        print(response.error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Falha ao adicionar a interação:\n${response.error.toString()}'),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao adicionar a interação.'),
        ),
      );
    }
  }

  Future<void> _getBookInteraction(int bookId) async {
    final response =
        await InteractionRepository().getAllInteractionsByUserId(bookId);
    if (response.status == true) {
      setState(() {
        interaction = response.data;
        alreadyRead = interaction.already_read == true;
        wantToRead = interaction.want_to_read == true;
        liked = interaction.liked == true;
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
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
