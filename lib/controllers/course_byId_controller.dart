


import 'package:get/state_manager.dart';
import 'package:topgrade/models/course_by_id_model.dart';
import '../services/remote_services.dart';


class CourseByIDController extends GetxController {

  var isLoading = true.obs;
  var courseByIDList = Rxn<CourseByIdModel>();

  @override
  void onInit() {
    fetchCourseById();
    super.onInit();
  }

  void fetchCourseById() async {
    try {
      isLoading(true);
      var courseByID = await RemoteServices.fetchCourseByID("32492");
      if (courseByID != null) {
        isLoading(false);
        courseByIDList.value = courseByID;
      }
    } finally {
      isLoading(false);
    }
  }

}