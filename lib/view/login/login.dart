import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          TColor.primaryLight,
          TColor.primary,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50),
            AppTextField(
              controller: usernameController,
              hintText: "Usuário",
              icon: Icons.person,
            ),
            const SizedBox(height: 20),
            AppTextField(
                controller: passwordController,
                hintText: "Senha",
                icon: Icons.password_outlined,
                isPassword: true),
            const SizedBox(height: 50),
            AppButton(
              text: "Entrar",
              backgroundColor: Colors.white,
              textColor: TColor.primary,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            const SizedBox(height: 20),
            _extraText(),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _extraText() {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/signup');
        },
        child: Text(
          "Não consegue acessar sua conta?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: TColor.primaryTextWhite),
        ));
  }
}
