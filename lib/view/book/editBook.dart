import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:bookclub/model/book.dart';
import 'package:flutter/material.dart';

class EditBookPage extends StatefulWidget {
  EditBookPage({Key? key}) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final Map<String, String> _bookData = {};

  TextEditingController titleController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController synopsisController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  // Lista de autores para o DropdownButton
  List<String> authors = ['Autor 1', 'Autor 2', 'Autor 3', 'Outro Autor'];
  String selectedAuthor = 'Autor 1';

  @override
  Widget build(BuildContext context) {
    final Book? book = ModalRoute.of(context)!.settings.arguments as Book?;

    _loadBookData(book);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Editar livro')),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
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
          // initialText: _bookData['title'] ?? '',
          icon: Icons.book_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: genreController,
          hintText: 'Gênero',
          // initialText: _bookData['genre'] ?? '',
          icon: Icons.type_specimen_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: synopsisController,
          hintText: 'Synopsis',
          // initialText: _bookData['synopsis'] ?? '',
          icon: Icons.border_color_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: imageController,
          hintText: 'Url da Imagem',
          // initialText: _bookData['imageUrl'] ?? '',
          icon: Icons.image_outlined,
        ),
        const SizedBox(height: 10),
        _dropDownButton(),
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

  _dropDownButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
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
      ),
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
