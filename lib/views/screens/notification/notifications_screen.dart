

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/values_manager.dart';

import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p16),
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 7.h,
                          width: 14.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s28),
                            color: ColorManager.greenColor
                          ),
                          child: const Center(child: Icon(Icons.volunteer_activism, color: ColorManager.whiteColor)),
                        ),
                        buildSpaceHorizontal(5.w),
                        textStyle0(text: "You have Purchased Course")
                      ],
                    ),
                    const Icon(Icons.album_outlined, color: ColorManager.blackColor)
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.notify),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }
}
