import 'package:get/get.dart';
import 'package:mytopgrade/controllers/InProgressController.dart';
import 'package:mytopgrade/controllers/courses_controller.dart';
import 'package:mytopgrade/controllers/lesson_byId_controller.dart';
import 'package:mytopgrade/controllers/my_all_courses_controller.dart';
import 'package:mytopgrade/controllers/userController/userController.dart';
import 'package:mytopgrade/controllers/wishlist_controller.dart';

class AllBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LessonByIDController>(() => LessonByIDController());
    Get.lazyPut<CoursesController>(() => CoursesController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<WishlistController>(() => WishlistController(), fenix: true);
    Get.lazyPut<MyAllCoursesController>(() => MyAllCoursesController(),
        fenix: true);
    Get.lazyPut<InProgressController>(() => InProgressController(),
        fenix: true);
  }
}
