import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:bookclub/model/book.dart';
import 'package:flutter/material.dart';

class EditBookPage extends StatefulWidget {
  const EditBookPage({Key? key}) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final Map<String, String> _bookData = {};

  TextEditingController titleController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController synopsisController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fillFields();
  }

  _fillFields() {
    titleController.text = _bookData['title'] ?? '';
    genreController.text = _bookData['genre'] ?? '';
    synopsisController.text = _bookData['synopsis'] ?? '';
    imageController.text = _bookData['imageUrl'] ?? '';
    selectedGenre = _bookData['genre'] ?? 'Ação';
  }

  List<String> authors = ['Autor', 'Autor 2', 'Autor 3', 'Outro Autor'];
  String selectedAuthor = 'Autor';
  List<String> genres = [
    'Ação',
    'Terror',
    'Aventura',
    'Comédia',
    'Ficção Científica',
    'Drama',
    'Romance',
    'Outro'
  ];
  String selectedGenre = 'Ação';

  @override
  Widget build(BuildContext context) {
    final Book? book = ModalRoute.of(context)!.settings.arguments as Book?;

    _loadBookData(book);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Painel do livro')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  _header(),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  _body(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Text(
          _bookData['title'] ?? "Cadastro de Livro",
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const Text("Coloque as informações do livro abaixo:"),
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
          controller: synopsisController,
          hintText: 'Sinopse',
          icon: Icons.border_color_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: imageController,
          hintText: 'Url da Imagem',
          icon: Icons.image_outlined,
        ),
        const SizedBox(height: 10),
        _dropDownButtonGenre(),
        const SizedBox(height: 10),
        _dropDownButtonAuthor(),
        const SizedBox(height: 30),
        AppButton(
          text: "Salvar",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _dropDownButtonGenre() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGenre,
          onChanged: (String? newValue) {
            setState(() {
              selectedGenre = newValue!;
            });
          },
          items: genres.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  _dropDownButtonAuthor() {
    return Container(
      width: MediaQuery.of(context).size.width,
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
    setState(() {
      _fillFields();
    });
  }
}
