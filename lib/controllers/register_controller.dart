import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/views/screens/auth/signUpResultScreen.dart';
import '../models/user_model.dart';
import 'login_controller.dart';

class RegisterController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();
  final LoginController loginController = Get.put(LoginController());

  Future<Map<String, dynamic>> register(
      String username, String email, String phone, String userPassword) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    Map<dynamic, dynamic> data = {
      'username': username,
      'password': userPassword,
      "email": email,
      "billing": {
        "phone": phone,
      },
    };
    String userName = "ck_d32a362d67fe84926e4299676d89acf9c4a44046";
    String password = "cs_5224cf20b2a8596884e56c48be1fdff251593b33";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$password'));

    var response = await client.post(
        Uri.parse("https://mytopgrade.com/wp-json/wc/v3/customers"),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);
      isDataReadingCompleted.value = true;
      result = {'status': true, 'userData': userModelFromJson(response.body)};
      Get.snackbar('Sucess', 'Your Account has been Created',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      Get.to(() => SignUpResultScreen());
    } else if (response.statusCode == 401) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': false,
        'message': "You Have already created account on this email"
      };
      Get.snackbar('Error', responseData['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': false,
        'message': "Server Error!\nFailed to register"
      };
      Get.snackbar('Error', responseData['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
    return result;
  }
}
