import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:topgrade/models/user_model.dart';

class UpdateCustomerController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> updateCustomer(
      String firstName, lastName, phone, id) async {
    print(id.toString());
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    String userName = "ck_62b64e6a92c2c362330491e2044f7e49414ca6c9";
    String password = "cs_6dab149b45ec92999adfc637192d53b3f589d41a";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$password'));
    Map<dynamic, dynamic> dataBody = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone
    };

    var response = await client.put(
        Uri.parse(
            "https://musing-gould.18-141-157-112.plesk.page/wp-json/wc/v3/customers/$id"),
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json",
        },
        body: jsonEncode(dataBody));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': true,
        'userData': userModelFromJson(response.body),
        'message': "Customer Details Updated"
      };
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': false,
        'message': "Server Error!\nFailed to update the Customer"
      };
    }
    return result;
  }
}
