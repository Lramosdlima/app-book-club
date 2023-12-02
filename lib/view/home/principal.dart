import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/view/home/challenges.dart';
import 'package:bookclub/view/home/favoriteBooks.dart';
import 'package:bookclub/view/home/gender.dart';
import 'package:bookclub/view/home/listBooks.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

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
              hintStyle: TextStyle(color: TColor.secondaryText),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: TColor.secondaryText,
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
              foregroundColor: TColor.primaryText,
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
