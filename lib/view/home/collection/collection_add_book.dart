import 'package:bookclub/common/style_manager.dart';
import 'package:flutter/material.dart';

class CollectionAddBook extends StatefulWidget {
  const CollectionAddBook({super.key});

  @override
  State<CollectionAddBook> createState() => _CollectionAddBookState();
}

class _CollectionAddBookState extends State<CollectionAddBook> {
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Adicionar livros')),
        backgroundColor: Colors.grey.shade900,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        backgroundColor: StyleManager.instance.primary,
        child: Icon(Icons.add),
      ),),
    );
    
  }
}