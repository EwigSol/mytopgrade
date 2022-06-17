// ignore_for_file: file_names

import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import '../models/lesson_byID_model.dart';
import 'package:http/http.dart' as http;
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class LessonByIDController extends GetxController {
  var isLoading = false.obs;
  var lessonByIDList = Rxn<LessonByIdModel>();
  final box = GetStorage();
  static var client = http.Client();
  var id;

  @override
  void onInit() {
    var _id = box.read("lesson_id");
    print('id given to controller this time is $_id');
    fetchLessonByID(_id);
  }

  Future<LessonByIdModel?> fetchLessonByID(String id) async {
    isLoading.value = true;
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL +
            APIPathHelper.getValue(APIPath.lessons) +
            "/" +
            id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    lessonByIDList.value = await lessonByIdModelFromJson(response.body);
    print(lessonByIDList.value!.name);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      isLoading.value = false;
      return lessonByIdModelFromJson(jsonString);
    } else {
      isLoading.value = false;
      // errorToast(StringsManager.error, "Unable to Fetch Lesson By ID");
      return null;
    }
  }

  // Future<void> getlessonId() {
  //   id = _id;
  //   return _id;
  // }
}
