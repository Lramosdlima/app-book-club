import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/book/book.dart';
import 'package:bookclub/view/book/edit_book.dart';
import 'package:bookclub/view/admin/admin.dart';
import 'package:bookclub/view/home/favorite_books.dart';
import 'package:bookclub/view/home/home.dart';
import 'package:bookclub/view/auth/login.dart';
import 'package:bookclub/view/auth/signup.dart';
import 'package:bookclub/view/onboarding/onboarding.dart';
import 'package:bookclub/view/profile/edit_profile.dart';
import 'package:bookclub/view/profile/profile.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //TODO: refresh token config

  // Widget firstPage = const OnboardPage();
  // var token = await StorageHelper.get('token');

  // if (token != null) {
  //   try {
  //     var response = await AuthRepository().refreshToken();
  //     if (response.status == true) {
  //       // ignore: avoid_print
  //       print('token refreshed');

  //       await AuthRepository().getUserInfo();
  //       firstPage = const HomePage();
  //     }
  //   } catch (e) {
  //     StorageHelper.remove('token');
  //   }
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        // INICIAL ROUTES
        AppRoutes.ONBOARDING: (_) => const OnboardingPage(),
        AppRoutes.LOGIN: (_) => const LoginPage(),
        AppRoutes.SIGNUP: (_) => const SignUpPage(),
        // HOME ROUTES
        AppRoutes.HOME: (_) => const HomePage(),
        AppRoutes.ADMIN: (_) => const AdminPage(),
        AppRoutes.PROFILE: (_) => const ProfilePage(),
        // BOOK ROUTES
        AppRoutes.BOOK: (_) => const BookPage(),
        AppRoutes.BOOK_FORM: (_) => const EditBookPage(),
        AppRoutes.FAVORITE_BOOK: (_) => const FavoriteBook(),
        // PROFILE ROUTES
        AppRoutes.EDIT_PROFILE: (_) => const EditProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
