import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CreateCollectionPage extends StatefulWidget {
  final Collection? collection;
  const CreateCollectionPage({Key? key, this.collection}) : super(key: key);

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
    if (widget.collection != null) {
      _collectionData['id'] = widget.collection!.id.toString();
      _collectionData['title'] = widget.collection!.title.toString();
      _collectionData['description'] = widget.collection!.description != null
          ? widget.collection!.description.toString()
          : '';
          }

    _fillFields();
  }


  _fillFields() {
    titleController.text = _collectionData['title'] ?? '';
    descriptionController.text = _collectionData['description'] ?? '';
  }

  _fillCollectionData() {
    _collectionData['title'] = titleController.text;
    _collectionData['description'] = descriptionController.text;
  }

  @override
  Widget build(BuildContext context) {
    // final Collection? collection =
    //     ModalRoute.of(context)!.settings.arguments as Collection?;
    // _loadCollectionData(collection);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Painel da Coleção')),
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
          hintText: "Título da Coleção",
          icon: Icons.book_outlined,
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: descriptionController,
          hintText: 'Descrição da Coleção',
          icon: Icons.border_color_outlined,
        ),
        const SizedBox(height: 40),
        _showButton()
      ],
    );
  }

  _showButton() {
    return _collectionData['id'] == null
        ? AppButton(
            text: "Adicionar Livros",
            onPressed: () {
              _fillCollectionData();
              _goToCollectionAddBook(_collectionData);
            },
          )
        : AppButton(
            text: "Alterar coleção",
            onPressed: () {
              _fillCollectionData();
              _updateCollection(
                  _collectionData['id']!,
                  _collectionData['title'] ?? '',
                  _collectionData['description'] ?? '');
            },
          );
  }

  _goToCollectionAddBook(Map<String, String> collection) {
    Navigator.pushNamed(context, AppRoutes.COLLECTION_ADD_BOOK,
        arguments: collection);
  }

  // void _loadCollectionData(Collection? collection) {
  //   if (collection != null) {
  //     _collectionData['id'] = collection.id.toString();
  //     _collectionData['title'] = collection.title.toString();
  //     _collectionData['description'] = collection.description != null
  //         ? collection.description.toString()
  //         : '';
  //     setState(() {
  //       _fillFields();
  //     });
  //   }
  // }

  _updateCollection(String id, String title, String description) async {
    try {
      final response =
          await CollectionRepository().updateCollection(id, title, description);

      if (response.status == true) {
        Modal().successAlert(response.data.toString(), context);
        setState(() {});
      } else {
        // ignore: avoid_print
        print(response.error);
        Modal().errorAlert(response.error.toString(), context);
      }
    } catch (e) {
      print(e);
      Modal().errorAlert(e.toString(), context);
    }
  }
}
