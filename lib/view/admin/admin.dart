import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final int _selectedIndex = 1;
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
        length: 1,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Painel Administrador"),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Column(
                  children: [
                    _searchBar(),
                    const SizedBox(height: 8),
                  ],
                ),
              )),
          body: _body(context),
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
        ));
  }
}

_body(context) {
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        children: [
          Text(
            "Funcionalidades do Administrador",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                fontFamily: TColor.secondaryFontFamily,
                color: TColor.secondaryText),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: "Criar Livro",
            icon: const Icon(Icons.menu_book, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.BOOK_FORM);
            },
          ),
          const SizedBox(height: 15),
          AppButton(
            text: "Criar Desafio",
            icon: const Icon(Icons.diamond, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          const SizedBox(height: 15),
          AppButton(
            text: "Criar QUIZ",
            icon: const Icon(Icons.quiz, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          const SizedBox(height: 15),
          AppButton(
            text: "Criar Comunidade",
            icon: const Icon(Icons.people, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
        ],
      ),
    ),
  );
}

_searchBar() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: TextField(
      decoration: InputDecoration(
        icon: (const Icon(Icons.search)),
        hintText: 'Pesquisar...',
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
        ),
      ),
    ),
  );
}
