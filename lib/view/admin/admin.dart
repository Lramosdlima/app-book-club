import 'package:bookclub/common/StyleManager.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _icon(),
            const SizedBox(width: 10),
            const Text("Painel Administrador"),
          ],
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Text(
            "Dados",
            style: TextStyle(
              color: StyleManager.instance.primaryTextWhite,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Painel Livro'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.BOOK_FORM);
            },
          ),
          ListTile(
            leading: const Icon(Icons.diamond),
            title: const Text('Painel Desafio'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Painel QUIZ'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Painel Comunidade'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Painel Usuário'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Painel Evento'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Painel Chat'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    return const Icon(Icons.admin_panel_settings,
        color: Colors.white, size: 30);
  }
}
