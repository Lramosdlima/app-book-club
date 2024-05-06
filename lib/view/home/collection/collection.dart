import 'package:bookclub/common/collection_card.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
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
                              label: 'Tirar da Coleção',
                            ),
                            SlidableAction(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              onPressed: doNothing,
                              backgroundColor: Color(0xFF0392CF),
                              foregroundColor: Colors.white,
                              icon: Icons.add,
                              label: 'Adicionar a coleção',
                            ),
                          ],
                        ),
                        child: CollectionCard(
                            collection: _foundedCollections[index]),
                      );
                    })
                : const Center(
                    child: Text("Nenhuma coleção encontrada"),
                  ),
      ),
    );
  }

  _getCollections() async {
    setState(() => _isLoading = true);
    final response = await CollectionRepository().getCollections();

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
}

void doNothing(BuildContext context) {}
