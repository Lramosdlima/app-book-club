import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/modal.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/validator.dart';
import 'package:bookclub/repository/auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  Loader loader = Loader();

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
      appBar: AppBar(
        title: const Text("Alterar Senha"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Expanded(
            child: Column(children: [
              _header(),
              const SizedBox(height: 30),
              _inputFields(),
            ]),
          ),
        ),
      ),
    ));
  }

  _header() {
    return const Column(
      children: [
        Text(
            "Digite abaixo as informações abaixo para alterar a sua senha. Use uma senha forte que contenha caracteres e números."),
        SizedBox(height: 20),
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
          _passwordFormField(),
          const SizedBox(height: 10),
          _confirmPasswordFormField(),
          const SizedBox(height: 50),
          AppButton(text: "Alterar Senha", onPressed: _changePassword),
        ],
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

  _changePassword() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      Modal().alertAlert("As senhas não estão iguais!", context);
      return;
    }

    // if (_formkey.currentState?.validate() == true &&
    //     _formkey.currentState != null) {
    //   _formkey.currentState?.save();

    //   loader.show(context);

    //   final response = await AuthRepository().changePassword(
    //     _passwordController.text,
    //   );

    //   loader.hide();

    //   if (response.status == true) {
    //     Modal().successAlert(
    //       "Conta criada com sucesso! Faça login para continuar.",
    //       context,
    //     );
    //     Navigator.pop(context);
    //   } else {
    //     Modal().errorAlert(response.error, context);
    //   }
    // }
  }
}
