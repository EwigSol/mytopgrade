

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/utils/values_manager.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/strings_manager.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key, this.text, this.image}) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildSpaceVertical(10.h),
        textStyle5(color: ColorManager.primaryColor, text: StringsManager.appName),
        buildSpaceVertical(4.h),
        Center(child: textStyle1(text: text!, textAlign: TextAlign.center)),
        buildSpaceVertical(10.h),
        Image.asset(image!, height: 35.h, width: 70.w),
      ],
    );
  }
}