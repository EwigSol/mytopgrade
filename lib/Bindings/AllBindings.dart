import 'package:get/get.dart';
import 'package:topgrade/controllers/lesson_byId_controller.dart';

class AllBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LessonByIDController>(() => LessonByIDController());
  }
}
