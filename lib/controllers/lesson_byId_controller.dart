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

  Future<LessonByIdModel> fetchLessonByID(dynamic id) async {
    isLoading.value = true;
    String token = box.read("token");
    print(token);
    print(APIBase.baseURL + APIPathHelper.getValue(APIPath.lessons) + "/" + id);
    var response = await client.get(
        Uri.parse(APIBase.baseURL +
            APIPathHelper.getValue(APIPath.lessons) +
            "/" +
            id),
        headers: {
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    lessonByIDList.value = lessonByIdModelFromJson(response.body);
    isLoading.value = false;
    return lessonByIdModelFromJson(response.body);
  }
}
