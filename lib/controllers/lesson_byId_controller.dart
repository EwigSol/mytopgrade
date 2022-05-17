



import 'package:get/state_manager.dart';
import '../models/lesson_byID_model.dart';
import '../services/remote_services.dart';


class LessonByIDController extends GetxController {

  var isLoading = true.obs;
  var lessonByIDList = Rxn<LessonByIdModel>();

  @override
  void onInit() {
    fetchLessonById();
    super.onInit();
  }

  void fetchLessonById() async {
    try {
      isLoading(true);
      var lessonByID = await RemoteServices.fetchLessonByID("32743");
      if (lessonByID != null) {
        isLoading(false);
        lessonByIDList.value = lessonByID;
      }
    } finally {
      isLoading(false);
    }
  }

}