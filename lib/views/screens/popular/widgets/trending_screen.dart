
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../models/category_model.dart';
import '../../../../routes/appPages.dart';
import '../../../../utils/assets_manager.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);
  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {

  List<CategoryModel> categoryModel = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      categoryModel.add(CategoryModel(
          id: "1", icon: const Icon(Icons.design_services_rounded, color: ColorManager.lightPurpleColor), title: "Design", color: ColorManager.pinkColor));
      categoryModel.add(CategoryModel(
          id: "2", icon: const Icon(Icons.developer_mode_outlined, color: ColorManager.lightPurpleColor), title: "Development", color: ColorManager.greenColor));
      categoryModel.add(CategoryModel(
          id: "3", icon: const Icon(Icons.announcement_rounded, color: ColorManager.pinkColor), title: "Marketing", color: ColorManager.lightPurpleColor));
      categoryModel.add(CategoryModel(
          id: "4", icon: const Icon(Icons.lightbulb, color: ColorManager.lightBlueColor), title: "Business", color: ColorManager.lightGreenColor));
      categoryModel.add(CategoryModel(
          id: "5", icon: const Icon(Icons.favorite ,color: ColorManager.redColor), title: "Healthy", color: ColorManager.lightBlueColor));
      categoryModel.add(CategoryModel(
          id: "6", icon: const Icon(Icons.photo, color: ColorManager.greenColor), title: "Photography", color: ColorManager.lightPurpleColor));
      categoryModel.add(CategoryModel(
          id: "7", icon: const Icon(Icons.volunteer_activism, color: ColorManager.lightBlueColor), title: "LifeStyle", color: ColorManager.greenColor));
      categoryModel.add(CategoryModel(
          id: "8", icon: const Icon(Icons.music_note_rounded, color: ColorManager.pinkColor), title: "Music", color: ColorManager.lightBlueColor));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Column(
          children: [
            buildSpaceVertical(5.h),
            Center(
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 5,
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceEvenly,
                  children: categoryModel.map((item) {
                    return buildPopularCard();
                  }).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildPopularCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p20),
      child: InkWell(
        onTap: (){
          Get.toNamed(Paths.details);
        },
        child: Container(
          width: 40.w,
          decoration: const BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s10),
                topRight: Radius.circular(AppSize.s10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 14.h,
                  width: 100.w,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 14.h,
                          width: 100.w,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s10),
                                  topRight: Radius.circular(AppSize.s10)),
                              child: Image.asset(AssetsManager.card,
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: 4.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s16),
                                bottomLeft: Radius.circular(AppSize.s16),
                              )),
                          child: Center(
                              child: textStyle0_5(
                                  text: "\$50", color: ColorManager.whiteColor)),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0_5(text: "User Interface Design"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0(
                    text: "By Talent Tamer", color: ColorManager.grayColor),
              ),
              buildSpaceVertical(2.h),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p4, right: AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 3.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(2.w),
                        textStyle0(text: "27 Videos")
                      ],
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
