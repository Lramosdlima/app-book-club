import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/common/validator.dart';
import 'package:bookclub/repository/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Loader loader = Loader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          TColor.primaryLight,
          TColor.secondary,
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
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 50),
              TextFormField(
                controller: _usernameController,
                validator: Validator().validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Usuário",
                  labelText: "Usuário",
                  icon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 50),
              AppButton(
                text: "Entrar",
                backgroundColor: Colors.white,
                textColor: TColor.primary,
                onPressed: _login,
              ),
              const SizedBox(height: 20),
              _extraText(),
            ],
          ),
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

  _login() async {
    if (_key.currentState?.validate() != null) {
      _key.currentState?.save();
      loader.show(context);

      final response = await AuthRepository()
          .login(_usernameController.text, _passwordController.text);

      loader.hide();

      if (response.status == true) {
        _goToHome();
      } else {
        // ignore: use_build_context_synchronously
        var modal =
            Modal(title: "Ops...", message: response.error).setAlert(context);
        modal.show(context);
      }
    }
  }

  _goToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
