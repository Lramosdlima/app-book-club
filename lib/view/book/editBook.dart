import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:flutter/material.dart';

class EditBookPage extends StatefulWidget {
  EditBookPage({Key? key}) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController synopsisController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  // Lista de autores para o DropdownButton
  List<String> authors = ['Autor 1', 'Autor 2', 'Autor 3', 'Outro Autor'];
  String selectedAuthor = 'Autor 1';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Book Page')),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(context) {
    return const Column(
      children: [
        Text(
          "Edite o livro",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Coloque as informações para começar"),
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        AppTextField(
          controller: titleController,
          hintText: "Nome do livro",
          icon: Icons.book_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: genreController,
          hintText: 'Gênero',
          icon: Icons.type_specimen_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: synopsisController,
          hintText: 'Synopsis',
          icon: Icons.border_color_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: imageController,
          hintText: 'Url da Imagem',
          icon: Icons.image_outlined,
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: selectedAuthor,
          onChanged: (String? newValue) {
            setState(() {
              selectedAuthor = newValue!;
            });
          },
          items: authors.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        AppButton(
          text: "Editar Livro",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
