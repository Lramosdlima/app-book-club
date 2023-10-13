import 'package:flutter/material.dart';
import 'package:book_club/view/home/home.dart'

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwath: Colors.green)
      title: 'Book Club',
      home: HomePage(),
    );
  }
}
