import 'package:bookclub/common/StyleManager.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _icon(),
            const SizedBox(width: 10),
            const Text('Perfil'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Nome'),
              subtitle: Text('John Doe'),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('johndoe31@gmail.com'),
            ),
            const SizedBox(height: 20),
            Text(
              "Configurações",
              style: TextStyle(
                color: StyleManager.instance.primaryTextWhite,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Alterar Senha'),
              onTap: () {
                // Navigator.pushNamed(context, AppRoutes.CHANGE_PASSWORD);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar Perfil'),
              onTap: () {
                // Navigator.pushNamed(context, AppRoutes.EDIT_PROFILE);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Excluir Conta'),
              onTap: () {
                // Navigator.pushNamed(context, AppRoutes.DELETE_ACCOUNT);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.WELCOME);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return const Icon(Icons.person, color: Colors.white, size: 30);
  }
}
