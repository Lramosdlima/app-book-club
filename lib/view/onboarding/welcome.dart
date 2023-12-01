import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

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
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 150, right: 150, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bem vindo ao app",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TColor.primaryTextWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Book Club!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TColor.primaryTextWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  _icon(),
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
                        Navigator.pushReplacementNamed(context, AppRoutes.HOME);
                      },
                      child: Text(
                        "Acessar sem login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: TColor.primaryTextWhite),
                      )),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget _icon() {
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
