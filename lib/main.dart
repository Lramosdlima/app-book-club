import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/view/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: TColor.primary,
        fontFamily: TColor.fontFamily,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: TColor.primary,
          secondary: TColor.secondary,
        ),
        brightness: Brightness.dark,
      ),
      title: 'Book Club',
      home: const OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
