import 'package:bookclub/common/bottom_sheet.dart';
import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/validator.dart';
import 'package:bookclub/repository/auth.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  Loader loader = Loader();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _header(),
          _inputFields(),
          _loginInfo(),
        ]),
      ),
    ));
  }

  _header() {
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

  _inputFields() {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _usernameController,
            validator: Validator().validateName,
            decoration: const InputDecoration(
              hintText: "Nome de usuário",
              labelText: "Nome de usuário",
              icon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            validator: Validator().validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Usuário",
              labelText: "Usuário",
              icon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            validator: Validator().validatePassword,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Senha",
              labelText: "Senha",
              icon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _confirmPasswordController,
            validator: Validator().validatePassword,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Confirmar senha",
              labelText: "Confirmar senha",
              icon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 30),
          AppButton(text: "Criar conta", onPressed: _register),
        ],
      ),
    );
  }

  _loginInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Já tem uma conta?"),
        TextButton(onPressed: _goToLogin, child: const Text("Login"))
      ],
    );
  }

  _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      AppBottomSheet().errorAlert("As senhas não estão iguais!", context);
      return;
    }

    if (_formkey.currentState?.validate() == true &&
        _formkey.currentState != null) {
      _formkey.currentState?.save();

      loader.show(context);

      final response = await AuthRepository().register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );

      loader.hide();

      if (response.status == true) {
        AppBottomSheet().successAlert(
            "Conta criada com sucesso! Faça login para continuar.",
            context,
            _goToLogin());
      } else {
        AppBottomSheet().errorAlert(response.error, context);
      }
    }
  }

  _goToLogin() {
    Navigator.pushNamed(context, AppRoutes.LOGIN);
  }
}
