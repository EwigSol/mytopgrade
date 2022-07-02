import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/models/orderByIdModel.dart';
import 'package:mytopgrade/models/user_model.dart';

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
    String userName = "ck_d32a362d67fe84926e4299676d89acf9c4a44046";
    String password = "cs_5224cf20b2a8596884e56c48be1fdff251593b33";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$password'));
    var id = box.read('user_id');
    print(id);

    var response = await client.get(
      Uri.parse("https://mytopgrade.com/wp-json/wc/v3/orders?customer= $id"),
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
