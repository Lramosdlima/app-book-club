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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.0), // Ajuste a altura conforme necessário
            child: Column(
              children: [
                SizedBox(height: 20), // Espaço adicional entre a AppBar e a barra de pesquisa
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Espaço adicional entre a barra de pesquisa e a TabBar
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
        ),
      ),
    );
  }
}
