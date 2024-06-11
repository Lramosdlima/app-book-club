import 'package:bookclub/common/bottom_sheet.dart';
import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
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

  late bool _passwordVisible;
  late bool _confirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Expanded(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // margin: const EdgeInsets.all(24),
            child: Column(children: [
              _header(),
              const SizedBox(height: 30),
              _inputFields(),
              const SizedBox(height: 30),
              _loginInfo(),
            ]),
          ),
        ),
      ),
    ));
  }

  _header() {
    return Column(
      children: [
        const Text(
          "Criar conta",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const Text("Coloque as informções para começar"),
        const SizedBox(height: 20),
        _icon(),
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
          _nameFormField(),
          const SizedBox(height: 10),
          _emailFormField(),
          const SizedBox(height: 10),
          _passwordFormField(),
          const SizedBox(height: 10),
          _confirmPasswordFormField(),
          const SizedBox(height: 30),
          AppButton(text: "Criar conta", onPressed: _register),
        ],
      ),
    );
  }

  _nameFormField() {
    return TextFormField(
      controller: _usernameController,
      validator: Validator().validateName,
      decoration: const InputDecoration(
        hintText: "Digite seu nome de usuário...",
        labelText: "Nome de usuário",
        icon: Icon(Icons.person),
      ),
    );
  }

  _emailFormField() {
    return TextFormField(
      controller: _emailController,
      validator: Validator().validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "Digite seu email...",
        labelText: "Email",
        icon: Icon(Icons.email_outlined),
      ),
    );
  }

  _passwordFormField() {
    return TextFormField(
      controller: _passwordController,
      validator: Validator().validatePassword,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        hintText: "Digite sua senha...",
        labelText: "Senha",
        icon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible == true ? Icons.visibility : Icons.visibility_off,
            color: StyleManager.instance.primaryText,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  _confirmPasswordFormField() {
    return TextFormField(
      controller: _confirmPasswordController,
      validator: Validator().validatePassword,
      obscureText: !_confirmPasswordVisible,
      decoration: InputDecoration(
        hintText: "Digite novamente sua senha...",
        labelText: "Confirmar senha",
        icon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _confirmPasswordVisible == true
                ? Icons.visibility
                : Icons.visibility_off,
            color: StyleManager.instance.primaryText,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: StyleManager.instance.primary, width: 2),
          shape: BoxShape.circle),
      child:
          Icon(Icons.person, color: StyleManager.instance.primary, size: 120),
    );
  }

  _loginInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Já tem uma conta?"),
        TextButton(
            onPressed: _goToLogin,
            child: Text("Login",
                style: TextStyle(color: StyleManager.instance.tertiary)))
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
        Modal().successAlert(
          "Conta criada com sucesso! Faça login para continuar.",
          context,
        );
        _goToLogin();
      } else {
        Modal().errorAlert(response.error, context);
      }
    }
  }

  _goToLogin() {
    Navigator.pushNamed(context, AppRoutes.LOGIN);
  }
}
