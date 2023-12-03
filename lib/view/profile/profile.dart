import 'package:bookclub/common/card.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/bottom_sheet.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/text.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/store/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserStore userStore = UserStore();
  Loader loader = Loader();
  bool _notification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _icon(),
            const SizedBox(width: 10),
            const AppText('Perfil'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppCard(
                title: userStore.user.id != null ? 'Meus dados' : 'Login',
                icon: Icons.person,
                onPressed: () {
                  userStore.user.id != null
                      ? _goToProfileDetail()
                      : _goToLogin();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notificações'),
                trailing: Switch(
                  value: _notification,
                  onChanged: (value) {
                    setState(() {
                      _notification = value;
                    });
                  },
                ),
              ),
              AppCard(
                title: 'Alterar Senha',
                icon: Icons.lock,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.CHANGE_PASSWORD);
                },
              ),
              AppCard(
                title: 'Excluir Conta',
                icon: Icons.delete,
                onPressed: _confirmDeleteUserData,
              ),
              AppCard(
                title: 'Sair',
                icon: Icons.exit_to_app,
                onPressed: _logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return const Icon(Icons.person, color: Colors.white, size: 30);
  }

  _goToProfileDetail() {
    Navigator.pushNamed(context, AppRoutes.PROFILE_DETAIL);
  }

  _goToLogin() {
    Navigator.pushNamed(context, AppRoutes.LOGIN);
  }

  _logOut() {
    // TODO: AuthRepository().logout();
    Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
  }

  _confirmDeleteUserData() async {
    AlertDialog(
      title: const AppText("Apagar conta"),
      content: const AppText(
          "Deseja realmente apagar sua conta? Essa operação não poderá ser desfeita."),
      actions: [
        TextButton(
          child: const AppText("Cancelar"),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const AppText("Sim, apagar"),
          onPressed: () async {
            Navigator.pop(context);
            _deleteUserData();
          },
        ),
      ],
    );
  }

  _deleteUserData() async {
    loader.show(context);
    // TODO: final response = await AuthRepository().deleteUser();
    loader.hide();

    // TODO: if (response.status == true) {
    AppBottomSheet(
      title: "Conta apagada",
      message: "Sua conta foi apagada com sucesso.",
    ).show(context);
    // } else {
    //   // ignore: avoid_print
    //   print(response);
    // }
  }
}
