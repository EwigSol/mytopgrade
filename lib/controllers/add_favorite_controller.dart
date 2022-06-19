import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class AddFavoriteController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  var added = false.obs;
  static var client = http.Client();
  final box = GetStorage();
  List<dynamic> wishlist = [];

  Future<Map<String, dynamic>> addFavorite(String id) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    String token = box.read("token");

    var response = await client.post(
      Uri.parse(
          'https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1/wishlist/toggle?id=${id.toString()}'),
      headers: {
        'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var data = jsonDecode(response.body);
    result = {'status': data['status'], 'message': data['message']};
    isDataSubmitting.value = false;
    added.value = added.value ? false : true;
    return result;
  }
}
