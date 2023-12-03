import 'package:bookclub/common/bottom_sheet.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/StyleManager.dart';
import 'package:bookclub/common/validator.dart';
import 'package:bookclub/repository/auth.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Loader loader = Loader();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Form(
          key: _formkey,
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
          AppBottomSheet(
            title: "Não consegue acessar sua conta?",
            message: "Entre em contato com o administrador do sistema.",
            type: BottomSheetType.info,
          ).show(context);
        },
        child: Text(
          "Não consegue acessar sua conta?",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, color: StyleManager.instance.primaryTextWhite),
        ));
  }

  _login() async {
    if (_formkey.currentState?.validate() == true &&
        _formkey.currentState != null) {
      _formkey.currentState?.save();

      loader.show(context);

      final response = await AuthRepository()
          .login(_usernameController.text, _passwordController.text);

      loader.hide();

      if (response.status == true) {
        _goToHome();
      } else {
        AppBottomSheet().errorAlert(response.error, context);
      }
    }
  }

  _goToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.HOME);
  }
}
