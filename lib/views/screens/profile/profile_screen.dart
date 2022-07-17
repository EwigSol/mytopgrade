import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/controllers/firebasecontroller.dart/socialauthcontroller.dart';
import 'package:mytopgrade/controllers/userController/userController.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/helpers/text_helper.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/utils/assets_manager.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/strings_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:mytopgrade/views/screens/favourites/favourites_screen.dart';
import 'package:mytopgrade/views/screens/profile/orderDetalilScreen.dart';
import 'package:mytopgrade/views/screens/profile/update_profile_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final FirebaseAuthController firebaseAuthController =
      Get.put(FirebaseAuthController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    var user = Get.find<UserController>();
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.06),
          user.userModel.value.avatarUrl != null
              ? Obx(
                  () => Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: ColorManager.halfWhiteColor,
                      backgroundImage:
                          NetworkImage(user.userModel.value.avatarUrl!),
                      // AssetImage(AssetsManager.person),
                    ),
                  ),
                )
              : const Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: ColorManager.halfWhiteColor,
                    backgroundImage:
                        // NetworkImage(user.userModel.value.avatarUrl!),
                        AssetImage(AssetsManager.person),
                  ),
                ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.09),
          InkWell(
              onTap: () {
                // Get.toNamed(Paths.updateProfile)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProfileScreen()));
              },
              child: buildProfileCard("Edit Profile", Icons.edit, context)),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          InkWell(
            onTap: () {
              Get.to(() => OrderList());
            },
            child: buildProfileCard("Payment Details",
                Icons.account_balance_wallet_outlined, context),
          ),
          // buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          // InkWell(
          //     onTap: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
          //     },
          //     child: buildProfileCard("Notification", Icons.notifications, context)),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavouritesScreen()));
              },
              child: buildProfileCard("Wishlist", Icons.favorite, context)),
          // buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          // buildProfileCard("Language", Icons.language, context),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          InkWell(
              onTap: () async {
                final box = GetStorage();
                box.remove("token");
                box.remove("user_id");
                box.remove("user_login");
                box.remove("user_email");
                box.remove("user_display_name");
                box.remove("isLogged");
                await firebaseAuthController.signOut();
                Get.offAllNamed(Paths.authView);
              },
              child: buildProfileCard("Log Out", Icons.logout, context)),
        ],
      ),
    );
  }

  Center buildProfileCard(String title, IconData icon, BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.85,
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
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.12,
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
                  buildSpaceHorizontal(
                      MediaQuery.of(context).size.width * 0.05),
                  textStyle2(text: title, color: ColorManager.whiteColor),
                ],
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: ColorManager.whiteColor, size: 25),
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

  @override
  void dispose() {
    userController.dispose();
  }
}
