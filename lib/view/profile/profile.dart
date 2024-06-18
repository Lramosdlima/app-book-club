import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bookclub/common/card.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/text.dart';
import 'package:bookclub/repository/auth.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/store/user.dart';
import 'package:bookclub/view/home/collection/collection_added.dart';
import 'package:bookclub/view/profile/favorite_added.dart';
import 'package:bookclub/view/profile/my_comments.dart';
import 'package:bookclub/view/profile/readed.dart';
import 'package:bookclub/view/profile/wanttoread_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserStore userStore = UserStore();
  Loader loader = Loader();
  // bool _notification = true;

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
              _myProfile(),
              const SizedBox(height: 30),
              Text('Suas Interações',
                  style: TextStyle(color: StyleManager.instance.primary)),
              Divider(color: StyleManager.instance.primary),
              const SizedBox(height: 10),
              // TODO: Criar uma funcionalidade de notificação
              // ListTile(
              //   leading: const Icon(Icons.notifications),
              //   title: const Text('Notificações'),
              //   trailing: Switch(
              //     value: _notification,
              //     onChanged: (value) {
              //       setState(() {
              //         _notification = value;
              //       });
              //     },
              //   ),
              // ),
              AppCard(
                  title: 'Avaliações',
                  icon: Icons.star,
                  onPressed: () {
                    userStore.user.id == null
                        ? _showNecessaryLogin(context)
                        : _goToMyComments();
                  }),
              AppCard(
                  title: 'Coleções Adicionadas',
                  icon: Icons.local_library,
                  onPressed: () {
                    userStore.user.id == null
                        ? _showNecessaryLogin(context)
                        : _goToCollectionAdded();
                  }),
              AppCard(
                  title: 'Favoritos',
                  icon: Icons.favorite,
                  onPressed: () {
                    userStore.user.id == null
                        ? _showNecessaryLogin(context)
                        : _goToFavoriteAdded();
                  }),
              AppCard(
                  title: 'Já Lidos',
                  icon: Icons.bookmark,
                  onPressed: () {
                    userStore.user.id == null
                        ? _showNecessaryLogin(context)
                        : _goToReaded();
                  }),
              AppCard(
                  title: 'Quero Ler',
                  icon: Icons.book,
                  onPressed: () {
                    userStore.user.id == null
                        ? _showNecessaryLogin(context)
                        : _goToWantToReadAdded();
                  }),
              const SizedBox(height: 30),
              userStore.user.id == null
                  ? const SizedBox()
                  : _yourAccount(context),
              userStore.user.id == null
                  ? const SizedBox()
                  : AppCard(
                      title: 'Sair',
                      icon: Icons.exit_to_app,
                      onPressed: _logOut,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return const Icon(Icons.person, color: Colors.white, size: 30);
  }

  _myProfile() {
    return Column(children: [
      _photo(userStore.user.profile_picture),
      const SizedBox(height: 20),
      Text('Dados da Conta',
          style: TextStyle(color: StyleManager.instance.primary)),
      Divider(color: StyleManager.instance.primary),
      const SizedBox(height: 10),
      userStore.user.id == null
          ? AppCard(
              title: 'Fazer Login',
              icon: Icons.person,
              onPressed: () {
                _goToLogin();
              },
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Usuário: ',
                        style: TextStyle(color: StyleManager.instance.primary)),
                    Text(userStore.user.name ?? '',
                        style: TextStyle(
                            color: StyleManager.instance.primaryText)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Email: ',
                        style: TextStyle(color: StyleManager.instance.primary)),
                    Text(userStore.user.email ?? '',
                        style: TextStyle(
                            color: StyleManager.instance.primaryText)),
                  ],
                ),
              ],
            ),
    ]);
  }

  Widget _photo(String? userImage) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
          border: Border.all(color: StyleManager.instance.primary, width: 4),
          shape: BoxShape.circle),
      child: userImage == null
          ? Icon(Icons.auto_stories,
              color: StyleManager.instance.primary, size: 110)
          : ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(userImage)),
    );
  }

  _goToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
  }

  _goToMyComments() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyCommentsPage()),
    );
  }

  _goToCollectionAdded() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CollectionAddedPage()),
    );
  }

  _goToFavoriteAdded() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoriteAddedPage()),
    );
  }

  _goToReaded() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ReadedPage()),
    );
  }

  _goToWantToReadAdded() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WantToReadPage()),
    );
  }

  _logOut() {
    AuthRepository().logout();
    userStore.clearUserData();
    Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
  }

  _yourAccount(context) {
    return Column(
      children: [
        Text('Sua Conta',
            style: TextStyle(color: StyleManager.instance.primary)),
        Divider(color: StyleManager.instance.primary),
        const SizedBox(height: 10),
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
          color: Colors.red,
          onPressed: _confirmDeleteUserData,
        ),
      ],
    );
  }

  _confirmDeleteUserData() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: "Apagar conta?",
      desc:
          "Deseja realmente apagar sua conta? Essa operação não poderá ser desfeita.",
      reverseBtnOrder: true,
      btnOkText: "Apagar",
      btnOkColor: Colors.red,
      btnCancelText: "Não",
      btnCancelColor: Colors.grey,
      btnOkOnPress: () {
        _deleteUserData();
      },
      btnCancelOnPress: () {},
    ).show();
  }

  _deleteUserData() async {
    loader.show(context);
    // TODO: final response = await AuthRepository().deleteUser();
    loader.hide();

    // TODO: if (response.status == true) {
    _logOut();

    // } else {
    //   // ignore: avoid_print
    //   print(response);
    // }
  }

  _showNecessaryLogin(context) {
    Modal().showNecessaryLogin(context);
  }
}
