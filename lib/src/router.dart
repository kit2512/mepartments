import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mepartments/src/pages/home/home_bindings.dart';
import 'package:mepartments/src/pages/login/login_bindings.dart';

import 'pages/login/login_page.dart';
import 'pages/home/home_page.dart';
import 'pages/signup/sign_up_page.dart';
import 'pages/splash/splash_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String splash = '/splash';
  static const String home = '/home';

  static const String signUp = '/sign-up';

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      binding: LoginBindings(),
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: home,
      binding: HomeBindings(),
      page: () => const HomePage(),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpPage(),
    ),
  ];
}
