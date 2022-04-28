


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/text_helper.dart';
import '../../../helpers/helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/action_button.dart';
import 'widgets/simple_appbar.dart';


class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 10.h),
        child: const SimpleAppBar(title: StringsManager.otpVerify),
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
        height: 44.h,
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
              Center(child: textStyle1(text: "Enter the Code Sent to +923187648765", textAlign: TextAlign.center)),
              buildSpaceVertical(2.h),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                  child: OtpPinField(
                    onSubmit: (text) {
                      if(text.isNotEmpty){
                        // auth.otpVerify(widget.email, text).then((response) => {
                        //   if (response['status'] == true) {
                        //     successToast(context, response['message']),
                        //     setState(() => widget.loading = false),
                        //     Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))
                        //   }else {
                        //     errorToast(context, response['message']),
                        //     setState(() => widget.loading = false),
                        //   }
                        // });
                      }
                    },
                    fieldHeight: 7.h,
                    fieldWidth: 10.w,
                    otpPinFieldStyle: const OtpPinFieldStyle(
                      defaultFieldBorderColor: Colors.grey,
                      activeFieldBorderColor: ColorManager.primaryColor,
                      defaultFieldBackgroundColor: ColorManager.grayColor,
                      activeFieldBackgroundColor: ColorManager.whiteColor,
                      fieldPadding: 10,
                    ),
                    maxLength: 6,
                    otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
                  )
              ),
              buildSpaceVertical(3.h),
              actionButton(StringsManager.submit),
            ],
          ),
        ),
      ),
    );
  }
}
