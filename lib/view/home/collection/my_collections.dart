import 'package:bookclub/common/collection_card.dart';
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/text.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:bookclub/store/user.dart';
import 'package:bookclub/view/home/collection/collection_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ndialog/ndialog.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({Key? key}) : super(key: key);

  @override
  _MyCollectionPageState createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  UserStore userStore = UserStore();
  bool _isLoading = false;
  Loader loader = Loader();

  late List<Collection> _collections = [];

  late Collection collection;

  List<Collection> _foundedMyCollections = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getMyCollections();
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedMyCollections = _collections
          .where(
              (collection) => collection.title!.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: SizedBox(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Procure coleções"),
          ),
        ),
      ),
      floatingActionButton: userStore.user.id == null
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                _goToCreateCollection();
              },
              backgroundColor: StyleManager.instance.primary,
              child: const Icon(Icons.add),
            ),
      body: Container(
          child: userStore.user.id == null
              ? _necessaryLogin()
              : _isLoading
                  ? Loader().pageLoading()
                  : _foundedMyCollections.isNotEmpty
                      ? ListView.builder(
                          itemCount: _foundedMyCollections.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              //key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                //dismissible: DismissiblePane(onDismissed: () {}),
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    onPressed: (context) {
                                      _confirmDeleteCollection(
                                          _foundedMyCollections[index]);
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Excluir',
                                  ),
                                  SlidableAction(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    onPressed: (context) {
                                      _goToEditCollection(
                                          _foundedMyCollections[index]);
                                    },
                                    backgroundColor:
                                        const Color.fromARGB(255, 70, 163, 62),
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Editar',
                                  ),
                                ],
                              ),
                              child: CollectionCard(
                                  collection: _foundedMyCollections[index]),
                            );
                          })
                      : const EmptyPage(
                          text: "Nenhuma coleção sua foi encontrada...")),
    );
  }

  _necessaryLogin() {
    return EmptyPage(
        text: "Faça o login para criar uma Coleção !",
        icon: Icon(Icons.login,
            size: 40, color: StyleManager.instance.secondaryText));
  }

  _goToCreateCollection() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CollectionFormPage()),
    );
  }

  _goToEditCollection(Collection collection) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CollectionFormPage(
                collection: collection,
              )),
    );
  }

  _getMyCollections() async {
    setState(() => _isLoading = true);
    final response = await CollectionRepository().getMyCollections();

    if (response.status == true) {
      setState(() {
        _collections = List<Collection>.from(response.data);
      });
      setState(() {
        _foundedMyCollections = _collections;
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }

  _confirmDeleteCollection(Collection collection) async {
    AlertDialog(
      title: const AppText("Apagar coleção", type: TextType.subtitle),
      content: const AppText(
          "Deseja realmente apagar a coleção? Essa operação não poderá ser desfeita."),
      actions: [
        TextButton(
          child: const AppText("Cancelar"),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const AppText("Sim, apagar", textColor: Colors.red),
          onPressed: () async {
            Navigator.pop(context);
            _deleteCollection(collection.id);
            setState(() {
              _getMyCollections();
            });
          },
        ),
      ],
    ).show(context);
  }

  _deleteCollection(int? id) async {
    try {
      final response = await CollectionRepository().removeCollection(id!);

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
