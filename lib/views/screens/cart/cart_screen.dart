


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import '../../../helpers/text_helper.dart';
import '../../../routes/appPages.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p12),
                      child: Container(
                        height: 10.h,
                        width: 85.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          color: ColorManager.halfWhiteColor
                        ),
                        child: Row(
                          children: [
                            buildSpaceHorizontal(2.w),
                            SizedBox(
                              height: 8.h,
                              width: 16.w,
                              child: Image.asset(AssetsManager.card, fit: BoxFit.fill),
                            ),
                            buildSpaceHorizontal(5.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textStyle0(text: "User Interface Design"),
                                textStyle0(text: "By Talent Tamer", color: ColorManager.grayColor),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    textStyle0(text: "3.5"),
                                    buildSpaceHorizontal(1.w),
                                    textStyle0(text: "⭐"),
                                    buildSpaceHorizontal(1.w),
                                    textStyle0(text: "1250 Ratings"),
                                  ],
                                ),
                              ],
                            ),
                            buildSpaceHorizontal(10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textStyle0_5(text: "\$ 49"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.admin_panel_settings, color: ColorManager.redColor),
                                    buildSpaceHorizontal(1.w),
                                    textStyle0(text: "Remove", color: ColorManager.redColor),
                                  ],
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  }
              )
          ),
          buildSpaceVertical(3.h),
          Container(
            height: 15.h,
            width: 80.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.halfWhiteColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: textStyle2(text: "Summary")),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textStyle1(text: "Courses:"),
                      textStyle1(text: "02"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textStyle1(text: "SubTotal:"),
                      textStyle1(text: "\$ 105.00"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textStyle1(text: "Total:", color: ColorManager.redColor),
                      textStyle1(text: "\$105.00", color: ColorManager.redColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildSpaceVertical(10.h),
        ],
      ),
      bottomSheet: buildBottomCard(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.cart),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  Container buildBottomCard() {
    return Container(
      height: 7.h,
      width: 100.w,
      color: ColorManager.whiteColor,
      child: InkWell(
        onTap: (){
          Get.toNamed(Paths.checkout);
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
                "Checkout",
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
    );
  }
}
