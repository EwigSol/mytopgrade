// ignore_for_file: file_names

import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/models/quiz_byID_model.dart';
import 'package:http/http.dart' as http;
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class QuizByIDController extends GetxController {
  var isLoading = false.obs;
  var quizByIDList = Rxn<QuizByIdModel>();
  static var client = http.Client();
  final box = GetStorage();

  Future<QuizByIdModel> fetchQuizByID(String id) async {
    isLoading.value = true;
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL +
            APIPathHelper.getValue(APIPath.quiz) +
            "/" +
            id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    quizByIDList.value = quizByIdModelFromJson(response.body);
    isLoading.value = false;
    return quizByIdModelFromJson(response.body);
  }
}
