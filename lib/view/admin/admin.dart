import 'package:bookclub/common/card.dart';
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
          Row(
            children: [
              Icon(Icons.book, color: StyleManager.instance.primary, size: 30),
              const SizedBox(width: 15),
              AppText(
                "Livros",
                type: TextType.title,
                textColor: StyleManager.instance.primary,
              ),
            ],
          ),
          Divider(color: StyleManager.instance.primary),
          AppCard(
              title: 'Painel Livro',
              icon: Icons.menu_book,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.BOOK_FORM);
              }),
          AppCard(
            title: 'Painel Desafio',
            icon: Icons.diamond,
            onPressed: () {
              // TODO: Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          AppCard(
            title: 'Painel QUIZ',
            icon: Icons.quiz,
            onPressed: () {
              // TODO: Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.people,
                  color: StyleManager.instance.primary, size: 30),
              const SizedBox(width: 15),
              AppText(
                "Usuários",
                type: TextType.title,
                textColor: StyleManager.instance.primary,
              ),
            ],
          ),
          Divider(color: StyleManager.instance.primary),
          AppCard(
            title: 'Painel Usuário',
            icon: Icons.person,
            onPressed: () {
              // TODO: Navigator.pushNamed(context, AppRoutes.ADMIN);
            },
          ),
          AppCard(
              title: 'Painel Comunidade',
              icon: Icons.people,
              onPressed: () {
                // TODO: Navigator.pushNamed(context, AppRoutes.ADMIN);
              }),
          AppCard(
              title: 'Painel Evento',
              icon: Icons.event,
              onPressed: () {
                // TODO: Navigator.pushNamed(context, AppRoutes.ADMIN);
              }),
          AppCard(
              title: 'Painel Chat',
              icon: Icons.chat,
              onPressed: () {
                // TODO: Navigator.pushNamed(context, AppRoutes.ADMIN);
              }),
        ],
      ),
    );
  }

  Widget _icon() {
    return const Icon(Icons.admin_panel_settings,
        color: Colors.white, size: 30);
  }
}
