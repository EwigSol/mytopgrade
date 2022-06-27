import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/controllers/firebasecontroller.dart/socialauthcontroller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
// import 'package:topgrade/views/screens/auth/widgets/simple_appbar.dart';
import 'package:topgrade/views/widgets/action_button.dart';
import 'package:topgrade/views/widgets/text_field.dart';
import '../../../controllers/login_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../routes/appPages.dart';
import '../../../utils/strings_manager.dart';
import 'widgets/signup_text.dart';
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
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final bool _passwordVisibleOne = false;
  bool rememberMe = false;
  final box = GetStorage();
  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, height * 0.08),
      //   child: const SimpleAppBar(title: StringsManager.login),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSpaceVertical(height * 0.06),
              buildFormCard(),
              buildSpaceVertical(height * 0.06),
              SignupText(toggleView: widget.toggleView),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Expanded(
              //       child: Divider(
              //         thickness: 2,
              //         indent: 10,
              //         endIndent: 20,
              //       ),
              //     ),
              //     Container(
              //       width: 52,
              //       padding: const EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black),
              //         borderRadius: BorderRadius.circular(
              //           100,
              //         ),
              //       ),
              //       child: SvgPicture.asset(
              //         'assets/images/facebookicon.svg',
              //         color: Colors.black,
              //         width: 30,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     InkWell(
              //       onTap: () => firebaseAuthController.googleLogin(),
              //       child: Container(
              //         width: 52,
              //         padding: const EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.black),
              //           borderRadius: BorderRadius.circular(
              //             100,
              //           ),
              //         ),
              //         child: SvgPicture.asset(
              //           'assets/images/googleicon.svg',
              //           color: Colors.black,
              //           width: 30,
              //         ),
              //       ),
              //     ),
              //     const Expanded(
              //       child: Divider(
              //         thickness: 2,
              //         indent: 10,
              //         endIndent: 20,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Center buildFormCard() {
    return Center(
      child: Container(
        height: height * 0.63,
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
                      height: height * 0.15, width: width * 0.30)),
              buildSpaceVertical(height * 0.01),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p10),
                child: textStyle11(text: "Email"),
              ),
              CustomTextField(
                controller: emailController,
                hintName: StringsManager.email,
              ),
              buildSpaceVertical(height * 0.01),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p10),
                child: textStyle11(text: "Password"),
              ),
              CustomTextField(
                controller: passwordController,
                hintName: StringsManager.passHint,
                isPass: true,
                passwordVisibility: _passwordVisibleOne,
              ),
              buildSpaceVertical(height * 0.02),
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
              buildSpaceVertical(height * 0.03),
              InkWell(
                onTap: () async {
                  if (emailController.text.isNotEmpty) {
                    if (passwordController.text.isNotEmpty) {
                      await loginController
                          .login(emailController.text, passwordController.text)
                          .then((response) => {
                                if (response['status'] == true)
                                  {
                                    // box.write("token", response['token']),
                                    // box.write("user_id", response['user_id']),
                                    // box.write(
                                    //     "user_login", response['user_login']),
                                    // box.write(
                                    //     "user_email", response['user_email']),
                                    box.write("user_id", response['user_id']),
                                    box.write(
                                        "user_email", response['user_email']),
                                    box.write("user_display_name",
                                        response['user_display_name']),
                                    // box.write("isLogged", true),

                                    Get.snackbar('Welcome Back',
                                        'Welcome ${box.read("user_display_name")} to your Educational Portal',
                                        snackPosition: SnackPosition.BOTTOM),
                                    Get.offAllNamed(Paths.homeBar),
                                  }
                                else
                                  {
                                    errorToast("Error",
                                        "Please Check your Email or Password"),
                                  }
                              });
                    } else {
                      errorToast("Error", "Email is required");
                    }
                  } else {
                    errorToast("Error", "Password is required");
                  }
                },
                child: Obx(() {
                  if (loginController.isDataSubmitting.value == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                        child: actionButton(StringsManager.login, context));
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
