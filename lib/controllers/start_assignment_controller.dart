



import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class StartAssignmentController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> startAssignment(String id) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {  'id': id };
    String token = box.read("token");

    var response = await client.post(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.assignments)+"/start/").replace(queryParameters: queryParameters),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['message'] != "You cannot start this Assignment") {
        isDataReadingCompleted.value = true;
        result = {'message': responseData['message']};
      } else {
        isDataSubmitting.value = false;
        isDataReadingCompleted.value = true;
        result = {'message': responseData['message']};
      }
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'message': "Server Error!\nFailed to finish the lesson"};
    }
    return result;
  }
}