import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/controllers/login_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/models/user_model.dart';
import 'package:mytopgrade/utils/assets_manager.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:mytopgrade/views/screens/auth/widgets/simple_appbar.dart';
import 'package:mytopgrade/views/screens/home/home_screen.dart';
import 'package:mytopgrade/views/widgets/action_button.dart';
import 'package:mytopgrade/views/widgets/text_field.dart';
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
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());
  final bool _passwordVisibleOne = false;
  var registerController = Get.put(RegisterController());
  final box = GetStorage();
  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSpaceVertical(height * 0.06),
              buildFormCard(),
              buildSpaceVertical(height * 0.03),
              LoginText(toggleView: widget.toggleView)
            ],
          ),
        ),
      ),
      // bottomSheet: ,
    );
  }

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
                      height: height * 0.15, width: width * 0.30)),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Username"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CustomTextField(
                  controller: usernameController,
                  hintName: StringsManager.userName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Email"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CustomTextField(
                  controller: emailController,
                  hintName: StringsManager.email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p6),
                child: textStyle11(text: "Phone"),
              ),
              CustomTextField(
                controller: phoneController,
                hintName: StringsManager.phoneNo,
                inputType: TextInputType.phone,
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
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              InkWell(
                onTap: () async {
                  print(emailController.text);
                  await registerController.register(
                      usernameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text);
                },
                child: Obx(() {
                  if (registerController.isDataSubmitting.value == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                        child: actionButton(StringsManager.register, context));
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
