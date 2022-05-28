


import 'package:get/state_manager.dart';
import '../models/my_courses_model.dart';
import '../services/remote_services.dart';


class MyCoursesController extends GetxController {

  var isLoading = true.obs;
  var myCoursesList = <MyCoursesModel>[].obs;

  @override
  void onInit() {
    fetchMyCourses();
    super.onInit();
  }

  void fetchMyCourses() async {
    try {
      isLoading(true);
      var myCourses = await RemoteServices.fetchMyCourses();
      if (myCourses != null) {
        isLoading(false);
        myCoursesList.value = myCourses;
      }
    } finally {
      isLoading(false);
    }
  }

}