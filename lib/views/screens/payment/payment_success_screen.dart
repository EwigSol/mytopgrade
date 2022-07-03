import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/controllers/order_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  final OrderController orderController = Get.put(OrderController());
  double height = Get.height;
  double width = Get.width;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: textStyle4(
                    text: "Course Ordered\nSuccessfully",
                    textAlign: TextAlign.center,
                    color: ColorManager.primaryColor)),
            buildSpaceVertical(height * 0.07),
            Center(
                child: textStyle2(
                    text:
                        "Make your payment directly into mytopgrade bank account. "
                        "Please use your Order ID (${box.read("orderId")}) as the payment reference. Your order/Course will not be activated until the "
                        "funds have been confirmed in our account. Email the proof of payment to mytopgradeng@gmail.com  \n Below are the Bank Details \n Bank name: Access Bank Nig Plc \n Account Title: Mytopgrade Limited \n Account No: 1474061287 ",
                    textAlign: TextAlign.center)),
            buildSpaceVertical(height * 0.07),
            Center(
              child: InkWell(
                onTap: () {
                  Get.offAllNamed(Paths.homeBar);
                },
                child: Container(
                    height: height * 0.06,
                    width: width * 0.60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.primaryColor),
                    child: Center(
                        child: textStyle2(
                            text: "Go to Home",
                            color: ColorManager.whiteColor))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: "Order Success"),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
