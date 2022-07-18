import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/controllers/social_login_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/views/screens/home/home_screen.dart';
import '../models/user_model.dart';
import 'login_controller.dart';

class SocialRegisterController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();
  final SocialLoginController socialLoginController =
      Get.put(SocialLoginController());

  Future<Map<String, dynamic>> register(String email) async {
    String username = email.substring(0, email.indexOf('@'));
    Random random = Random();
    int randomInt = random.nextInt(10000);
    String randomPassword = '$username$randomInt';
    print(randomPassword);
    print(username);
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {
      //TODO: random password and parse username
      'username': username,
      'password': randomPassword,
      "email": email
    };
    String userName = "ck_d32a362d67fe84926e4299676d89acf9c4a44046";
    String password = "cs_5224cf20b2a8596884e56c48be1fdff251593b33";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$password'));

    var response = await client.post(
        Uri.parse("https://mytopgrade.com/wp-json/wc/v3/customers")
            .replace(queryParameters: queryParameters),
        headers: {'Authorization': basicAuth});
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);

      isDataReadingCompleted.value = true;
      result = {'status': true, 'userData': userModelFromJson(response.body)};
      await SocialLoginController().login(email).then((response) => {
            if (response['status'] == true)
              {
                box.write("token", response['token']),
                box.write("user_id", response['user_id']),
                box.write("user_email", response['user_email']),
                box.write("user_display_name", response['user_display_name']),
                Get.snackbar('Welcome Back',
                    'Welcome ${response['user_display_name']} to your Educational Portal',
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.white,
                    backgroundColor: Colors.blue),
                Get.offAllNamed(Paths.homeBar),
                print("mytoken is : ${box.read("token")}"),
              }
            else
              {
                errorToast("Error", response['message']),
              }
          });
    } else if (response.statusCode == 401) {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': false,
        'message': "You Have already created account on this email"
      };
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': false,
        'message': "Server Error!\nFailed to register"
      };
    }
    return result;
  }
}
