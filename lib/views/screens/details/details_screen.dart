

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/values_manager.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import 'widgets/description_screen.dart';
import 'package:get/get.dart';
import 'widgets/playlist_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin{

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSpaceVertical(1.h),
          SizedBox(
              height: 28.h,
              width: 100.w,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 25.h,
                      width: 80.w,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppSize.s10),
                              topRight: Radius.circular(AppSize.s10)),
                          child: Image.asset(AssetsManager.card,
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 10,
                    child: Container(
                      height: 5.h,
                      width: 20.w,
                      decoration: const BoxDecoration(
                          color: ColorManager.redColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s16),
                            bottomLeft: Radius.circular(AppSize.s16),
                            topRight: Radius.circular(AppSize.s16),
                            bottomRight: Radius.circular(AppSize.s16),
                          )),
                      child: Center(
                          child: textStyle0_5(
                              text: "\$50", color: ColorManager.whiteColor)),
                    ),
                  ),
                ],
              )),
          buildSpaceVertical(2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textStyle2(text: "User Interface Design"),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    textStyle0(text: "⭐"),
                    buildSpaceHorizontal(2.w),
                    textStyle0(text: "3.5")
                  ],
                ),
              ],
            ),
          ),
          buildSpaceVertical(0.5.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textStyle0_5(text: "By Talent Tamer", color: ColorManager.grayColor),
                textStyle0(text: "8h 30Min - 27 Tutorials"),

              ],
            ),
          ),

          buildSpaceVertical(1.h),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p10, horizontal: AppPadding.p12),
            child: TabBar(
              isScrollable: true,
              indicator: BoxDecoration(color: ColorManager.redColor, borderRadius: BorderRadius.circular(AppSize.s22)),
              controller: _controller,
              tabs: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35, 
                    child: Tab(
                        child: textStyle0_5(text: "Playlist")
                    )
                ),

                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Tab(
                        child: textStyle0_5(text: "Description")
                    )
                ),
              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
              controller: _controller,
              children: const [
                Playlist(),
                DescriptionScreen()
              ],
            ),
          )

        ],
      ),
      bottomSheet: buildBottomCard(),
    );
  }

  Container buildBottomCard() {
    return Container(
      height: 7.h,
      width: 100.w,
      color: ColorManager.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Get.toNamed(Paths.cart);
            },
            child: Container(
              height: 6.h,
              width: 18.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s12),
                color: ColorManager.halfWhiteColor
              ),
              child: const Center(child: Icon(Icons.shopping_cart, color: ColorManager.redColor, size: 35)),
            ),
          ),
          buildSpaceHorizontal(10.w),
          Container(
            height: 6.h,
            width: 53.w,
            decoration: BoxDecoration(
              color: ColorManager.redColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primaryColor.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Buy Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.details),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
      actions: [
        Container(
          height: 5.h,
          width: 5.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s16),
            color: ColorManager.whiteColor
          ),
          child: const Icon(Icons.favorite, color: ColorManager.redColor),
        ),
        buildSpaceHorizontal(10.w)
      ],
    );
  }
}
