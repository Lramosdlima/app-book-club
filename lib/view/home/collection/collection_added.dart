import 'package:bookclub/common/collection_card.dart';
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CollectionAddedPage extends StatefulWidget {
  const CollectionAddedPage({Key? key}) : super(key: key);

  @override
  _CollectionAddedPageState createState() => _CollectionAddedPageState();
}

class _CollectionAddedPageState extends State<CollectionAddedPage> {
  bool _isLoading = false;
  Loader loader = Loader();

  late List<Collection> _collections = [];

  List<Collection> _foundedCollections = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getCollections();
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedCollections = _collections
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
        backgroundColor: StyleManager.instance.backgroundColor,
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
      body: Container(
        color: Colors.grey.shade900,
        child: _isLoading
            ? Loader().pageLoading()
            : _foundedCollections.isNotEmpty
                ? ListView.builder(
                    itemCount: _foundedCollections.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        //key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          //dismissible: DismissiblePane(onDismissed: () {}),
                          children: [
                            SlidableAction(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              onPressed: (context) {
                                _removeCollection(
                                    _foundedCollections[index].id);
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Remover a coleção',
                            ),
                          ],
                        ),
                        child: CollectionCard(
                            collection: _foundedCollections[index]),
                      );
                    })
                : const EmptyPage(text: "Nenhuma coleção adicionada a seu perfil"),
      ),
    );
  }

  _getCollections() async {
    setState(() => _isLoading = true);
    final response = await CollectionRepository().getAddedCollections();

    if (response.status == true) {
      setState(() {
        _collections = List<Collection>.from(response.data);
      });
      setState(() {
        _foundedCollections = _collections;
      });
    } else {
      // ignore: avoid_print
      print(response.error);
    }
    setState(() => _isLoading = false);
  }

  _removeCollection(int? id) async {
    if (id == null) return;

    try {
      final response =
          await CollectionRepository().removeCollectionFromUser(id);

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
