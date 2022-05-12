

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';

import '../../../../helpers/text_helper.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/strings_manager.dart';
import '../../../../utils/values_manager.dart';
import '../../../widgets/text_field.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {

  final cardNoController = TextEditingController();
  final cardNameController = TextEditingController();
  final expireController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildSpaceVertical(2.h),
          Center(
            child: Container(
              height: 25.h,
              width: 80.w,
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
                  Center(child: textStyle1(text: "2346 **** **** 9834", color: ColorManager.whiteColor)),
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
                            textStyle0(text: "Card Holder", color: ColorManager.whiteColor),
                            textStyle0_5(text: "Zain Ullah", color: ColorManager.whiteColor)
                          ],
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textStyle0(text: "Expires", color: ColorManager.whiteColor),
                            textStyle0_5(text: "15/26", color: ColorManager.whiteColor)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildSpaceVertical(5.h),
          Center(
            child: Container(
              height: 45.h,
              width: 90.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s16),
                  color: ColorManager.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  buildSpaceVertical(3.h),
                  CustomTextField(
                    controller: cardNoController,
                    hintName: StringsManager.cardNo,
                  ),
                  buildSpaceVertical(3.h),
                  CustomTextField(
                    controller: cardNameController,
                    hintName: StringsManager.cardNa,
                  ),
                  buildSpaceVertical(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 7.h,
                        width: 45.w,
                        child: CustomTextField(
                          controller: expireController,
                          hintName: StringsManager.expire,
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                        width: 45.w,
                        child: CustomTextField(
                          controller: cvvController,
                          hintName: StringsManager.cvv,
                        ),
                      ),
                    ],
                  ),
                  buildSpaceVertical(3.h),
                  Center(
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.addNew),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }
}
