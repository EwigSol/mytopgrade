import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/controllers/socialRegistration.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/views/screens/home/home_screen.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class SocialLoginController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();
  // final SocialRegisterController socialRegisterController =
  //     Get.put(SocialRegisterController());

  Future<Map<String, dynamic>> login(
    String userName,
  ) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {'username': userName, 'onlyusername': 'yes'};

    var response = await client.post(Uri.parse(
        "https://mytopgrade.com/wp-json/learnpress/v1/mitoken?username=$userName&onlyusername=yes"));
    if (response.statusCode == 200) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);
      isDataReadingCompleted.value = true;
      box.write("token", responseData['token']);
      box.write("user_id", responseData['user_id']);
      box.write("user_login", responseData['user_login']);
      box.write("user_email", responseData['user_email']);
      box.write("user_display_name", responseData['user_display_name']);
      box.write("isLogged", true);
      result = {
        'status': true,
        'token': responseData['token'],
        'user_id': responseData['user_id'],
        'user_login': responseData['user_login'],
        'user_email': responseData['user_email'],
        'user_display_name': responseData['user_display_name'],
      };
      print(box.read("token"));
      print(response.body);
      Get.offAllNamed(Paths.homeBar);
    } else {
      await SocialRegisterController().register(userName);
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
}
