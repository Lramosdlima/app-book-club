import 'package:bookclub/common/modal.dart';
import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/repository/interaction.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:bookclub/model/book.dart';
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
  final InteractionRepository _interactionRepository = InteractionRepository();
  List<Book> favoriteBooks = [];
  List<Book> _filteredBooks = [];
  List<Interaction> interactions = [];
  bool _isLoading = false;
  Loader loader = Loader();

  @override
  void initState() {
    super.initState();
    _fetchFavoriteBooks();
  }

  void _fetchFavoriteBooks() async {
    setState(() {
      _isLoading = true;
    });

    final response = await _interactionRepository.getAllLikedBooks();

    if (response.status == true && response.data != null) {
      interactions = response.data;

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
      print('Erro ao obter livros favoritos: ${response.error}');
    }
  }

  void _onSearch(String search) {
    setState(() {
      _filteredBooks = favoriteBooks
          .where((book) => book.title!.toLowerCase().contains(search.toLowerCase()))
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
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              hintText: "Procure livros favoritos",
            ),
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
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              onPressed: (context) {
                                _removeBookFromLiked(book.id!);
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Remover',
                            ),
                          ],
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: book.url_image != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    child: Image.network(
                                      book.url_image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.book),
                            title: Text(book.title ?? 'Título não disponível'),
                            subtitle: Text(
                              book.synopsis ?? 'Sinopse não disponível',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetail(book: book),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  void _removeBookFromLiked(int bookId) async {
    try {
      final findInteraction = interactions.firstWhere((book) => book.book!.id == bookId);
      loader.show(context);
      final response = await _interactionRepository.updateIteraction(findInteraction.id!, liked: false);
      loader.hide();

      if (response.status == true) {
        Modal().successAlert('Livro removido dos favoritos com sucesso', context);
        setState(() {
          favoriteBooks.removeWhere((book) => book.id == bookId);
          _filteredBooks.removeWhere((book) => book.id == bookId);
        });
      } else {
        print(response.error);
        Modal().errorAlert(response.error.toString(), context);
      }
    } catch (e) {
      print(e);
      Modal().errorAlert(e.toString(), context);
    }
  }
}
