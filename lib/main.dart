import 'package:bookclub/common/color_extension.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/book/book.dart';
import 'package:bookclub/view/book/editBook.dart';
import 'package:bookclub/view/explore/explore.dart';
import 'package:bookclub/view/home/favoriteBooks.dart';
import 'package:bookclub/view/home/home.dart';
import 'package:bookclub/view/login/login.dart';
import 'package:bookclub/view/login/signup.dart';
import 'package:bookclub/view/onboarding/onboarding.dart';
import 'package:bookclub/view/onboarding/welcome.dart';
import 'package:bookclub/view/profile/profile.dart';
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
      routes: {
        AppRoutes.ONBOARDING: (_) => const OnboardingPage(),
        AppRoutes.WELCOME: (_) => const WelcomePage(),
        AppRoutes.LOGIN: (_) => const LoginPage(),
        AppRoutes.SIGNUP: (_) => SignUpPage(),
        AppRoutes.HOME: (_) => HomePage(),
        AppRoutes.PROFILE: (_) => const ProfilePage(),
        AppRoutes.BOOK: (_) => BookPage(),
        AppRoutes.BOOK_FORM: (_) => EditBookPage(),
        AppRoutes.FAVORITE_BOOK: (_) => FavoriteBook(),
        AppRoutes.EXPLORE: (_) => const ExplorePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
