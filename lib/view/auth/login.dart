import 'package:bookclub/common/bottom_sheet.dart';
import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/loader.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/text.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _passwordVisible;
  Loader loader = Loader();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/img/welcome.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bem vindo ao app",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: StyleManager.instance.primaryTextWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Book Club!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: StyleManager.instance.primaryTextWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    _logo(),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    _form(),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    _signUpInfo(),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    _withoutLogin(),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget _logo() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          shape: BoxShape.circle),
      child: const Icon(Icons.auto_stories, color: Colors.white, size: 110),
    );
  }

  Widget _form() {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailFormField(),
          const SizedBox(height: 20),
          _passwordFormField(),
          const SizedBox(height: 40),
          AppButton(
            text: "Entrar",
            onPressed: _login,
          )
        ],
      ),
    );
  }

  _emailFormField() {
    return TextFormField(
      controller: _emailController,
      validator: Validator().validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "Email",
        labelText: "Email",
        icon: Icon(Icons.email),
      ),
    );
  }

  _passwordFormField() {
    return TextFormField(
      controller: _passwordController,
      validator: Validator().validatePassword,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        hintText: "Senha",
        labelText: "Senha",
        icon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible == true ? Icons.visibility : Icons.visibility_off,
            color: StyleManager.instance.primaryTextWhite,
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

  _signUpInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppText("Ainda não tem conta?"),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.SIGNUP);
          },
          child: const Row(
            children: [
              Text("Criar nova conta"),
              SizedBox(width: 6),
              Icon(Icons.person, size: 16)
            ],
          ),
        )
      ],
    );
  }

  _withoutLogin() {
    var secondaryColor = StyleManager.instance.secondaryText;
    return TextButton(
      onPressed: _goToHome,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Acessar sem login", style: TextStyle(color: secondaryColor)),
          const SizedBox(width: 6),
          Icon(Icons.arrow_forward_ios, size: 16, color: secondaryColor)
        ],
      ),
    );
  }

  _login() async {
    if (_formkey.currentState?.validate() == true &&
        _formkey.currentState != null) {
      _formkey.currentState?.save();

      loader.show(context);

      final response = await AuthRepository()
          .login(_emailController.text, _passwordController.text);

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
