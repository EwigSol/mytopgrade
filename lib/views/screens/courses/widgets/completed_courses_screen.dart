

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../models/dummy_category_model.dart';
import '../../../../routes/appPages.dart';
import '../../../../utils/assets_manager.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';
import '../../details/details_screen.dart';

class CompletedCoursesScreen extends StatefulWidget {
  const CompletedCoursesScreen({Key? key}) : super(key: key);
  @override
  State<CompletedCoursesScreen> createState() => _CompletedCoursesScreenState();
}

class _CompletedCoursesScreenState extends State<CompletedCoursesScreen> {

  List<DummyCategoryModel> categoryModel = [];
  double _value = 67;

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      categoryModel.add(DummyCategoryModel(
          id: "1", icon: const Icon(Icons.design_services_rounded, color: ColorManager.lightPurpleColor), title: "Design", color: ColorManager.pinkColor));
      categoryModel.add(DummyCategoryModel(
          id: "2", icon: const Icon(Icons.developer_mode_outlined, color: ColorManager.lightPurpleColor), title: "Development", color: ColorManager.greenColor));
      categoryModel.add(DummyCategoryModel(
          id: "3", icon: const Icon(Icons.announcement_rounded, color: ColorManager.pinkColor), title: "Marketing", color: ColorManager.lightPurpleColor));
      categoryModel.add(DummyCategoryModel(
          id: "4", icon: const Icon(Icons.lightbulb, color: ColorManager.lightBlueColor), title: "Business", color: ColorManager.lightGreenColor));
      categoryModel.add(DummyCategoryModel(
          id: "5", icon: const Icon(Icons.favorite ,color: ColorManager.redColor), title: "Healthy", color: ColorManager.lightBlueColor));
      categoryModel.add(DummyCategoryModel(
          id: "6", icon: const Icon(Icons.photo, color: ColorManager.greenColor), title: "Photography", color: ColorManager.lightPurpleColor));
      categoryModel.add(DummyCategoryModel(
          id: "7", icon: const Icon(Icons.volunteer_activism, color: ColorManager.lightBlueColor), title: "LifeStyle", color: ColorManager.greenColor));
      categoryModel.add(DummyCategoryModel(
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
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6, vertical: AppPadding.p10),
      child: InkWell(
        onTap: () {
          // Get.toNamed(Paths.details);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen()));
        },
        child: Container(
          width: 44.w,
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
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s10),
                        topRight: Radius.circular(AppSize.s10)),
                    child: Image.asset(AssetsManager.card,
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0_5(text: "User Interface Design"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0(text: "By Talent Tamer", color: ColorManager.grayColor),
              ),
              buildSpaceVertical(2.h),
              Center(
                child: Container(
                  height: 5.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.redColor),
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: ColorManager.whiteColor
                  ),
                  child: Center(child: textStyle0(text: "View Certificate")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
