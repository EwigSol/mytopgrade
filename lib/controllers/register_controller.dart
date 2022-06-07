



import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/user_model.dart';

class RegisterController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> register(String username, email, userPassword) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {  'username': username, 'password': userPassword, "email": email };
    String userName = "ck_62b64e6a92c2c362330491e2044f7e49414ca6c9";
    String password = "cs_6dab149b45ec92999adfc637192d53b3f589d41a";
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$userName:$password'));

    var response = await client.post(Uri.parse("https://musing-gould.18-141-157-112.plesk.page/wp-json/wc/v3/customers").replace(queryParameters: queryParameters),
        headers: { 'Authorization': basicAuth });

    if (response.statusCode == 200 || response.statusCode == 201) {
      isDataSubmitting.value = false;
      Map<String, dynamic> responseData = jsonDecode(response.body);
      isDataReadingCompleted.value = true;
      result = {'status': true, 'userData': userModelFromJson(response.body) };
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'status': false, 'message': "Server Error!\nFailed to register"};
    }
    return result;
  }
}