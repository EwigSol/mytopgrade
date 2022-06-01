


import 'package:get/state_manager.dart';
import 'package:topgrade/models/courses_model.dart';
import '../services/remote_services.dart';


class CoursesController extends GetxController {

  var isLoading = true.obs;
  var coursesList = <CoursesModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchAllCourses();
    super.onInit();
  }

  void fetchAllCourses() async {
    try {
      isLoading(true);
      var courses = await remoteServices.fetchCourses();
      if (courses != null) {
        isLoading(false);
        coursesList.value = courses;
      }
    } finally {
      isLoading(false);
    }
  }

}