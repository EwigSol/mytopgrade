


import 'package:get/get.dart';
import 'package:topgrade/routes/appPages.dart';
import '../main.dart';
import '../views/bottombar/home_bottombar.dart';
import '../views/screens/auth/forgot_password_screen.dart';
import '../views/screens/auth/otp_verification_screen.dart';
import '../views/screens/onboarding/onboarding_screen.dart';
import '../views/screens/splash/splash_screen.dart';
import '../views/widgets/auth_toggle_view.dart';



class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static const initial = Routes.initial;

  static final routes = [
    GetPage(name: Paths.initial, page: () => const App(), transition: Transition.zoom),
    GetPage(name: Paths.splash, page: () => const SplashScreen(), transition: Transition.zoom),
    GetPage(name: Paths.authView, page: () => const AuthToggleView(), transition: Transition.fadeIn),
    GetPage(name: Paths.onBoard, page: () => const OnboardingScreen(), transition: Transition.fade),
    GetPage(name: Paths.forgotPass, page: () => ForgotPasswordScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: Paths.otpVerify, page: () => const OtpVerificationScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: Paths.homeBar, page: () => const HomeBottomBar(), transition: Transition.fadeIn),
  ];
}

