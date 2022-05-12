

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSpaceVertical(1.h),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
          child: textStyle0_5(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit rutrum nunc sed ut condimentum ull amcorper aliquet."
              " A posuere convallis vel ni bh senectus sed rhoncus eu at. Nisl diam aene an sed bibendum purus..."),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p12),
          child: Row(
            children: [
              const Icon(Icons.chrome_reader_mode, color: ColorManager.redColor),
              buildSpaceHorizontal(5.w),
              textStyle0(text: "27 Tutorials"),
            ],
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p12),
          child: Row(
            children: [
              const Icon(Icons.desktop_mac_rounded, color: ColorManager.redColor),
              buildSpaceHorizontal(5.w),
              textStyle0(text: "Access on desktop, mobile & TV"),
            ],
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p12),
          child: Row(
            children: [
              const Icon(Icons.album_sharp, color: ColorManager.redColor),
              buildSpaceHorizontal(5.w),
              textStyle0(text: "Beginner Level"),
            ],
          ),
        ),

      ],
    );
  }
}
