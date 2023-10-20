import 'package:flutter/material.dart';
import 'package:bookclub/view/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      themeMode: ThemeMode.dark,
      title: 'Book Club',
      home: HomePage(),
    );
  }
}
