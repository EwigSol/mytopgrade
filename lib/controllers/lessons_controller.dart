


import 'package:get/state_manager.dart';
import 'package:topgrade/models/lessons_model.dart';
import '../services/remote_services.dart';


class LessonsController extends GetxController {

  var isLoading = true.obs;
  var lessonList = <LessonsModel>[].obs;

  @override
  void onInit() {
    fetchAllLessons();
    super.onInit();
  }

  void fetchAllLessons() async {
    try {
      isLoading(true);
      var lesson = await RemoteServices.fetchLessons();
      if (lesson != null) {
        isLoading(false);
        lessonList.value = lesson;
      }
    } finally {
      isLoading(false);
    }
  }

}