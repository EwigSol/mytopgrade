

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/auth/widgets/simple_appbar.dart';
import 'package:topgrade/views/widgets/action_button.dart';
import 'package:topgrade/views/widgets/text_field.dart';
import '../../../utils/strings_manager.dart';
import 'widgets/line_widget.dart';
import 'widgets/login_text.dart';
import 'widgets/social_card.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  const RegisterScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bool _passwordVisibleOne = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 5.h),
        child: const SimpleAppBar(title: StringsManager.register),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(3.h),
            buildFormCard(),
            buildSpaceVertical(3.h),
            const LineWidget(),
            buildSpaceVertical(2.h),
            buildSocialRow(),
          ],
        ),
      ),
      bottomSheet: LoginText(toggleView: widget.toggleView),
    );
  }

  Padding buildSocialRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SocialCard(img: AssetsManager.fbLogo),
          SocialCard(img: AssetsManager.googleLogo),
          SocialCard(img: AssetsManager.twitterLogo),
        ],
      ),
    );
  }

  Center buildFormCard() {
    return Center(
      child: Container(
        height: 60.h,
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
                height: 10.h,
                width: 25.w,
                child: Image.asset(AssetsManager.logo, fit: BoxFit.fill),
              ),
              buildSpaceVertical(1.h),
              CustomTextField(
                controller: usernameController,
                hintName: StringsManager.userName,
              ),
              buildSpaceVertical(1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
                child: IntlPhoneField(
                  decoration: const InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.primaryColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.redColor),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.redColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                      borderSide: BorderSide(color: ColorManager.primaryColor),
                    ),
                    hintText: StringsManager.phoneNo,
                    hintStyle: TextStyle(fontSize: AppSize.s12),
                    fillColor: ColorManager.whiteColor,
                    filled: true,
                  ),
                  initialCountryCode: 'ZA',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
              ),
              CustomTextField(
                controller: emailController,
                hintName: StringsManager.email,
              ),
              buildSpaceVertical(1.h),
              CustomTextField(
                controller: passwordController,
                hintName: StringsManager.passHint,
                isPass: true,
                passwordVisibility: _passwordVisibleOne,
              ),
              buildSpaceVertical(3.h),
              actionButton(StringsManager.register),
            ],
          ),
        ),
      ),
    );
  }

}
