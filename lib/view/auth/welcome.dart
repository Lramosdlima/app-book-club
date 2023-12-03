import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                padding: const EdgeInsets.all(30.0),
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
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    _logo(),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.11),
                    AppButton(
                        text: "Entrar",
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.LOGIN);
                        }),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    AppButton(
                        text: "Cadastrar",
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.SIGNUP);
                        }),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.HOME);
                        },
                        child: Text(
                          "Acessar sem login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: StyleManager.instance.primaryTextWhite),
                        )),
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
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          shape: BoxShape.circle),
      child: const Icon(Icons.auto_stories, color: Colors.white, size: 120),
    );
  }
}
