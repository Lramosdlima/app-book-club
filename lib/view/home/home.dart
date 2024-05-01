import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/view/home/collection/collection.dart';
import 'package:bookclub/view/home/newhome/bookstore.dart';
import 'package:bookclub/view/home/search.dart';
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
    const SearchPage(),
    const CollectionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: StyleManager.instance.primary,
        selectedIndex: _currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Principal',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined),
            label: 'Buscar Livros',
          ),
          NavigationDestination(
              selectedIcon: Icon(Icons.local_library),
              icon: Icon(Icons.local_library_outlined),
              label: 'Coleções'),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          )
        ],
      ),
    );
  }

  _body() {
    return _pageOptions[_currentIndex];
  }
}
