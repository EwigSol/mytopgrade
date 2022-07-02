import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/controllers/assignment_byID_controller.dart';
import 'package:mytopgrade/controllers/course_byId_controller.dart';
import 'package:mytopgrade/controllers/quiz_byID_controller.dart';
import 'package:mytopgrade/controllers/wishlist_controller.dart';
import 'package:mytopgrade/routes/app_routes.dart';
import 'package:get/get.dart';

import 'Bindings/AllBindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  Get.put(CourseByIDController());
  Get.put(QuizByIDController());
  Get.put(AssignmentByIDController());
  Get.put(WishlistController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllBindings(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
