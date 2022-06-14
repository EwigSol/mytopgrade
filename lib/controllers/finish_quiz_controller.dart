


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

  Future<Map<String, dynamic>> finishQuiz(List<dynamic> multiChoiceAnswers, trueFalseAnswers, sortingAnswers, singleChoiceAnswers, fillBlanksAnswers,
      String multiChoiceId, trueFalseId, sortingId, singleId, fillBlanksId, id) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    Map<String, dynamic> dataBody = {
      "id": id,
      "answered[$multiChoiceId]": multiChoiceAnswers,
      "answered[$trueFalseId]": trueFalseAnswers,
      "answered[$sortingId]": sortingAnswers,
      "answered[$singleId]": singleChoiceAnswers,
      "answered[$fillBlanksId]": fillBlanksAnswers,
    };
    String token = box.read("token");

    var response = await client.post(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.finishQuiz)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }, body: jsonEncode(dataBody));
    print(response.statusCode);
    if (response.statusCode == 200) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'status': true, 'message': "Quiz Finished Successfully"};
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'status': false, 'message': "Server Error!\nFailed to finish the quiz"};
    }
    return result;
  }
}