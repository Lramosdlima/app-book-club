import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:bookclub/view/admin/admin.dart';
import 'package:bookclub/view/auth/login.dart';
import 'package:bookclub/view/auth/signup.dart';
import 'package:bookclub/view/home/collection/collection.dart';
import 'package:bookclub/view/home/collection/collection_books.dart';
import 'package:bookclub/view/home/collection/my_collections.dart';
import 'package:bookclub/view/home/discontinued_pages/book.dart';
import 'package:bookclub/view/home/discontinued_pages/create_collection.dart';
import 'package:bookclub/view/home/discontinued_pages/favorite_books.dart';
import 'package:bookclub/view/home/discontinued_pages/profile_detail.dart';
import 'package:bookclub/view/home/home.dart';
import 'package:bookclub/view/onboarding/onboarding.dart';
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
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      themeMode: ThemeMode.dark,
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
        AppRoutes.COLLECTION_FORM: (_) => const CreateCollectionPage(),
        AppRoutes.FAVORITE_BOOK: (_) => const FavoriteBook(),
        // PROFILE ROUTES
        AppRoutes.PROFILE_DETAIL: (_) => const ProfileDetailPage(),
        // COLLECTION ROUTES
        AppRoutes.COLLECTION: (_) => const CollectionPage(),
        AppRoutes.COLLECTION_BOOKS: (_) => const CollectionBooksPage(),
        AppRoutes.MY_COLLECTION: (_) => const MyCollectionPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
