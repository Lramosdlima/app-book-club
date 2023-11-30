import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/view/login/signup.dart';
import 'package:bookclub/view/login/login.dart';
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
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                const Text(
                  "Bem vindo ao app\nBook Club!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.25),
                MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    textColor: Colors.white,
                    color: TColor.primary,
                    minWidth: double.maxFinite,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    )),
                SizedBox(height: MediaQuery.of(context).size.width * 0.10),
                MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    textColor: Colors.white,
                    color: TColor.primary,
                    minWidth: double.maxFinite,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    )),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
