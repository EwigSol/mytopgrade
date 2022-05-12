

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:get/get.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: ColorManager.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: 30.h,
        width: 100.w,
        child: Column(
          children: [
            buildSpaceVertical(2.h),
            SizedBox(
              height: 10.h,
              width: 50.w,
              child: Image.asset(AssetsManager.card, fit: BoxFit.fill),
            ),
            buildSpaceVertical(2.h),
            textStyle2(text: "Payment Done Successfully"),
            buildSpaceVertical(2.h),
            InkWell(
              onTap: (){
                Get.offAllNamed(Paths.homeBar);
              },
              child: Center(
                child: Container(
                  height: 6.h,
                  width: 53.w,
                  decoration: BoxDecoration(
                    color: ColorManager.redColor,
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
                  child: const Center(
                    child: Text(
                      "Back To Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
