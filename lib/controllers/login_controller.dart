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
    final queryParameters = {'username': userName, 'password': password};

    var response = await client.post(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.login))
            .replace(queryParameters: queryParameters));

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
      result = {
        'status': false,
        'message': "Server Error!\nFailed to finish the lesson",
        'data': {}
      };
    }
    return result;
  }

  createUser({
    userName,
    email,
    password,
  }) async {
    var registeruri =
        "https://musing-gould.18-141-157-112.plesk.page/wp-json/wc/v3/customers?username=$userName&email=$email&password=$password";
    var headers = {
      "Content-Type": "multipart/form-data",
      "Authorization":
          "Basic Y2tfNjJiNjRlNmE5MmMyYzM2MjMzMDQ5MWUyMDQ0ZjdlNDk0MTRjYTZjOTpjc182ZGFiMTQ5YjQ1ZWM5Mjk5OWFkZmM2MzcxOTJkNTNiM2Y1ODlkNDFh",
      "consumer_secret": "cs_6dab149b45ec92999adfc637192d53b3f589d41a",
      "consumer_key": "ck_62b64e6a92c2c362330491e2044f7e49414ca6c9"
    };

    try {
      var detail = await http
          .post(Uri.parse(registeruri), headers: headers)
          .timeout(const Duration(seconds: 30));
      print(headers);

      final resposeData = jsonDecode(detail.body);

      if (resposeData.toString().contains("message")) {
        print(" in if");
        print("message: ${resposeData["message"]}");
      } else {
        print(" in else");
      }
    } catch (e) {
      print(" $e");
    }
  }
}
