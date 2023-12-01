import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/home/challenges.dart';
import 'package:bookclub/view/home/favoriteBooks.dart';
import 'package:bookclub/view/home/gender.dart';
import 'package:bookclub/view/home/listBooks.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;
  static const List<String> _routesOptions = <String>[
    AppRoutes.HOME,
    AppRoutes.ADMIN,
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
          automaticallyImplyLeading: false,
          title: const Text('Book Club'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                _searchBar(),
                const SizedBox(height: 8),
                const TabBar(
                  tabs: [
                    Tab(text: 'Livros'),
                    Tab(text: 'Favoritos'),
                    Tab(text: 'Desafios'),
                    Tab(text: 'Gêneros'),
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
            ChallengeList(),
            GenderList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Livros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Administrar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

_searchBar() {
  return Container(
    height: 40,
    width: 300,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const TextField(
      decoration: InputDecoration(
        hintText: "Pesquisar",
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
