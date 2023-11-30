import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Book Page')),
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
    return const Column(
      children: [
        Text(
          "Livro",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Descrição do livro"),
      ],
    );
  }

  _body() {
    return Column(children: [
      _buttonCommunity(),
      _buttonFavorite(),
      _buttonRead(),
      _buttonEdit(),
    ]);
  }

  _buttonCommunity() {
    return AppButton(
      text: "Comunidade",
      onPressed: () {},
    );
  }

  _buttonFavorite() {
    return AppButton(
      text: "Favorito",
      onPressed: () {},
    );
  }

  _buttonRead() {
    return AppButton(
      text: "Ler",
      onPressed: () {},
    );
  }

  _buttonEdit() {
    return AppButton(
      text: "Editar",
      onPressed: () {},
    );
  }
}
