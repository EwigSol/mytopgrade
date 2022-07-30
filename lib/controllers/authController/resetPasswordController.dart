import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/network_module/api_base.dart';
import 'package:mytopgrade/network_module/api_path.dart';

class PasswordController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();
  final isLoading = false.obs;

  passwordReset(String userName) async {
    isLoading.value = true;
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {
      'user_login': userName,
    };

    var response = await client.post(Uri.parse(
            APIBase.baseURL + APIPathHelper.getValue(APIPath.passwordReset))
        .replace(queryParameters: queryParameters));
    print(response.body);

    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.snackbar(
          'Success', 'A link to reset your password has been emailed to you.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white);
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'There was an Error Please Try Again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        borderColor: Colors.red,
        borderWidth: 2,
        colorText: Colors.white,
      );
    }
  }
}
