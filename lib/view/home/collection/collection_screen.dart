import 'package:bookclub/view/home/collection_folder/collection.dart';
import 'package:bookclub/view/home/collection_folder/collection_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final List<Collection> _collections = [
    Collection('Nice 80s Collection', '80s books'),
    Collection('Nice 90s Collection', '90s books'),
    Collection('Harry potter', 'Harry Potter series'
        ),
  ];

  List<Collection> _foundedCollections = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _foundedCollections = _collections;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedCollections = _collections
          .where(
              (collection) => collection.title.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding: EdgeInsets.all(0),
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
        child: _foundedCollections.isNotEmpty
            ? ListView.builder(
                itemCount: _foundedCollections.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    //key: const ValueKey(0),
                    endActionPane:  const ActionPane(
                      motion: ScrollMotion(),
                      //dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomLeft: Radius.circular(20) ),
                          onPressed: doNothing,
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Tirar da Coleção',
                        ),
                        SlidableAction(
                          borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight: Radius.circular(20) ),
                          onPressed: doNothing,
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.add,
                          label: 'Adicionar a coleção',
                        ),
                      ],
                    ),
                      child: collectionComponent(collection: _foundedCollections[index], context: context),
                  );
                })
            : const Center(
                child: Text(
                "No Collections found",
                style: TextStyle(color: Colors.white),
              )),
      ),
    );
  }
}

collectionComponent({required Collection collection, context}) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CollectionBooksPage(collection: collection)),
        );
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
      borderRadius: BorderRadius.all(Radius.circular(20))
    ),
        child: Column(
          children: [
            
            Row(
              children: [
                //Text(collection.image),
                //const Icon(Icons.book_outlined, color: Colors.white, size: 50),
                //SizedBox(width: 10),
                Text(
                  collection.title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              collection.description,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}

void doNothing(BuildContext context) {}
