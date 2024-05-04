import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/store/user.dart';
import 'package:flutter/material.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({Key? key}) : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  bool _isLoading = false;
  UserStore userStore = UserStore();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus dados'),
      ),
      body: _isLoading
          ? Loader().pageLoading()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                const SizedBox(height: 10),
                _photo(userStore.user.profilePicture),
                const SizedBox(height: 20),
                Text('Dados pessoais',
                    style: TextStyle(color: StyleManager.instance.primary)),
                Divider(color: StyleManager.instance.primary),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Usuário: ',
                        style: TextStyle(color: StyleManager.instance.primary)),
                    Text(userStore.user.name ?? '',
                        style: TextStyle(color: StyleManager.instance.primaryText)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Text('Email: ',
                      style: TextStyle(color: StyleManager.instance.primary)),
                  Text(userStore.user.email ?? '',
                      style: TextStyle(color: StyleManager.instance.primaryText)),
                ],),
                const SizedBox(height: 5),
              ]),
            ),
    );
  }

  Widget _photo(String? userImage) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
          border: Border.all(color: StyleManager.instance.primary, width: 4),
          shape: BoxShape.circle),
      child: userImage == null
          ? Icon(Icons.person, color: StyleManager.instance.primary, size: 110)
          : ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(userImage)),
    );
  }

  _getUserInfo() async {
    setState(() => _isLoading = true);
    // TODO: await AuthRepository().getUserInfo();
    setState(() => _isLoading = false);
  }
}
