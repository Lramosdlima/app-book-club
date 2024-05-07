import 'package:bookclub/common/collection_card.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:bookclub/view/home/discontinued_pages/edit_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({Key? key}) : super(key: key);

  @override
  _MyCollectionPageState createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {
  bool _isLoading = false;
  Loader loader = Loader();

  late List<Collection> _collections = [];

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToEditBook();
        },
        backgroundColor: StyleManager.instance.primary,
        child: Icon(Icons.add),
      ),
      body: Container(
          color: Colors.grey.shade900,
          child: _isLoading
              ? Loader().pageLoading()
              : _foundedMyCollections.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundedMyCollections.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          //key: const ValueKey(0),
                          endActionPane: const ActionPane(
                            motion: ScrollMotion(),
                            //dismissible: DismissiblePane(onDismissed: () {}),
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                onPressed: doNothing,
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Excluir',
                              ),
                              SlidableAction(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                onPressed: doNothing,
                                backgroundColor: Color.fromARGB(255, 70, 163, 62),
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
                  : const Center(child: Text("Nenhuma coleção sua foi encontrada"))),
    );
  }

  _goToEditBook() {
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditBookPage()),
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
}

void doNothing(BuildContext context) {}
