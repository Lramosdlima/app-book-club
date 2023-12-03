import 'package:bookclub/common/StyleManager.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int page = 0;
  PageController? controller = PageController();
  List pageArr = [
    {
      "title": "Seja bem vindo!",
      "sub_title":
          "Esse aplicativo é indicado para você que quer ter um hábito de leitura!",
      "img": "assets/img/on_1.png"
    },
    {
      "title": "Como permanecer lendo?",
      "sub_title":
          "Aqui você encontra incentivos como quiz sobre seu livro favorito, interação com comunidade e vários desafios! Vamos juntos nessa jornada!",
      "img": "assets/img/on_2.png"
    },
  ];

  @override
  void initState() {
    super.initState();

    controller?.addListener(() {
      page = controller?.page?.round() ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: (context, index) {
              var pObj = pageArr[index] as Map? ?? {};
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    _text(pObj["title"].toString(), TextType.title),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    _text(pObj["sub_title"].toString(), TextType.subtitle),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    Image.asset(
                      pObj["img"].toString(),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.WELCOME);
                      },
                      child: _text("Pular", TextType.normal)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pageArr.map((pObj) {
                      var index = pageArr.indexOf(pObj);

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: page == index
                                ? StyleManager.instance.primary
                                : StyleManager.instance.primaryLight,
                            borderRadius: BorderRadius.circular(5)),
                      );
                    }).toList(),
                  ),
                  TextButton(
                    onPressed: () {
                      if (page < 1) {
                        page = page + 1;
                        controller?.jumpToPage(page);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.WELCOME);
                      }
                    },
                    child: _text("Próximo", TextType.normal),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    ));
  }

  _text(String text, TextType type) {
    double size = 0;
    bool bold = false;

    switch (type) {
      case TextType.title:
        size = 30;
        bold = true;
        break;
      case TextType.subtitle:
        size = 20;
        bold = false;
        break;
      case TextType.normal:
        size = 17;
        bold = false;
        break;
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        color: StyleManager.instance.primaryTextWhite,
        fontWeight: bold ? FontWeight.w600 : FontWeight.w300,
      ),
    );
  }
}

enum TextType { title, subtitle, normal }
