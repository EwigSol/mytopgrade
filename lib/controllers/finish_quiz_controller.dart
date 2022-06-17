import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class FinishQuizController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> finishQuiz(
      multiChoiceAnswers,
      trueFalseAnswers,
      sortingAnswers,
      singleChoiceAnswers,
      fillBlanksAnswers,
      int multiChoiceId,
      trueFalseId,
      sortingId,
      singleId,
      fillBlanksId,
      String id) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;

    var dataBody = {
      // 'id': 32860,
      'id': id,
      'answered[$multiChoiceId]': multiChoiceAnswers,
      'answered[$trueFalseId]': trueFalseAnswers,
      'answered[$sortingId]': sortingAnswers,
      'answered[$singleId]': singleChoiceAnswers,
      'answered[$fillBlanksId]': fillBlanksAnswers,
    };
    String token = box.read("token");

    var request = http.MultipartRequest(
        'Post',
        Uri.parse(
            APIBase.baseURL + APIPathHelper.getValue(APIPath.finishQuiz)));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    request.fields.addAll({
      // 'id': '32860',
      'id': id.toString(),
      'answered[$multiChoiceId]': multiChoiceAnswers.toString(),
      'answered[$trueFalseId]': trueFalseAnswers.toString(),
      'answered[$sortingId]': sortingAnswers.toString(),
      'answered[$singleId]': singleChoiceAnswers.toString(),
      'answered[$fillBlanksId]': fillBlanksAnswers.toString(),
    });

    var response = await request.send();
    var responded = await http.Response.fromStream(response);
    final responseData = responded.body;

    if (response.statusCode == 200) {
      isDataSubmitting.value = false;
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'status': true, 'message': "Quiz Finished Successfully"};
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': false,
        'message': "Server Error!\nFailed to finish the quiz"
      };
    }
    return result;
  }
}
