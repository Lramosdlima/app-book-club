import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/book/book.dart';
import 'package:bookclub/view/book/edit_book.dart';
import 'package:bookclub/view/admin/admin.dart';
import 'package:bookclub/view/home/favorite_books.dart';
import 'package:bookclub/view/home/home.dart';
import 'package:bookclub/view/login/login.dart';
import 'package:bookclub/view/login/signup.dart';
import 'package:bookclub/view/onboarding/onboarding.dart';
import 'package:bookclub/view/onboarding/welcome.dart';
import 'package:bookclub/view/profile/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: StyleManager.instance.primary,
        fontFamily: StyleManager.instance.fontFamily,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: StyleManager.instance.primary,
          secondary: StyleManager.instance.secondary,
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
        AppRoutes.ADMIN: (_) => const AdminPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
