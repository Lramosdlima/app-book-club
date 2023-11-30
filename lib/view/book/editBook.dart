import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:flutter/material.dart';

class EditBookPage extends StatefulWidget {
  EditBookPage({super.key});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController genreController = TextEditingController();

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
          "Edite o livro",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Coloque as informções para começar"),
      ],
    );
  }

  _body() {
    return Column(
      children: [
        AppTextField(
            controller: titleController,
            hintText: "Nome do livro",
            icon: Icons.person),
        const SizedBox(height: 10),
        AppTextField(
            controller: genreController,
            hintText: 'Gênero',
            icon: Icons.email_outlined),
        const SizedBox(height: 10),
        AppButton(
            text: "Criar conta",
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }
}
