import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/repository/interaction.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WantToReadPage extends StatefulWidget {
  const WantToReadPage({super.key});

  @override
  State<WantToReadPage> createState() => _WantToReadPageState();
}

class _WantToReadPageState extends State<WantToReadPage> {
  final InteractionRepository _interactionRepository = InteractionRepository();
  List<Book> wantToreadBooks = [];
  List<Book> _filteredBooks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchWantToreadBooks();
  }

  void _fetchWantToreadBooks() async {
    setState(() {
      _isLoading = true;
    });

    final response = await _interactionRepository.getAllWantToRead();

    if (response.status == true && response.data != null) {
      List<Interaction> interactions = response.data;

      List<Book> books = interactions.map((interaction) => interaction.book!).toList();

      setState(() {
        wantToreadBooks = books;
        _filteredBooks = books;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Erro ao obter livros que deseja ler: ${response.error}');
    }
  }

  void _onSearch(String search) {
    setState(() {
      _filteredBooks = wantToreadBooks
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
              hintText: "Procure livros que deseje ler",
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: _isLoading
            ? Loader().pageLoading()
            : _filteredBooks.isEmpty
                ? const EmptyPage(text: "Nenhum livro adicionado")
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
                                _removeBookFromFavorites(book.id);
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

  void _removeBookFromFavorites(int? id) async {
    if (id == null) return;

    try {
      // Lógica para remover livro dos favoritos, se aplicável
      print('Remover livro que deseja ler com ID: $id');
    } catch (e) {
      print('Erro ao remover livro dos que deseja ler: $e');
    }
  }
}
