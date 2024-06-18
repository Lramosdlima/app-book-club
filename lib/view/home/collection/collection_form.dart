import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:bookclub/common/validator.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CollectionFormPage extends StatefulWidget {
  final Collection? collection;
  const CollectionFormPage({Key? key, this.collection}) : super(key: key);

  @override
  State<CollectionFormPage> createState() => _CollectionFormPageState();
}

class _CollectionFormPageState extends State<CollectionFormPage> {
  final Map<String, String> _collectionData = {};

  final GlobalKey<FormState> _formkey = GlobalKey();

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
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const Text("Coloque as informações da coleção abaixo:"),
      ],
    );
  }

  Widget _body() {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AppTextField(
                  controller: titleController,
                  validator: Validator().validateTitleCollection,
                  label: "Título",
                  maxLength: 40,
                  icon: Icons.book_outlined,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: descriptionController,
                  validator: Validator().validateDescriptionCollection,
                  label: "Descrição",
                  minLines: 3,
                  maxLength: 200,
                  icon: Icons.edit,
                ),
              ],
            ),
            _showButton(),
          ],
        ),
      ),
    );
  }

  _showButton() {
    return _collectionData['id'] == null
        ? AppButton(
            text: "Adicionar Livros",
            icon: const Icon(Icons.add),
            onPressed: () {
              if (_formkey.currentState?.validate() == true &&
                  _formkey.currentState != null) {
                _formkey.currentState?.save();
                _fillCollectionData();
                _goToCollectionAddBook(_collectionData);
              } else {
                Modal().errorAlert(
                    "Você não preencheu os requisitos do cadastro", context);
              }
            },
          )
        : AppButton(
            text: "Alterar Coleção",
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (_formkey.currentState?.validate() == true &&
                  _formkey.currentState != null) {
                _formkey.currentState?.save();
                _fillCollectionData();
                _updateCollection(
                    _collectionData['id']!,
                    _collectionData['title'] ?? '',
                    _collectionData['description'] ?? '');
              } else {
                Modal().errorAlert("Preencha todos os campos", context);
              }
            },
          );
  }

  _goToCollectionAddBook(Map<String, String> collection) {
    Navigator.pushNamed(context, AppRoutes.COLLECTION_ADD_BOOK,
        arguments: collection);
  }

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
