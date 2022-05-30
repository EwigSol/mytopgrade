

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/favourites/favourites_screen.dart';
import 'package:topgrade/views/screens/notification/notifications_screen.dart';
import 'package:topgrade/views/screens/profile/update_profile_screen.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSpaceVertical(2.h),
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: ColorManager.halfWhiteColor,
              backgroundImage: AssetImage(AssetsManager.person),
            ),
          ),
          buildSpaceVertical(3.h),
          InkWell(
              onTap: () {
                // Get.toNamed(Paths.updateProfile)
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
              },
              child: buildProfileCard("Edit Profile", Icons.edit)
          ),
          buildSpaceVertical(2.h),
          buildProfileCard("Payment Details", Icons.account_balance_wallet_outlined),
          buildSpaceVertical(2.h),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
              },
              child: buildProfileCard("Notification", Icons.notifications)),
          buildSpaceVertical(2.h),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FavouritesScreen()));
              },
              child: buildProfileCard("Wishlist", Icons.favorite)),
          buildSpaceVertical(2.h),
          buildProfileCard("Language", Icons.language),
          buildSpaceVertical(2.h),
          InkWell(
              onTap: () {
                final box = GetStorage();
                box.remove("token");
                box.remove("user_id");
                box.remove("user_login");
                box.remove("user_email");
                box.remove("user_display_name");
                box.remove("isLogged");
                Get.offAllNamed(Paths.authView);
              },
              child: buildProfileCard("Log Out", Icons.logout)),
        ],
      ),
    );
  }

  Center buildProfileCard(String title, IconData icon, ) {
    return Center(
      child: Container(
        height: 7.h,
        width: 85.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s22),
            color: ColorManager.primaryColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 4.h,
                    width: 8.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s30),
                      color: ColorManager.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 20),
                  ),
                  buildSpaceHorizontal(5.w),
                  textStyle1(text: title, color: ColorManager.whiteColor),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, color: ColorManager.whiteColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.profile),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
