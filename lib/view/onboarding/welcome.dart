import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/color_extension.dart';
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
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
                SizedBox(height: MediaQuery.of(context).size.width * 0.30),
                AppButton(
                    text: "Entrar",
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    }),
                SizedBox(height: MediaQuery.of(context).size.width * 0.10),
                AppButton(
                    text: "Cadastrar",
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    }),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
