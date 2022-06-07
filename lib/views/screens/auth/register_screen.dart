

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/user_model.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/auth/widgets/simple_appbar.dart';
import 'package:topgrade/views/widgets/action_button.dart';
import 'package:topgrade/views/widgets/text_field.dart';
import '../../../controllers/register_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../routes/appPages.dart';
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
  final bool _passwordVisibleOne = false;
  var registerController = Get.put(RegisterController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
        child: const SimpleAppBar(title: StringsManager.register),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
            buildFormCard(),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.06),
            // const LineWidget(),
            // buildSpaceVertical(1.h),
            // buildSocialRow(),
            // buildSpaceVertical(1.h),
            LoginText(toggleView: widget.toggleView)
          ],
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
        height: MediaQuery.of(context).size.height * 0.72,
        width: MediaQuery.of(context).size.width * 0.90,
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
              Center(child: Image.asset(AssetsManager.logo, height: MediaQuery.of(context).size.height * 0.13, width: MediaQuery.of(context).size.width * 0.26)),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Username"),
              ),
              CustomTextField(
                controller: usernameController,
                hintName: StringsManager.userName,
              ),
              // Padding(
              //   padding: const EdgeInsets.only( top:AppPadding.p10, left: AppPadding.p10, bottom: AppPadding.p6),
              //   child: textStyle11(text: "Phone No"),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
              //     child: IntlPhoneField(
              //       decoration: const InputDecoration(
              //         enabledBorder:  OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
              //           borderSide: BorderSide(color: ColorManager.grayColor),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
              //           borderSide: BorderSide(color: ColorManager.grayColor),
              //         ),
              //         errorBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
              //           borderSide: BorderSide(color: ColorManager.redColor),
              //         ),
              //         focusedErrorBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
              //           borderSide: BorderSide(color: ColorManager.redColor),
              //         ),
              //         disabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
              //           borderSide: BorderSide(color: ColorManager.grayColor),
              //         ),
              //         hintText: StringsManager.phoneNo,
              //         hintStyle: TextStyle(fontSize: AppSize.s12),
              //         fillColor: ColorManager.whiteColor,
              //         filled: true,
              //       ),
              //       initialCountryCode: 'ZA',
              //       onChanged: (phone) {
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Email"),
              ),
              CustomTextField(
                controller: emailController,
                hintName: StringsManager.email,
              ),
              Padding(
                padding: const EdgeInsets.only(top:AppPadding.p10, left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Password"),
              ),
              CustomTextField(
                controller: passwordController,
                hintName: StringsManager.passHint,
                isPass: true,
                passwordVisibility: _passwordVisibleOne,
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              InkWell(
                onTap: () {
                  UserModel userModel;
                  if(usernameController.text.isNotEmpty){
                    if(emailController.text.isNotEmpty){
                      if(passwordController.text.isNotEmpty){
                        registerController.register(usernameController.text, emailController.text, passwordController.text).then((response) => {
                          if(response['status'] == true) {
                            userModel = response['userData'],
                            box.write("user_id", userModel.id.toString()),
                            box.write("user_email", userModel.email),
                            box.write("user_display_name", userModel.username),
                            Get.toNamed(Paths.homeBar)
                          }else{
                            errorToast("Error", response['message']),
                          }
                        });
                      }else{
                        errorToast("Error", "Password is required");
                      }
                    }else{
                      errorToast("Error", "Email is required");
                    }
                  }else{
                    errorToast("Error", "UserName is required");
                  }

                },
                child: Obx((){
                  if(registerController.isDataSubmitting.value == true){
                    return const Center(child: CircularProgressIndicator());
                  }else{
                    return Center(child: actionButton(StringsManager.register, context));
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
