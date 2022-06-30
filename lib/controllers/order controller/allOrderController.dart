import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:topgrade/models/orderByIdModel.dart';
import 'package:topgrade/models/user_model.dart';

class OrderByIdController extends GetxController {
  var orderByIdList = <OrderByIdModel>[].obs;
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();
  var isLoading = false.obs;

  allOrderByCustomer() async {
    isLoading.value = true;
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    String userName = "ck_62b64e6a92c2c362330491e2044f7e49414ca6c9";
    String password = "cs_6dab149b45ec92999adfc637192d53b3f589d41a";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$password'));
    var id = box.read('user_id');
    print(id);

    var response = await client.get(
      Uri.parse(
          "https://musing-gould.18-141-157-112.plesk.page/wp-json/wc/v3/orders?customer= $id"),
      headers: {
        "Authorization": basicAuth,
        "Content-Type": "application/json",
      },
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      orderByIdList.value = orderByIdModelFromJson(response.body);
      result = {
        'status': true,
        'userData': orderByIdModelFromJson(response.body)
      };
      isLoading.value = false;
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
    }
  }
}
