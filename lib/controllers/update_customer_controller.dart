import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/models/user_model.dart';
import 'package:image/image.dart' as Img;

class UpdateCustomerController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> updateCustomer(
      String firstName, lastName, phone, id) async {
    final box = GetStorage();
    print(id.toString());
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    String userName = "ck_d32a362d67fe84926e4299676d89acf9c4a44046";
    String password = "cs_5224cf20b2a8596884e56c48be1fdff251593b33";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$password'));
    Map<dynamic, dynamic> dataBody = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone
    };
    var token = box.read("token");

    var response = await client.put(
        Uri.parse("https://mytopgrade.com/wp-json/wc/v3/customers/$id"),
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

  changeProfile(image, id) async {
    print(image.path);
    var box = GetStorage();
    var token = box.read("token");
    var rendomName = Random().nextInt(100000);
    Img.Image? imageToChange =
        Img.decodeImage(File(image.path).readAsBytesSync());
    print(imageToChange!.height);
    Img.Image? compressedImage =
        Img.copyResize(imageToChange, width: 250, height: 250);
    print(compressedImage.height);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mytopgrade.com/wp-json/learnpress/v1/users/$id'),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });
    request.files.add(await http.MultipartFile.fromBytes(
      'lp_avatar_file',
      Img.encodeJpg(compressedImage),
      filename: '$rendomName.jpg',
    ));
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print(response.body);
    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Image has been Updated',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } else if (response.statusCode == 400) {
      Get.snackbar(
        'Error',
        'Please Upload An Image with Dimenssions 250 x 250 px',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
