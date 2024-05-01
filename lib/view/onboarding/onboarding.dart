import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/text.dart';
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
      "title": "Será que o livro é bom?",
      "sub_title":
          "Todo tempo é precioso hoje em dia! Então antes de começar a ler um livro, que tal ver o que a galera acha sobre ele?",
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
                    AppText(
                      pObj["title"].toString(),
                      type: TextType.title,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    AppText(
                      pObj["sub_title"].toString(),
                      type: TextType.normal,
                    ),
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
                        _goToLogin();
                      },
                      child: const AppText("Pular", type: TextType.normal)),
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
                        _goToLogin();
                      }
                    },
                    child: const AppText("Próximo", type: TextType.normal),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    ));
  }

  _goToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
  }
}
