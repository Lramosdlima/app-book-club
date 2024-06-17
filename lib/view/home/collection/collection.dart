import 'package:bookclub/common/collection_card.dart';
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
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
    return Column(
      children: [
        _searchBar(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width,
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
                                  _addCollection(_foundedCollections[index].id);
                                },
                                backgroundColor: const Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.add,
                                label: 'Adicionar a coleção',
                                autoClose: true,
                              ),
                            ],
                          ),
                          child: CollectionCard(
                              collection: _foundedCollections[index]),
                        );
                      })
                  : const EmptyPage(text: "Coleções não foram encontradas"),
        ),
      ],
    );
  }

  _searchBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 38,
            child: TextField(
              onChanged: (value) => onSearch(value.toLowerCase()),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: StyleManager.instance.primary.withOpacity(0.10),
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none),
                  hintStyle:
                      TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  hintText: "Procure coleções"),
            ),
          ),
        ),
      ],
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

  _addCollection(int? id) async {
    if (id == null) return;

    try {
      final response = await CollectionRepository().addCollectionToUser(id);

      if (response.status == true) {
        Modal().successAlert(response.data.toString(), context);
      } else {
        // ignore: avoid_print
        print(response.error);
        Modal().alertAlert(response.error.toString(), context);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Modal().errorAlert(e.toString(), context);
    }
  }
}
