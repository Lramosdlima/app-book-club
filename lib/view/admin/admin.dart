import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/text.dart';
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
            const AppText("Painel Administrador"),
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
          const AppText("Dados", type: TextType.title),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const AppText('Painel Livro'),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.BOOK_FORM);
            },
          ),
          ListTile(
            leading: const Icon(Icons.diamond),
            title: const AppText('Painel Desafio'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const AppText('Painel QUIZ'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const AppText('Painel Comunidade'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const AppText('Painel Usuário'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const AppText('Painel Evento'),
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const AppText('Painel Chat'),
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
