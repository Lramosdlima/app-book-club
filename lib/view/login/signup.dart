// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bookclub/common/text_field.dart';
import 'package:bookclub/view/home/home.dart';
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
        margin: EdgeInsets.all(24),
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
    return Column(
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
        SizedBox(height: 10),
        AppTextField(
            controller: emailController,
            hintText: 'E-mail',
            icon: Icons.email_outlined),
        SizedBox(height: 10),
        AppTextField(
            controller: passwordController,
            hintText: "Senha",
            icon: Icons.password_outlined,
            isPassword: true),
        SizedBox(height: 10),
        AppTextField(
            controller: confirmPasswordController,
            hintText: "Confirmar senha",
            icon: Icons.password_outlined),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            "Criar",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  _loginInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Já tem uma conta?"),
        TextButton(onPressed: () {}, child: Text("Login"))
      ],
    );
  }
}
