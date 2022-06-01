


import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
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
        preferredSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.10),
        child: const SimpleAppBar(title: StringsManager.otpVerify),
      ),
      body: Column(
        children: [
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.10),
          buildFormCard(context),
        ],
      ),
    );
  }

  Center buildFormCard(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.44,
        width: MediaQuery.of(context).size.width * 0.90,
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
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.30,
                child: Image.asset(AssetsManager.logo, fit: BoxFit.fill),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              Center(child: textStyle1(text: "Enter the Code Sent to +923187648765", textAlign: TextAlign.center)),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
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
                    fieldHeight: MediaQuery.of(context).size.height * 0.07,
                    fieldWidth: MediaQuery.of(context).size.width * 0.10,
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
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
              actionButton(StringsManager.submit, context),
            ],
          ),
        ),
      ),
    );
  }
}
