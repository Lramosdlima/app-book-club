import 'package:bookclub/common/expandable_fab.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/repository/interaction.dart';
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
  Interaction interaction = Interaction();
  bool alreadyRead = false;
  bool wantToRead = false;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
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
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.add_comment_outlined),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: wantToRead
                ? const Icon(Icons.event_available, color: Colors.green)
                : const Icon(Icons.event_available_outlined),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: alreadyRead
                ? const Icon(Icons.add_task, color: Colors.green)
                : const Icon(Icons.add_task),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 3),
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
                  return CommentsPage(bookId: widget.book.id);
                }
              },
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  _showAction(BuildContext context, int index) {
    switch (index) {
      case 0:
        _addCommentPage(context);
        break;
      case 1:
        _dialogWantRead(context);
        break;
      case 2:
        _dialogAlreadyRead(context);
        break;
      case 3:
        _dialogLike(context);
        break;
    }
  }

  _addCommentPage(context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CreateCommentPage(bookId: book.id),
    //   ),
    // );
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
                onPressed: () {
                  _addInteraction(context, widget.book.id!, wantToRead: true);
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
                onPressed: () {
                  _addInteraction(context, widget.book.id!, liked: true);
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
                onPressed: () {
                  _addInteraction(context, widget.book.id!, alreadyRead: true);
                  Navigator.of(context).pop();
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
    try {
      final response = await InteractionRepository().addInteraction(
        bookId,
        alreadyRead: alreadyRead,
        wantToRead: wantToRead,
        liked: liked,
      );

      if (response.status == true) {
        Modal().successAlert(response.data.toString(), context);
      } else {
        // ignore: avoid_print
        print(response.error);
        Modal().errorAlert(response.error.toString(), context);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Modal().errorAlert(e.toString(), context);
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
}
