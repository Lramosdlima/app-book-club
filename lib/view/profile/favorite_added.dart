import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/repository/interaction.dart';
import 'package:flutter/material.dart';
// Importando o repositório
import 'package:bookclub/model/book.dart'; // Importando o modelo de livro
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoriteAddedPage extends StatefulWidget {
  const FavoriteAddedPage({Key? key}) : super(key: key);

  @override
  State<FavoriteAddedPage> createState() => _FavoriteAddedPageState();
}

class _FavoriteAddedPageState extends State<FavoriteAddedPage> {
  final InteractionRepository _interactionRepository =
      InteractionRepository(); // Instância do repositório
  List<Book> favoriteBooks = []; // Lista de livros favoritos
  List<Book> _filteredBooks = []; // Lista filtrada para pesquisa
  bool _isLoading = false; // Estado de carregamento

  @override
  void initState() {
    super.initState();
    _fetchFavoriteBooks(); // Chame a função para obter os livros favoritos ao iniciar a página
  }

  // Função para obter os livros favoritos
  void _fetchFavoriteBooks() async {
    setState(() {
      _isLoading = true;
    });

    final response = await _interactionRepository.getAllLikedBooks();

    if (response.status == true && response.data != null) {
      List<Interaction> interactions = List<Interaction>.from(response.data);

      List<Book> books = interactions.map((interaction) => interaction.book!).toList();

      setState(() {
        favoriteBooks = books;
        _filteredBooks = books;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      print('Erro ao obter livros favoritos: ${response.error}');
    }
  }

  // Função para filtrar os livros favoritos com base na pesquisa
  void _onSearch(String search) {
    setState(() {
      _filteredBooks = favoriteBooks
          .where((book) =>
              book.title!.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: StyleManager.instance.backgroundColor,
        title: SizedBox(
          height: 38,
          child: TextField(
            onChanged: (value) => _onSearch(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[850],
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Procure livros favoritos"),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: _isLoading
            ? Loader().pageLoading()
            : _filteredBooks.isEmpty
                ? const EmptyPage(text: "Nenhum livro favorito adicionado")
                : ListView.builder(
                    itemCount: _filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = _filteredBooks[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              onPressed: (context) {
                                _removeBookFromFavorites(book.id);
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Remover',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: book.url_image != null
                              ? Image.network(book.url_image!)
                              : const Icon(Icons.book),
                          title: Text(book.title ?? 'Título não disponível'),
                          subtitle:
                              Text(book.synopsis ?? 'Sinopse não disponível'),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  // Função para remover um livro dos favoritos (adapte para sua lógica específica)
  void _removeBookFromFavorites(int? id) async {
    if (id == null) return;

    try {
      // Lógica para remover livro dos favoritos, se aplicável
      print('Remover livro dos favoritos com ID: $id');
    } catch (e) {
      print('Erro ao remover livro dos favoritos: $e');
    }
  }
}
