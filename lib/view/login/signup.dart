import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/validator.dart';
import 'package:bookclub/repository/auth.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _key = GlobalKey();
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
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(),
                _inputFields(),
                _loginInfo(),
              ]),
        ),
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
    return Column(
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
      // ignore: use_build_context_synchronously
      var modal = Modal(
              title: "Ops...",
              message: "As senhas não conferem, por favor tente novamente.")
          .setAlert(context);
      modal.show(context);
      return;
    }

    if (_key.currentState?.validate() != null) {
      _key.currentState?.save();
      loader.show(context);

      final response = await AuthRepository().register(_usernameController.text,
          _emailController.text, _passwordController.text);

      loader.hide();

      if (response.status == true) {
        _goToLogin();
      } else {
        // ignore: use_build_context_synchronously
        var modal =
            Modal(title: "Ops...", message: response.error).setAlert(context);
        modal.show(context);
      }
    }
  }

  _goToLogin() {
    Navigator.pushNamed(context, AppRoutes.LOGIN);
  }
}
