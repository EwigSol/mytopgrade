import 'package:flutter/material.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/views/screens/auth/login_screen.dart';
import 'package:mytopgrade/views/screens/auth/widgets/simple_appbar.dart';
import 'package:mytopgrade/views/widgets/action_button.dart';
import 'package:get/get.dart';

class ForgetResult extends StatelessWidget {
  const ForgetResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.1),
        child: const SimpleAppBar(title: 'Check your Email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'An Email Has Been Sent To your Email Address \n Please Check Your Email & Reset Your password',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: 20,
                color: ColorManager.primaryColor,
              ),
            ),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.1),
            InkWell(
                onTap: () {
                  //TODO: call forget pass controller.
                  Get.back();
                },
                child: actionButton('Got to Login', context)),
          ],
        ),
      ),
    );
  }
}
