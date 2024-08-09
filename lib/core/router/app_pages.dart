import 'package:get/get.dart';
import 'package:spotify/core/router/app_routes.dart';
import 'package:spotify/feature/home/presentation/pages/root_page.dart';
import 'package:spotify/feature/authentication/presentation/pages/signin.dart';
import 'package:spotify/feature/authentication/presentation/pages/signup.dart';
import 'package:spotify/feature/authentication/presentation/pages/welcome.dart';

class AppPages {
  static const initial = Routes.authPage;

  static final routes = [
    GetPage(name: Routes.authPage, page: () => AuthPage()),
    GetPage(name: Routes.signInPage, page: () => SignInPage()),
    GetPage(name: Routes.signUpPage, page: () => SignUpPage()),
    GetPage(name: Routes.homePage, page: () => RootPage()),
  ];
}
