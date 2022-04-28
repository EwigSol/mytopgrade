


import 'package:flutter/material.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';

AnimatedContainer buildDot({int? index, int? current }) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    margin: const EdgeInsets.only(right: AppPadding.p6),
    height: 6,
    width: current == index ? 20 : 6,
    decoration: BoxDecoration(
      color: current == index ? ColorManager.primaryColor :  ColorManager.grayColor,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}
