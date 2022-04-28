

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/routes/appPages.dart';
import '../../../helpers/helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/action_button.dart';
import '../../widgets/text_field.dart';
import 'widgets/simple_appbar.dart';
import 'package:get/get.dart';


class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 10.h),
        child: const SimpleAppBar(title: StringsManager.forgotPas),
      ),
      body: Column(
        children: [
          buildSpaceVertical(10.h),
          buildFormCard(),
        ],
      ),
    );
  }

  Center buildFormCard() {
    return Center(
      child: Container(
        height: 35.h,
        width: 90.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSpaceVertical(2.h),
              SizedBox(
                height: 13.h,
                width: 30.w,
                child: Image.asset(AssetsManager.logo, fit: BoxFit.fill),
              ),
              buildSpaceVertical(2.h),
              CustomTextField(
                controller: emailController,
                hintName: StringsManager.email,
              ),
              buildSpaceVertical(3.h),
              InkWell(
                  onTap: () {
                    Get.toNamed(Paths.otpVerify);
                  },
                  child: actionButton(StringsManager.submit)),
            ],
          ),
        ),
      ),
    );
  }
}
