


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color_manager.dart';

successToast(String title, String msg) {
  Get.snackbar(
      title, msg,
      backgroundColor: ColorManager.primaryColor,
      colorText: ColorManager.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
  );
}

errorToast(String title, String msg) {
  Get.snackbar(
    title, msg,
    backgroundColor: ColorManager.redColor,
    colorText: ColorManager.whiteColor,
    snackPosition: SnackPosition.BOTTOM,
  );
}

validateEmail(String email) {
  final emailReg = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}


SizedBox buildSpaceVertical(height) => SizedBox(height: height);
SizedBox buildSpaceHorizontal(width) => SizedBox(width: width);