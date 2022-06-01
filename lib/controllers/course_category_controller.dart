


import 'package:get/state_manager.dart';
import 'package:topgrade/models/course_category_model.dart';
import '../services/remote_services.dart';


class CourseCategoryController extends GetxController {

  var isLoading = true.obs;
  var courseCatList = <CourseCategoryModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchCourseCategories();
    super.onInit();
  }

  void fetchCourseCategories() async {
    try {
      isLoading(true);
      var courseCat = await remoteServices.fetchCourseCategories();
      if (courseCat != null) {
        isLoading(false);
        courseCatList.value = courseCat;
      }
    } finally {
      isLoading(false);
    }
  }

}