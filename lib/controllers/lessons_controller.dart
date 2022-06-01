


import 'package:get/state_manager.dart';
import 'package:topgrade/models/lessons_model.dart';
import '../services/remote_services.dart';


class LessonsController extends GetxController {

  var isLoading = true.obs;
  var lessonList = <LessonsModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchAllLessons();
    super.onInit();
  }

  void fetchAllLessons() async {
    try {
      isLoading(true);
      var lesson = await remoteServices.fetchLessons();
      if (lesson != null) {
        isLoading(false);
        lessonList.value = lesson;
      }
    } finally {
      isLoading(false);
    }
  }

}