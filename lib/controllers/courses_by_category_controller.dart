


import 'package:get/state_manager.dart';
import 'package:topgrade/models/courses_model.dart';
import '../services/remote_services.dart';


class CoursesByCategoryController extends GetxController {

  var isLoading = true.obs;
  var coursesByCategoryList = <CoursesModel>[].obs;

  @override
  void onInit() {
    // fetchAllCoursesByCategory();
    super.onInit();
  }

  void fetchAllCoursesByCategory(String id) async {
    try {
      isLoading(true);
      var coursesByCat = await RemoteServices.fetchCoursesByCategory(id);
      if (coursesByCat != null) {
        isLoading(false);
        coursesByCategoryList.value = coursesByCat;
      }
    } finally {
      isLoading(false);
    }
  }

}