

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/color_manager.dart';

Widget actionButton(String text){
  return Container(
    height: 6.h,
    width: 43.w,
    decoration: BoxDecoration(
      color: ColorManager.primaryColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: ColorManager.primaryColor.withOpacity(0.2),
          spreadRadius: 4,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}