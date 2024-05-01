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
                const SizedBox(height: 20),
                Text('Dados pessoais',
                    style: TextStyle(color: StyleManager.instance.primary)),
                Divider(color: StyleManager.instance.primary),
                const SizedBox(height: 10),
                Text('Nome: ${userStore.user.name ?? ''}',
                    style: TextStyle(
                        color: StyleManager.instance.primaryText)),
                const SizedBox(height: 5),
                Text('Email: ${userStore.user.email ?? ''}',
                    style: TextStyle(
                        color: StyleManager.instance.primaryText)),
                const SizedBox(height: 5),
              ]),
            ),
    );
  }

  _getUserInfo() async {
    setState(() => _isLoading = true);
    // TODO: await AuthRepository().getUserInfo();
    setState(() => _isLoading = false);
  }
}
