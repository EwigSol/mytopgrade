import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/controllers/firebasecontroller.dart/socialauthcontroller.dart';
import 'package:mytopgrade/models/user_model.dart';
import 'package:image/image.dart' as Img;
import 'package:mytopgrade/routes/appPages.dart';

class ContactUsController extends GetxController {
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  final box = GetStorage();
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());

  sendEmail(String yourName, String yourEmail, String yourSubject,
      String yourMessage) async {
    print(yourMessage);
    final box = GetStorage();
    isDataSubmitting.value = true;
    Map<String, String> dataBody = {
      "sender_name": yourName,
      "sender_email": yourEmail,
      "sender_subject": yourSubject,
      "sender_message": yourMessage,
    };
    var token = box.read("token");

    var request = await http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://www.mytopgrade.com/wp-json/contact-form-7/v1/contact-forms/32974/feedback"));
    request.fields.addAll(dataBody);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Success', 'Email Sent Successfully',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
    } else {
      Get.snackbar('Error', 'There was some error while Sending your Message',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
    }
  }
}
