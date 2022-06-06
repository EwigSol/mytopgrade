import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:topgrade/controllers/login_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/auth/login_screen.dart';
import 'package:topgrade/views/screens/home/home_screen.dart';
import 'package:topgrade/views/widgets/action_button.dart';
import 'package:topgrade/views/widgets/text_field.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/strings_manager.dart';
import 'widgets/login_text.dart';
import 'package:get/get.dart';

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
  var loginController = Get.put(LoginController());
  final bool _passwordVisibleOne = false;
  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSpaceVertical(height * 0.03),
              buildFormCard(),
              buildSpaceVertical(height * 0.06),
              // const LineWidget(),
              // buildSpaceVertical(1.h),
              // buildSocialRow(),
              // buildSpaceVertical(1.h),
              LoginText(toggleView: widget.toggleView)
            ],
          ),
        ),
      ),
      // bottomSheet: ,
    );
  }

  // Padding buildSocialRow() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: const [
  //         SocialCard(img: AssetsManager.fbLogo),
  //         SocialCard(img: AssetsManager.googleLogo),
  //         SocialCard(img: AssetsManager.twitterLogo),
  //       ],
  //     ),
  //   );
  // }

  Center buildFormCard() {
    return Center(
      child: Container(
        height: height * 0.75,
        width: width * 0.90,
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
              Center(
                  child: Image.asset(AssetsManager.logo,
                      height: height * 0.13, width: width * 0.26)),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Username"),
              ),
              CustomTextField(
                controller: usernameController,
                hintName: StringsManager.userName,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p10,
                    left: AppPadding.p10,
                    bottom: AppPadding.p6),
                child: textStyle11(text: "Phone No"),
              ),
              SizedBox(
                height: height * 0.1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p6),
                  child: IntlPhoneField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.grayColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.grayColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s10)),
                        borderSide: BorderSide(color: ColorManager.grayColor),
                      ),
                      hintText: StringsManager.phoneNo,
                      hintStyle: TextStyle(fontSize: AppSize.s12),
                      fillColor: ColorManager.whiteColor,
                      filled: true,
                    ),
                    initialCountryCode: 'ZA',
                    onChanged: (phone) {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Email"),
              ),
              CustomTextField(
                controller: emailController,
                hintName: StringsManager.email,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p10,
                    left: AppPadding.p10,
                    bottom: AppPadding.p6),
                child: textStyle11(text: "Password"),
              ),
              CustomTextField(
                controller: passwordController,
                hintName: StringsManager.passHint,
                isPass: true,
                passwordVisibility: _passwordVisibleOne,
              ),
              buildSpaceVertical(height * 0.02),
              Center(
                  child: InkWell(
                      onTap: () async {
                        await loginController.createUser(
                            userName: usernameController.text,
                            email: emailController.text,
                            password: passwordController.text);
                        Get.to(LoginScreen);
                        print(usernameController.text +
                            emailController.text +
                            passwordController.text);
                      },
                      child: actionButton(StringsManager.register, context))),
            ],
          ),
        ),
      ),
    );
  }
}
