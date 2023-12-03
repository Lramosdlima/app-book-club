import 'package:bookclub/common/StyleManager.dart';
import 'package:bookclub/view/home/challenges.dart';
import 'package:bookclub/view/home/favorite_books.dart';
import 'package:bookclub/view/home/gender.dart';
import 'package:bookclub/view/home/list_books.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _logo(),
            const SizedBox(width: 10),
            const Text('Book Club'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Column(
            children: [
              TabBar(
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
      body: const TabBarView(
        children: <Widget>[
          BookGrid(),
          FavoriteBook(),
          ChallengeList(),
          GenderList(),
        ],
      ),
    );
  }

  _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Digite o nome do livro...",
              hintStyle: TextStyle(color: StyleManager.instance.secondaryText),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: StyleManager.instance.secondaryText,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
            onPressed: _buscarLivros,
            label: const Text('Pesquisar'),
            icon: const Icon(Icons.search),
            style: ElevatedButton.styleFrom(
              foregroundColor: StyleManager.instance.primaryText,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            )),
      ],
    );
  }

  _buscarLivros() {}

  Widget _logo() {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          shape: BoxShape.circle),
      child: const Icon(Icons.auto_stories, color: Colors.white, size: 20),
    );
  }
}
