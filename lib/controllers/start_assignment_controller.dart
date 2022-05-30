



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';
import '../utils/strings_manager.dart';

class StartAssignmentController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();

  Future<Map<String, dynamic>> startAssignment(String id) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {  'id': id };

    var response = await client.post(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.assignments)+"/start/").replace(queryParameters: queryParameters),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
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