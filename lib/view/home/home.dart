import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Home Page'),
            bottom: const TabBar(tabs: [
              Tab(text: 'Livros'),
              Tab(text: 'Favoritos'),
              Tab(text: 'Autores'),
              Tab(text: 'Gênero'),
            ])),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text('Bem vindo ao aplicativo Book Club!',
                  style: TextStyle(fontSize: 20)),
            ),
            Center(
              child: Text(
                "Lista de Favoritados",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: Text(
                "Lista de Autores",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: Text(
                "Lista de Gênero",
                style: TextStyle(fontSize: 20),
              ),
            ),
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
        ),
      ),
    );
  }
}
