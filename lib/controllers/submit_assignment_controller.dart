

import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class SubmitAssignmentController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> submit(String id, String note, File file) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    String token = box.read("token");

    var request = http.MultipartRequest("POST", Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.assignments)+"/submit"));
    var pic = await http.MultipartFile.fromPath("file", file.path);
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    request.files.add(pic);
    request.fields['id'] = id;
    request.fields['action'] = "save";
    request.fields['note'] = note;
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);


    if (response.statusCode == 200) {
      isDataSubmitting.value = false;
      final Map<String, dynamic> responseData = json.decode(responseString);
      if (responseData['data']['status'] == 200) {
        isDataReadingCompleted.value = true;
        result = {'status': true, 'message': responseData['message']};
      } else {
        isDataSubmitting.value = false;
        isDataReadingCompleted.value = true;
        result = {'status': false, 'message': responseData['message']};

      }
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {'status': false, 'message': "Server Error!\nFailed to finish the course", 'data': {}};
    }
    return result;
  }
}