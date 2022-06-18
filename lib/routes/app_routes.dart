import 'package:get/get.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/views/bottombar/home_bottombar.dart';
import 'package:topgrade/views/screens/auth/forgot_password_screen.dart';
import 'package:topgrade/views/screens/auth/otp_verification_screen.dart';
import 'package:topgrade/views/screens/cart/cart_screen.dart';
import 'package:topgrade/views/screens/category/categories_screen.dart';
import 'package:topgrade/views/screens/checkout/checkout_screen.dart';
import 'package:topgrade/views/screens/checkout/widgets/add_new_card.dart';
import 'package:topgrade/views/screens/details/details_screen.dart';
import 'package:topgrade/views/screens/instructor/instructors_screen.dart';
import 'package:topgrade/views/screens/lessons/lessons_screen.dart';
import 'package:topgrade/views/screens/notification/notifications_screen.dart';
import 'package:topgrade/views/screens/onboarding/onboarding_screen.dart';
import 'package:topgrade/views/screens/payment/payment_screen.dart';
import 'package:topgrade/views/screens/payment/payment_success_screen.dart';
import 'package:topgrade/views/screens/popular/popular_courses_screen.dart';
import 'package:topgrade/views/screens/profile/update_profile_screen.dart';
import 'package:topgrade/views/screens/splash/splash_screen.dart';
import 'package:topgrade/views/widgets/auth_toggle_view.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static const initial = Routes.initial;

  static final routes = [
    // GetPage(name: Paths.initial, page: () => const App(), transition: Transition.zoom),
    GetPage(
        name: Paths.initial,
        page: () => const SplashScreen(),
        transition: Transition.zoom),
    GetPage(
        name: Paths.authView,
        page: () => const AuthToggleView(),
        transition: Transition.fadeIn),
    GetPage(
        name: Paths.onBoard,
        page: () => const OnboardingScreen(),
        transition: Transition.fade),
    GetPage(
        name: Paths.forgotPass,
        page: () => ForgotPasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Paths.otpVerify,
        page: () => const OtpVerificationScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Paths.homeBar,
        page: () => const HomeBottomBar(),
        transition: Transition.fadeIn),
    GetPage(
        name: Paths.allCat,
        page: () => CategoriesScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: Paths.allPopular,
        page: () => const PopularCoursesScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: Paths.alInstructor,
        page: () => const BestInstructorScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: Paths.notify,
        page: () => const NotificationsScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: Paths.updateProfile,
        page: () => const UpdateProfileScreen(),
        transition: Transition.rightToLeftWithFade),
    // GetPage(name: Paths.chat, page: () => const ChatScreen(), transition: Transition.zoom),
    GetPage(
        name: Paths.details,
        page: () => DetailsScreen(
              isWishlist: false,
            ),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Paths.cart,
        page: () => const CartScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Paths.checkout,
        page: () => const CheckoutScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Paths.addNC,
        page: () => const AddNewCard(),
        transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: Paths.lessons,
    //     page: () => LessonsScreen(),
    //     transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Paths.payment,
        page: () => const PaymentScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Paths.paymentSuccess,
        page: () => const PaymentSuccessScreen(),
        transition: Transition.rightToLeftWithFade),
  ];
}
