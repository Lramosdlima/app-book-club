import 'package:bookclub/model/collection.dart';
import 'package:flutter/material.dart';

class CollectionBooksPage extends StatefulWidget {
  const CollectionBooksPage({super.key, required this.collection});

  final Collection collection;

  @override
  State<CollectionBooksPage> createState() => _CollectionBooksPageState();
}

class _CollectionBooksPageState extends State<CollectionBooksPage> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Container(
          height: 38
        )
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: ListView.builder(
                itemCount: _foundedbooks.length, 
                itemBuilder: (context, index) {
                  child: BookComponent(collection: _foundedbooks[index], context: context);
                }
              )
      )
    );
}
}

