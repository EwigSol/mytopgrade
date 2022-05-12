

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/auth/widgets/simple_appbar.dart';
import 'package:topgrade/views/widgets/action_button.dart';
import 'package:topgrade/views/widgets/text_field.dart';
import '../../../helpers/text_helper.dart';
import '../../../routes/appPages.dart';
import '../../../utils/strings_manager.dart';
import 'widgets/line_widget.dart';
import 'widgets/signup_text.dart';
import 'widgets/social_card.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  const LoginScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bool _passwordVisibleOne = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 8.h),
        child: const SimpleAppBar(title: StringsManager.login),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(6.h),
            buildFormCard(),
            buildSpaceVertical(3.h),
            const LineWidget(),
            buildSpaceVertical(2.h),
            buildSocialRow(),
          ],
        ),
      ),
      bottomSheet: SignupText(toggleView: widget.toggleView),
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
        height: 57.h,
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
              buildSpaceVertical(2.h),
              CustomTextField(
                controller: passwordController,
                hintName: StringsManager.passHint,
                isPass: true,
                passwordVisibility: _passwordVisibleOne,
              ),
              buildSpaceVertical(3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      textStyle0(text: StringsManager.rememberMe)
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed(Paths.forgotPass);
                      },
                      child: textStyle0(text: StringsManager.forgotPass),
                  )
                ],
              ),
              buildSpaceVertical(3.h),
              InkWell(
                  onTap: () {
                    Get.toNamed(Paths.homeBar);
                  },
                  child: actionButton(StringsManager.login)),
            ],
          ),
        ),
      ),
    );
  }

}
