import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topgrade/controllers/wishlist_controller.dart';
import 'package:topgrade/models/wishlist_model.dart';
import '../../../helpers/helper.dart';
import '../../../helpers/text_helper.dart';
import '../../../routes/appPages.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  var wishlistController = Get.put(WishlistController());
  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          child: Column(
            children: [
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
              Obx(() {
                if (wishlistController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return wishlistController.wishlist.value != null
                      ? wishlistController
                              .wishlist.value!.data!.items!.isNotEmpty
                          ? Center(
                              child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 5,
                                  runSpacing: 10,
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: wishlistController
                                      .wishlist.value!.data!.items!
                                      .map((item) {
                                    return buildWishlistCard(item);
                                  }).toList()),
                            )
                          : Center(
                              child: textStyle0_5(text: "No Item in Wishlist"))
                      : Center(
                          child: textStyle0_5(text: "No Wishlist Available"));
                }
              }),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.wish),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }

  Padding buildWishlistCard(DataItem wishlistModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p6, vertical: AppPadding.p4),
      child: InkWell(
        onTap: () {
          Get.toNamed(Paths.details,
              arguments: wishlistModel, parameters: {"isWishlist": "true"});
        },
        child: Container(
          width: width * 0.40,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  // height: height * 0.14,
                  width: width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: height * 0.12,
                          width: width,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s10),
                                  topRight: Radius.circular(AppSize.s10)),
                              child: Image.network(wishlistModel.image!,
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.12,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )),
                          child: Center(
                            child: wishlistModel.price != 0
                                ? textStyle0(
                                    text:
                                        "\$\ ${wishlistModel.price.toString()}",
                                    color: ColorManager.whiteColor)
                                : textStyle0(
                                    text: " Free ",
                                    color: ColorManager.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: textStyle0_5(text: wishlistModel.name!),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                ),
                child: textStyle0(
                    text: wishlistModel.instructor!.name.toString(),
                    color: ColorManager.grayColor),
              ),
              buildSpaceVertical(height * 0.01),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: height * 0.024,
                          // width: width * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                size: 16, color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(width * 0.02),
                        textStyle0(
                            text: "Sections: ${wishlistModel.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(width * 0.02),
                        textStyle0(text: wishlistModel.rating.toString())
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
