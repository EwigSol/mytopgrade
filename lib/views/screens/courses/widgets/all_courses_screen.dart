

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

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({Key? key}) : super(key: key);
  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {

  List<CategoryModel> categoryModel = [];
  double _value = 67;

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      categoryModel.add(CategoryModel(
          id: "1", icon: "icon", title: "Business", color: "color"));
      categoryModel.add(CategoryModel(
          id: "2", icon: "icon", title: "Business", color: "color"));
      categoryModel.add(CategoryModel(
          id: "3", icon: "icon", title: "Business", color: "color"));
      categoryModel.add(CategoryModel(
          id: "4", icon: "icon", title: "Business", color: "color"));
      categoryModel.add(CategoryModel(
          id: "5", icon: "icon", title: "Business", color: "color"));
      categoryModel.add(CategoryModel(
          id: "6", icon: "icon", title: "Business", color: "color"));
      categoryModel.add(CategoryModel(
          id: "7", icon: "icon", title: "Business", color: "color"));
      categoryModel.add(CategoryModel(
          id: "8", icon: "icon", title: "Business", color: "color"));
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
                    return buildCoursesCard();
                  }).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildCoursesCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p10),
      child: InkWell(
        onTap: () {
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
                child: textStyle0(text: "By Talent Tamer", color: ColorManager.grayColor),
              ),
              buildSpaceVertical(2.h),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4, right: AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle00(text: "Completed $_value%"),
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
