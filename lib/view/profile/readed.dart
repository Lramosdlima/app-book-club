import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/repository/interaction.dart';
import 'package:bookclub/view/home/newhome/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:bookclub/model/book.dart';
import 'package:bookclub/common/empty_page.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReadedPage extends StatefulWidget {
  const ReadedPage({super.key});

  @override
  State<ReadedPage> createState() => _ReadedPageState();
}

class _ReadedPageState extends State<ReadedPage> {
  final InteractionRepository _interactionRepository = InteractionRepository();
  List<Book> readedBooks = [];
  List<Book> _filteredBooks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchReadedBooks();
  }

  void _fetchReadedBooks() async {
    setState(() {
      _isLoading = true;
    });

    final response = await _interactionRepository.getAllAlreadyRead();

    if (response.status == true && response.data != null) {
      List<Interaction> interactions = response.data;

      List<Book> books = interactions.map((interaction) => interaction.book!).toList();

      setState(() {
        readedBooks = books;
        _filteredBooks = books;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Erro ao obter livros Lidos: ${response.error}');
    }
  }

  void _onSearch(String search) {
    setState(() {
      _filteredBooks = readedBooks
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
              hintText: "Procure livros Lidos",
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: _isLoading
            ? Loader().pageLoading()
            : _filteredBooks.isEmpty
                ? const EmptyPage(text: "Nenhum livro Lido adicionado")
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
      print('Remover livro lido com ID: $id');
    } catch (e) {
      print('Erro ao remover livro dos lidos: $e');
    }
  }
}
