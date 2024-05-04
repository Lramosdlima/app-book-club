import 'package:bookclub/common/loader.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/repository/collection.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/home/collection/collection_books.dart';
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
      body: Container(
          color: Colors.grey.shade900,
          child: _isLoading
              ? Loader().pageLoading()
              : ListView.builder(
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
                      child: collectionComponent(
                          collection: _foundedMyCollections[index],
                          context: context),
                    );
                  })),
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

collectionComponent({required Collection collection, context}) {
  return GestureDetector(
    onTap: () {
          Navigator.pushNamed(context, AppRoutes.COLLECTION_BOOKS, arguments: collection);
        },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        //color: Colors.amber,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              children: [
                //Text(collection.image),
                //const Icon(Icons.book_outlined, color: Colors.white, size: 50),
                //SizedBox(width: 10),
                Text(
                  collection.title ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              collection.description ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}

void doNothing(BuildContext context) {}
