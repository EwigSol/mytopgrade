



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class LoginController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();

  Future<Map<String, dynamic>> login(String userName, String password) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {  'username': userName, 'password': password };

    var response = await client.post(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.login)).replace(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);
        isDataReadingCompleted.value = true;
        result = {
          'status': true,
          'token': responseData['token'],
          'user_id': responseData['user_id'],
          'user_login': responseData['user_login'],
          'user_email': responseData['user_email'],
          'user_display_name': responseData['user_display_name'],
        };
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'status': false, 'message': "Server Error!\nFailed to finish the lesson", 'data': {}};
    }
    return result;
  }
}