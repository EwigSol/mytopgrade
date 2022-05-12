

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';

import '../../../helpers/text_helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/action_button.dart';
import '../../widgets/text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          children: [
            buildSpaceVertical(2.h),
            SizedBox(
              height: 15.h,
              width: 50.w,
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
                      height: 5.h,
                      width: 10.w,
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
            buildSpaceVertical(5.h),
            CustomTextField(
              controller: usernameController,
              hintName: StringsManager.userName,
            ),
            buildSpaceVertical(2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                    borderSide: BorderSide(color: ColorManager.grayColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                    borderSide: BorderSide(color: ColorManager.grayColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                    borderSide: BorderSide(color: ColorManager.redColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                    borderSide: BorderSide(color: ColorManager.redColor),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                    borderSide: BorderSide(color: ColorManager.grayColor),
                  ),
                  hintText: StringsManager.phoneNo,
                  hintStyle: TextStyle(fontSize: AppSize.s12),
                  fillColor: ColorManager.whiteColor,
                  filled: true,
                ),
                initialCountryCode: 'ZA',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
            ),
            CustomTextField(
              controller: emailController,
              hintName: StringsManager.email,
            ),

            buildSpaceVertical(6.h),
            actionButton(StringsManager.uProfile),
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
