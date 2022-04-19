


import 'package:get/get.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/views/screens/home/home_screen.dart';
import '../main.dart';
import '../views/screens/auth/forgot_password_screen.dart';
import '../views/screens/auth/login_screen.dart';
import '../views/screens/auth/register_screen.dart';
import '../views/screens/splash/splash_screen.dart';



class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static const initial = Routes.initial;

  static final routes = [
    GetPage(name: Paths.initial, page: () => const App(), transition: Transition.zoom),
    GetPage(name: Paths.splash, page: () => const SplashScreen(), transition: Transition.zoom),
    GetPage(name: Paths.login, page: () => const LoginScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: Paths.register, page: () => const RegisterScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: Paths.forgotPass, page: () => const ForgotPasswordScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: Paths.home, page: () => const HomeScreen(), transition: Transition.fadeIn),
  ];
}

