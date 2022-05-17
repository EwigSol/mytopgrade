



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';
import '../utils/strings_manager.dart';

class SubmitReviewController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();

  Future<Map<String, dynamic>> submitReview(String id, String rate, String title, String content) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    Map<String, dynamic> dataBody = { "id": id, "rate": rate, "title": title, "content": content };

    var response = await client.post(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.submitReview)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        }, body: dataBody);

    if (response.statusCode == 200) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == "success") {
        isDataReadingCompleted.value = true;
        result = {'status': responseData['status'], 'message': responseData['message'], 'data': responseData['data']};
      } else {
        isDataSubmitting.value = false;
        isDataReadingCompleted.value = true;
        result = {'status': responseData['status'], 'message': responseData['message'], 'data': responseData['data']};

      }
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'status': "error", 'message': "Server Error!\nFailed to submit the review", 'data': {}};
    }
    return result;
  }
}