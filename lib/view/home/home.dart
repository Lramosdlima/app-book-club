import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/home/authors.dart';
import 'package:bookclub/view/home/favoriteBooks.dart';
import 'package:bookclub/view/home/gender.dart';
import 'package:bookclub/view/home/listBooks.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;
  static const List<String> _routesOptions = <String>[
    AppRoutes.HOME,
    AppRoutes.BOOK,
    AppRoutes.PROFILE,
  ];

  void _onItemTapped(int index) {
    setState(() {
      Navigator.of(context).pushReplacementNamed(_routesOptions[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Club'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: (const Icon(Icons.search)),
                      hintText: 'Pesquisar...',
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const TabBar(
                  tabs: [
                    Tab(text: 'Livros'),
                    Tab(text: 'Favoritos'),
                    Tab(text: 'Autores'),
                    Tab(text: 'Gênero'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BookGrid(),
            FavoriteBook(),
            AuthorList(),
            GenderList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
