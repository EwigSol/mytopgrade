



import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class PurchaseCourseController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> purchaseCourse(String id) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    Map<String, dynamic> dataBody = { "id": id };
    String token = box.read("token");

    var response = await client.post(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courseEnroll)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
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
      result = {'status': "error", 'message': "Server Error!\nFailed to finish the lesson", 'data': {}};
    }
    return result;
  }
}