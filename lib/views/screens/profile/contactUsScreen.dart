import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mytopgrade/controllers/contactUsController.dart';
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

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final messageController = TextEditingController();
  final subjectController = TextEditingController();
  final phoneController = TextEditingController();
  final box = GetStorage();
  final ContactUsController contactUsController =
      Get.put(ContactUsController());
  final userController = Get.put(UserController());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    getValues();
  }

  getValues() {
    userController.getCustomer();
    Future.delayed(Duration(seconds: 3)).then((_) {
      emailController.text = box.read("user_email");
      firstNameController.value = TextEditingValue(
          text: Get.find<UserController>().userModel.value.firstName!);
      lastNameController.value = TextEditingValue(
          text: Get.find<UserController>().userModel.value.lastName!);
      nameController.text =
          '${firstNameController.text} ${lastNameController.text}';
    });
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.15,
              //   width: MediaQuery.of(context).size.width * 0.50,
              //   child: Stack(
              //     children: [
              //       user.userModel.value.avatarUrl != null
              //           ? Obx(
              //               () => Center(
              //                 child: CircleAvatar(
              //                   radius: 70,
              //                   backgroundColor: ColorManager.halfWhiteColor,
              //                   backgroundImage: NetworkImage(
              //                       user.userModel.value.avatarUrl!),
              //                 ),
              //               ),
              //             )
              //           : const Center(
              //               child: CircleAvatar(
              //                 radius: 70,
              //                 backgroundColor: ColorManager.halfWhiteColor,
              //                 backgroundImage: AssetImage(AssetsManager.person),
              //               ),
              //             ),
              //     ],
              //   ),
              // ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
              CustomTextField(
                controller: nameController,
                hintName: StringsManager.userName,
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              CustomTextField(
                controller: emailController,
                hintName: 'Enter Your Name',
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              CustomTextField(
                controller: subjectController,
                hintName: 'Enter Subject',
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              CustomTextField(
                controller: messageController,
                hintName: "Enter Message",
                inputLines: 5,
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              InkWell(
                onTap: () async {
                  if (subjectController.text.isNotEmpty &&
                      messageController.text.isNotEmpty) {
                    await contactUsController.sendEmail(
                      nameController.text,
                      emailController.text,
                      subjectController.text,
                      messageController.text,
                    );
                    Navigator.pop(context);
                  } else {
                    Get.snackbar('Error', 'Please Fill all Fields',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white);
                  }
                },
                child: Obx(() {
                  if (contactUsController.isDataSubmitting.value == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return actionButton("SendMessage", context);
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
    firstNameController.dispose();
    lastNameController.dispose();
  }
}
