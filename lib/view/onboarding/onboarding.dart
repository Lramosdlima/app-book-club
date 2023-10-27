import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/view/onboarding/welcome.dart';
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
    // TODO: implement initState
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
    return Scaffold(
      // backgroundColor: Colors.white,
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
                          color: TColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.05),
                      Text(
                        pObj["sub_title"].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: TColor.primary,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                      Image.asset(
                        pObj["img"].toString(),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.fitWidth,
                      ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()));
                        },
                        child: Text(
                          "Pular",
                          style: TextStyle(
                              color: TColor.primary,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()));
                          }
                        },
                        child: Text(
                          "Próximo",
                          style: TextStyle(
                              color: TColor.primary,
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
    );
  }
}
