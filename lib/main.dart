
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/routes/app_routes.dart';
import 'package:topgrade/views/screens/auth/login_screen.dart';
import 'package:topgrade/views/screens/splash/init_screen.dart';
import 'package:topgrade/views/screens/splash/splash_screen.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.initial,
            getPages: AppRoutes.routes,
          );
        }
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
