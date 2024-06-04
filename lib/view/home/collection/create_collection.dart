import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/home/collection/collection_add_book.dart';
import 'package:flutter/material.dart';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({Key? key}) : super(key: key);

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final Map<String, String> _collectionData = {};

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  
  
 
 

  @override
  void initState() {
    super.initState();
    _fillFields();
  }

  _fillFields() {
    titleController.text = _collectionData['title'] ?? '';
   
    descriptionController.text = _collectionData['description'] ?? '';
 
    /*selectedGenre = _collectionData['genre'] ?? 'Ação';*/
  }

  /*List<String> authors = ['Autor', 'Autor 2', 'Autor 3', 'Outro Autor'];
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
  String selectedGenre = 'Ação';*/

  @override
  Widget build(BuildContext context) {

   final Collection? collection = ModalRoute.of(context)!.settings.arguments as Collection?; 
    _loadCollectionData(collection);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Painel da Coleção ')),
        backgroundColor: Colors.grey.shade900,
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
          _collectionData['title'] ?? "Cadastro de Coleção",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Text("Coloque as informações da coleção abaixo:"),
      ],
    );
  }

  Widget _body() {
    return Column(
      children: [
        AppTextField(
          controller: titleController,
          hintText: "Título da coleção",
          icon: Icons.book_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: descriptionController,
          hintText: 'Descrição da coleção',
          icon: Icons.border_color_outlined,
        ),
        const SizedBox(height: 40),
        /*AppTextField(
          controller: imageController,
          hintText: 'Url da Imagem',
          icon: Icons.image_outlined,
        ),
        const SizedBox(height: 10),
        _dropDownButtonGenre(),
        const SizedBox(height: 10),
        _dropDownButtonAuthor(),
        const SizedBox(height: 30),*/
        AppButton(
          text: "Adicionar Livros",
          onPressed: () {
            _goToCollectionAddBook(collection);
          },
          
        ),
      ],
    );
  }

  _goToCollectionAddBook(Collection? collection) {
    Navigator.pushNamed(context, AppRoutes.COLLECTION_ADD_BOOK, arguments: collection);
  }

  void _loadCollectionData(Collection? collection) {
    if (collection != null) {
      _collectionData['id'] = collection.id.toString();
      _collectionData['title'] = collection.title.toString();
      _collectionData['description'] =
          collection.description != null ? collection.description.toString() : '';
    }
    setState(() {
      _fillFields();
    });
  }
}
