

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/auth/widgets/simple_appbar.dart';
import 'package:topgrade/views/widgets/action_button.dart';
import 'package:topgrade/views/widgets/text_field.dart';
import '../../../controllers/login_controller.dart';
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

  var loginController = Get.put(LoginController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bool _passwordVisibleOne = false;
  bool rememberMe = false;
  final box = GetStorage();

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
            buildSpaceVertical(6.h),
            // const LineWidget(),
            // buildSpaceVertical(2.h),
            // buildSocialRow(),
            // buildSpaceVertical(3.h),
            SignupText(toggleView: widget.toggleView)
          ],
        ),
      ),
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
          borderRadius: BorderRadius.circular(AppSize.s22),
          color: ColorManager.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(AssetsManager.logo, height: 15.h, width: 30.w)),
              buildSpaceVertical(1.h),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p10, bottom: AppPadding.p10),
                child: textStyle11(text: "Email"),
              ),
              CustomTextField(
                controller: emailController,
                hintName: StringsManager.email,
              ),
              buildSpaceVertical(1.h),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p10, bottom: AppPadding.p10),
                child: textStyle11(text: "Password"),
              ),
              CustomTextField(
                controller: passwordController,
                hintName: StringsManager.passHint,
                isPass: true,
                passwordVisibility: _passwordVisibleOne,
              ),
              buildSpaceVertical(2.h),
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
                    if(emailController.text.isNotEmpty){
                      if(passwordController.text.isNotEmpty){
                        loginController.login(emailController.text, passwordController.text).then((response) => {
                          if(response['status'] == true) {
                            box.write("token", response['token']),
                            box.write("user_id", response['user_id']),
                            box.write("user_login", response['user_login']),
                            box.write("user_email", response['user_email']),
                            box.write("user_display_name", response['user_display_name']),
                            box.write("isLogged", true),
                            Get.toNamed(Paths.homeBar)
                          }else{
                            errorToast("Error", "Unable to login"),
                          }
                        });
                      }else{
                        errorToast("Error", "Email is required");
                      }
                    }else{
                      errorToast("Error", "Password is required");
                    }
                  },
                  child: Obx((){
                    if(loginController.isDataSubmitting.value == true){
                      return const Center(child: CircularProgressIndicator());
                    }else{
                      return Center(child: actionButton(StringsManager.login));
                    }
                  }),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
