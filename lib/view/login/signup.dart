import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/text_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _header(context),
          _inputFields(context),
          _loginInfo(context),
        ]),
      ),
    ));
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Criar conta",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Coloque as informções para começar"),
      ],
    );
  }

  _inputFields(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
            controller: usernameController,
            hintText: "Nome de usuário",
            icon: Icons.person),
        const SizedBox(height: 10),
        AppTextField(
            controller: emailController,
            hintText: 'E-mail',
            icon: Icons.email_outlined),
        const SizedBox(height: 10),
        AppTextField(
            controller: passwordController,
            hintText: "Senha",
            icon: Icons.password_outlined,
            isPassword: true),
        const SizedBox(height: 10),
        AppTextField(
            controller: confirmPasswordController,
            hintText: "Confirmar senha",
            icon: Icons.password_outlined),
        const SizedBox(height: 30),
        AppButton(
            text: "Criar conta",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            }),
      ],
    );
  }

  _loginInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Já tem uma conta?"),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text("Login"))
      ],
    );
  }
}
