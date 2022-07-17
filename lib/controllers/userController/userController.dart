import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mytopgrade/models/UserModel.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var userModel = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    getCustomer();
  }

  getCustomer() async {
    final box = GetStorage();
    var token = box.read("token");
    var id = box.read("user_id");
    print(id.toString());
    Map<String, dynamic> result;
    isLoading.value = true;

    var response = await http.get(
      Uri.parse("https://mytopgrade.com/wp-json/learnpress/v1/users/$id"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
    print('this is my response: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
      userModel.value = userModelFromJson(response.body);
    } else {
      isLoading.value = false;
      result = {
        'status': false,
        'message': "Server Error!\nFailed to update the Customer"
      };
    }
  }
}
