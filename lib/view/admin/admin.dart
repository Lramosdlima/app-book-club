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
    return SingleChildScrollView(
      child: Padding(
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
                text: "Painel Livro",
                icon: const Icon(Icons.menu_book, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.BOOK_FORM);
                },
              ),
              const SizedBox(height: 15),
              AppButton(
                text: "Painel Desafio",
                icon: const Icon(Icons.diamond, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ADMIN);
                },
              ),
              const SizedBox(height: 15),
              AppButton(
                text: "Painel QUIZ",
                icon: const Icon(Icons.quiz, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ADMIN);
                },
              ),
              const SizedBox(height: 15),
              AppButton(
                text: "Painel Comunidade",
                icon: const Icon(Icons.people, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ADMIN);
                },
              ),
              const SizedBox(height: 15),
              AppButton(
                text: "Painel Evento",
                icon: const Icon(Icons.event, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ADMIN);
                },
              ),
              const SizedBox(height: 15),
              AppButton(
                text: "Painel Chat",
                icon: const Icon(Icons.chat, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ADMIN);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return const Icon(Icons.admin_panel_settings,
        color: Colors.white, size: 30);
  }
}
