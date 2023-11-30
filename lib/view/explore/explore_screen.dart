import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Scaffold(
        appBar: AppBar(
        title: const Text("Explorar"),
        bottom: const TabBar(tabs: [
              Tab(text: 'Livros'),
              Tab(text: 'Favoritos'),
              Tab(text: 'Autores'),
              Tab(text: 'Gênero'),
            ])
          ),
          body: TabBarView(
            children: [
              // Tab de livros
              GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return books();
                },
              ),
            ]),
  
    
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explorar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "Biblioteca",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
        currentIndex: 1,
      ),
    ));
  }
}

 books() {
  return [
    const Card(
                    child: ListTile(
                      title: Text("O Pequeno Príncipe"),
                      subtitle: Text("Antoine de Saint-Exupéry"),
                    ),
                  ),
    const Card(
                    child: ListTile(
                      title: Text("O Grande Príncipe"),
                      subtitle: Text("Antoine de Saint-Exupéry"),
                    ),
                  ),
  ];
  
}