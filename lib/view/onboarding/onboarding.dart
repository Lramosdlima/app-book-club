import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

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
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            TColor.primaryLight,
            TColor.secondary,
          ],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                          Text(
                            pObj["title"].toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: TColor.primaryTextWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                          Text(
                            pObj["sub_title"].toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: TColor.primaryTextWhite,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                          Image.asset(
                            pObj["img"].toString(),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.width * 0.7,
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.1),
                        ],
                      ),
                    );
                  }),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.WELCOME);
                            },
                            child: Text(
                              "Pular",
                              style: TextStyle(
                                  color: TColor.primaryTextWhite,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            )),
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
                                      ? TColor.primary
                                      : TColor.primaryLight,
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
                            child: Text(
                              "Próximo",
                              style: TextStyle(
                                  color: TColor.primaryTextWhite,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                ],
              )
            ]),
          ),
        ));
  }
}
