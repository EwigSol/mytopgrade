import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytopgrade/controllers/userController/userController.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/views/widgets/passwordFields.dart';
import '../../../controllers/update_customer_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/action_button.dart';
import '../../widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Img;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final box = GetStorage();
  final updateCustomerController = Get.put(UpdateCustomerController());
  final userController = Get.put(UserController());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    getValues();
  }

  getValues() {
    userController.getCustomer();
    Future.delayed(Duration(seconds: 3)).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    var user = Get.find<UserController>();
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.50,
                child: Stack(
                  children: [
                    user.userModel.value.avatarUrl != null
                        ? Obx(
                            () => Center(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: ColorManager.halfWhiteColor,
                                backgroundImage: NetworkImage(
                                    user.userModel.value.avatarUrl!),
                              ),
                            ),
                          )
                        : const Center(
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: ColorManager.halfWhiteColor,
                              backgroundImage: AssetImage(AssetsManager.person),
                            ),
                          ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
              PasswordTextField(
                controller: passwordController,
                hintName: 'Enter New Password',
                isPass: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              PasswordTextField(
                controller: confirmPasswordController,
                hintName: 'Confirm Password',
                isPass: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              InkWell(
                onTap: () async {
                  if (passwordController.text.isNotEmpty &&
                      passwordController.text.length >= 6 &&
                      confirmPasswordController.text.length >= 6 &&
                      confirmPasswordController.text.isNotEmpty) {
                    var id = box.read("user_id");
                    await updateCustomerController.changePassword(
                        passwordController.text, id);
                  } else {
                    errorToast("Error",
                        "Password not Matched & must be minimum of 6 characters");
                  }
                },
                child: Obx(() {
                  if (updateCustomerController.isDataSubmitting.value == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return actionButton("UPDATE", context);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: 'Change Password'),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
