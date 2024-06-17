import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/expandable_fab.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:bookclub/repository/interaction.dart';
import 'package:bookclub/repository/rate.dart';
import 'package:bookclub/view/home/newhome/comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  Loader loader = Loader();

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
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Loader().pageLoading(),
                        )
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

  void _addCommentPage(BuildContext context, int bookId) {
    final TextEditingController controller = TextEditingController();
    double rating = 3.0; // Valor inicial da avaliação

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sua Avaliação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  rating = rating;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Faça um comentário",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                maxLines: 3,
                maxLength: 100,
              ),
            ],
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
                final comment = controller.text;
                if (comment.isNotEmpty) {
                  Navigator.of(context).pop();
                  await _postComment(context, bookId, rating.toInt(), comment);
                  await _fetchComments(); // Refresh the comments
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _postComment(
      context, int bookId, int rate, String? comment) async {
    final response = await RateRepository().createRate(bookId, rate, comment);

    if (response.status == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comentário enviado com sucesso!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao enviar o comentário.'),
        ),
      );
    }
  }

  _dialogWantRead(context) {
    var message = '';
    wantToRead
        ? message = 'Deseja desmarcar esse livro como quero ler?'
        : message = 'Deseja marcar esse livro como quero ler?';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Quero Ler'),
            content: Text(message),
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
                  await _addInteraction(context, widget.book.id!,
                      wantToRead: true);
                },
              ),
            ],
          );
        });
  }

  _dialogLike(context) {
    var message = '';
    liked
        ? message = 'Deseja desmarcar esse livro como gostei?'
        : message = 'Deseja marcar esse livro como gostei?';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Gostei'),
            content: Text(message),
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
                  await _addInteraction(context, widget.book.id!, liked: true);
                },
              ),
            ],
          );
        });
  }

  _dialogAlreadyRead(context) {
    var message = '';
    alreadyRead
        ? message = 'Deseja desmarcar esse livro como ja lido?'
        : message = 'Deseja marcar esse livro como ja lido?';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Já Lido'),
            content: Text(message),
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
                  await _addInteraction(context, widget.book.id!,
                      alreadyRead: true);
                },
              ),
            ],
          );
        });
  }

  Future<void> _addInteraction(
    context,
    int bookId, {
    bool? alreadyRead,
    bool? wantToRead,
    bool? liked,
  }) async {
    loader.show(context);
    try {
      final response = await InteractionRepository().addInteraction(
        bookId,
        alreadyRead: alreadyRead,
        wantToRead: wantToRead,
        liked: liked,
      );

      loader.hide();

      if (response.status == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Interação adicionada com sucesso!\n${response.data.toString()}'),
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
      loader.hide();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao adicionar a interação.'),
        ),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<void> _getBookInteraction(int bookId) async {
    loader.show(context);
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
    loader.hide();
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
