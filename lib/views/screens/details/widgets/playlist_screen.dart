

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';

import '../../../../helpers/helper.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p16),
            child: Container(
              height: 8.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.halfWhiteColor
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 5.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s28),
                            color: ColorManager.whiteColor
                          ),
                          child: Center(child: textStyle0_5(text: "${index+1}")),
                        ),
                        buildSpaceHorizontal(3.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textStyle0_5(text: "Introduction"),
                            textStyle00(text: "00:00/13:50", color: ColorManager.grayColor),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s28),
                          color: ColorManager.whiteColor
                      ),
                      child: const Icon(Icons.lock, color: ColorManager.redColor, size: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
