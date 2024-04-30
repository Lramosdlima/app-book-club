import 'collection/collection.dart';
import 'package:bookclub/view/home/newhome/bookstore.dart';
import 'package:bookclub/view/profile/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pageOptions = <Widget>[
    const Bookstore(),
    const CollectionPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _body(),
       bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Principal',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.book),
            //   label: 'Buscar Livros',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              label: 'Coleções',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      );
  }

  _body() {
    return _pageOptions[_currentIndex];
  }
}
