import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final Map<String, String> _bookData = {};

  @override
  Widget build(BuildContext context) {
    final Book? book = ModalRoute.of(context)!.settings.arguments as Book?;

    _loadBookData(book);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Livro: ${_bookData['title'] ?? ''}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.BOOK_FORM,
                  arguments: book);
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _header(context),
          _body(),
        ]),
      ),
    ));
  }

  _header(context) {
    return Column(
      children: [
        AppText(
          text: _bookData['title'] ?? 'Livro',
          isTitle: true,
        ),
        const SizedBox(height: 10),
        Text(_bookData['synopsis'] ?? ''),
        const SizedBox(height: 10),
        _image(_bookData['imageUrl']),
      ],
    );
  }

  _image(String? imageUrl) {
    if (imageUrl != null) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            shape: BoxShape.rectangle),
        child: Image.network(
          imageUrl,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
        ),
      );
    } else {
      return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.rectangle),
          child: Image.asset(
            'assets/img/bookDefault.png',
            height: 220,
          ));
    }
  }

  _body() {
    return Column(children: [
      _buttonCommunity(),
      const SizedBox(height: 15),
      _buttonRead(),
      const SizedBox(height: 15),
      _buttonQuiz(),
      const SizedBox(height: 15),
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
}
