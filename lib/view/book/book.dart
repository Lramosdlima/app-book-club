import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final Map<String, String> _bookData = {};

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final Book? book = ModalRoute.of(context)!.settings.arguments as Book?;

    _loadBookData(book);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Livro: ${_bookData['title'] ?? ''}"),
        actions: [
          _buttonShare(),
          _buttonFavorite(),
          _buttonEdit(book),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 24, left: 50, right: 50, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _body(),
          ],
        ),
      ),
    ));
  }

  _header(context) {
    return Column(
      children: [
        Text(
          _bookData['title'] ?? 'Livro',
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _synopsis(),
        const SizedBox(height: 10),
        _image(_bookData['imageUrl']),
      ],
    );
  }

  _synopsis() {
    return _bookData['synopsis'] != null
        ? Text(_bookData['synopsis'] ?? '')
        : const SizedBox();
  }

  _image(String? imageUrl) {
    if (imageUrl != null) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            shape: BoxShape.rectangle),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.rectangle),
          child: Image.asset(
            'assets/img/book_default.png',
            fit: BoxFit.cover,
          ));
    }
  }

  _body() {
    return Column(children: [
      _buttonCommunity(),
      const SizedBox(height: 20),
      _buttonRead(),
      const SizedBox(height: 20),
      _buttonQuiz(),
      const SizedBox(height: 20),
      _buttonChallenges(),
    ]);
  }

  _buttonCommunity() {
    return AppButton(
      text: "Comunidade",
      icon: const Icon(Icons.people, color: Colors.white),
      onPressed: () {},
    );
  }

  _buttonQuiz() {
    return AppButton(
      text: "Quiz",
      icon: const Icon(Icons.quiz, color: Colors.white),
      onPressed: () {},
    );
  }

  _buttonChallenges() {
    return AppButton(
      text: "Desafios",
      icon: const Icon(Icons.diamond, color: Colors.white),
      onPressed: () {},
    );
  }

  _buttonRead() {
    return AppButton(
      text: "Ler",
      icon: const Icon(Icons.auto_stories, color: Colors.white),
      onPressed: () {},
    );
  }

  void _loadBookData(Book? book) {
    if (book != null) {
      _bookData['id'] = book.id.toString();
      _bookData['title'] = book.title.toString();
      _bookData['synopsis'] =
          book.synopsis != null ? book.synopsis.toString() : '';
      _bookData['genre'] = book.genre != null ? book.genre.toString() : '';
      _bookData['authors'] =
          book.authors != null ? book.authors.toString() : '';
      _bookData['imageUrl'] =
          book.imageUrl != null ? book.imageUrl.toString() : '';
    }
  }

  _buttonFavorite() {
    const favoriteMessage = 'Livro adicionado aos favoritos!';
    const unfavoriteMessage = 'Livro removido dos favoritos!';
    SnackBar snackBar = SnackBar(
      content: Text(isFavorite ? unfavoriteMessage : favoriteMessage),
    );
    return IconButton(
      icon: isFavorite
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(Icons.favorite_border),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
    );
  }

  _buttonShare() {
    var modal = Modal(
            title: "Em Breve!",
            message: "Em breve será possível compartilhar o livro!")
        .setAlert(context);

    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () {
        modal.show(context);
      },
    );
  }

  _buttonEdit(Book? book) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.BOOK_FORM, arguments: book);
      },
    );
  }
}
