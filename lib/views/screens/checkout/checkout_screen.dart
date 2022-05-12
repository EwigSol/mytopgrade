


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import 'widgets/payment_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSpaceVertical(2.h),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle1(text: "Select Payment Method"),
          ),
          buildSpaceVertical(1.h),
          Center(
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 20,
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: ColorManager.halfWhiteColor
                  ),
                  child: Center(
                    child: textStyle0_5(text: "Debit Card"),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: ColorManager.halfWhiteColor
                  ),
                  child: Center(
                    child: textStyle0_5(text: "Stripe"),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: ColorManager.halfWhiteColor
                  ),
                  child: Center(
                    child: textStyle0_5(text: "Paypal"),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: ColorManager.halfWhiteColor
                  ),
                  child: Center(
                    child: textStyle0_5(text: "COD"),
                  ),
                ),
              ],
            ),
          ),
          buildSpaceVertical(2.h),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle1(text: "Select Your Card"),
          ),
          buildSpaceVertical(2.h),
          SizedBox(
            height: 20.h,
            width: 100.w,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
                    child: Container(
                      height: 20.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          color: ColorManager.redColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: AppPadding.p12, top: AppPadding.p12),
                            child: Icon(Icons.account_balance_wallet_rounded, color: ColorManager.whiteColor),
                          ),
                          buildSpaceVertical(3.h),
                          Center(child: textStyle0_5(text: "2346 **** **** 9834", color: ColorManager.whiteColor)),
                          buildSpaceVertical(2.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textStyle00(text: "Card Holder", color: ColorManager.whiteColor),
                                    textStyle0(text: "Zain Ullah", color: ColorManager.whiteColor)
                                  ],
                                ),

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textStyle00(text: "Expires", color: ColorManager.whiteColor),
                                    textStyle0(text: "15/26", color: ColorManager.whiteColor)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
          buildSpaceVertical(3.h),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: InkWell(
                onTap: (){
                  Get.toNamed(Paths.addNC);
                },
                child: textStyle1(text: "Add New Card")),
          ),
        ],
      ),
      bottomSheet: buildBottomCard(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.checkout),
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
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            builder: (context) {
              return const PaymentDialog();
            },
          );
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
                "Continue",
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
