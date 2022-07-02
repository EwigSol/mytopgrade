import 'package:get/get.dart';
import 'package:mytopgrade/controllers/courses_controller.dart';
import 'package:mytopgrade/controllers/lesson_byId_controller.dart';

class AllBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LessonByIDController>(() => LessonByIDController());
    Get.lazyPut<CoursesController>(() => CoursesController());
  }
}
