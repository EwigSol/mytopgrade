import 'package:flutter/material.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/helpers/text_helper.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/utils/assets_manager.dart';
import 'package:mytopgrade/utils/color_manager.dart';
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
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.50,
              child: Image.asset(AssetsManager.card, fit: BoxFit.fill),
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            textStyle2(text: "Payment Done Successfully"),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            InkWell(
              onTap: () {
                Get.offAllNamed(Paths.homeBar);
              },
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.53,
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
