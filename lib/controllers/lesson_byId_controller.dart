// ignore_for_file: file_names

import 'package:get/state_manager.dart';
import '../models/lesson_byID_model.dart';
import '../services/remote_services.dart';

class LessonByIDController extends GetxController {
  var isLoading = true.obs;
  var lessonByIDList = Rxn<LessonByIdModel>();
  RemoteServices remoteServices = RemoteServices();

  void fetchLessonById(String id) async {
    try {
      isLoading(true);
      var lessonByID = await remoteServices.fetchLessonByID(id);
      if (lessonByID != null) {
        isLoading(false);
        lessonByIDList.value = lessonByID;
      }
    } finally {
      isLoading(false);
    }
  }
}
