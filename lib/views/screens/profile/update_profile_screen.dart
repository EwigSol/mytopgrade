import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/helpers/helper.dart';
import '../../../controllers/update_customer_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../models/user_model.dart';
import '../../../routes/appPages.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/action_button.dart';
import '../../widgets/text_field.dart';
import 'package:get/get.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final box = GetStorage();
  var updateCustomerController = Get.put(UpdateCustomerController());

  @override
  void initState() {
    super.initState();
    usernameController.text = box.read("user_display_name");
    emailController.text = box.read("user_email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.50,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: ColorManager.halfWhiteColor,
                      backgroundImage: AssetImage(AssetsManager.person),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s30),
                        color: ColorManager.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
            CustomTextField(
              controller: usernameController,
              hintName: StringsManager.userName,
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            CustomTextField(
              controller: emailController,
              hintName: StringsManager.email,
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            CustomTextField(
              controller: emailController,
              hintName: 'Enter Your First Name',
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            CustomTextField(
              controller: emailController,
              hintName: 'Enter Your Last Name',
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            CustomTextField(
              controller: emailController,
              hintName: "Enter Your Phone Number",
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.06),
            InkWell(
              onTap: () {
                UserModel userModel;
                if (usernameController.text.isNotEmpty) {
                  if (emailController.text.isNotEmpty) {
                    var id = box.read("user_id");
                    updateCustomerController
                        .updateCustomer(
                            usernameController.text, emailController.text, id)
                        .then((response) => {
                              if (response['status'] == true)
                                {
                                  userModel = response['userData'],
                                  box.write("user_id", userModel.id.toString()),
                                  box.write("user_email", userModel.email),
                                  box.write(
                                      "user_display_name", userModel.username),
                                  Get.toNamed(Paths.homeBar)
                                }
                              else
                                {
                                  errorToast("Error", response['message']),
                                }
                            });
                  } else {
                    errorToast("Error", "Email is required");
                  }
                } else {
                  errorToast("Error", "User Name is required");
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
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.eProfile),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }
}
