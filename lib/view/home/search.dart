import 'package:bookclub/view/home/gender.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.grey.shade900,
      title: Container(
        height: 38,
        child: TextField(
          // onChanged: (value) => onSearch(value),
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
              hintText: "Digite o nome do livro..."),
        ),
      ),
    ),
        body: GenderList());
  }
}
