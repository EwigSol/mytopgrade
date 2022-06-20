import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class StartCourseController extends GetxController {
  var isLoading = false.obs;
  // var isDataReadingCompleted = false.obs;
  // var added = false.obs;
  static var client = http.Client();
  final box = GetStorage();
  // List<dynamic> wishlist = [];

  Future startCourse(String id) async {
    isLoading.value = true;
    String token = box.read("token");

    var response = await client.post(
      Uri.parse(
          'https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1/courses/enroll?id=$id'),
      headers: {
        'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("Course is added to enrooled with id : ${response.body}");
    // var data = jsonDecode(response.body);
    // result = {'status': data['status'], 'message': data['message']};
    // isDataSubmitting.value = false;
    // added.value = added.value ? false : true;
    return jsonDecode(response.body);
  }
}
