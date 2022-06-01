

import 'package:flutter/material.dart';
import 'package:topgrade/routes/appPages.dart';
import '../../../helpers/helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/action_button.dart';
import '../../widgets/text_field.dart';
import 'widgets/simple_appbar.dart';
import 'package:get/get.dart';


class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.1),
        child: const SimpleAppBar(title: StringsManager.forgotPas),
      ),
      body: Column(
        children: [
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.1),
          buildFormCard(context),
        ],
      ),
    );
  }

  Center buildFormCard(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.39,
        width: MediaQuery.of(context).size.width * 0.9,
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
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              Image.asset(AssetsManager.logo, height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.30),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              CustomTextField(
                controller: emailController,
                hintName: StringsManager.email,
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
              InkWell(
                  onTap: () {
                    Get.toNamed(Paths.otpVerify);
                  },
                  child: actionButton(StringsManager.submit, context)),
            ],
          ),
        ),
      ),
    );
  }
}
