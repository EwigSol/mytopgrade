

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/utils/strings_manager.dart';

import '../../../helpers/helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';

class BestInstructorScreen extends StatefulWidget {
  const BestInstructorScreen({Key? key}) : super(key: key);

  @override
  State<BestInstructorScreen> createState() => _BestInstructorScreenState();
}

class _BestInstructorScreenState extends State<BestInstructorScreen> {
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
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(1.h),
            Center(
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceEvenly,
                  children: categoryModel.map((item) {
                    return buildInstructorCard(item);
                  }).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.instructor),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  Padding buildInstructorCard(CategoryModel catModel) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: 44.w,
        decoration: BoxDecoration(
          color: catModel.color,
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 27.h,
              width: 18.w,
              child: Image.asset(AssetsManager.girl, fit: BoxFit.fill),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceVertical(1.h),
                textStyle0_5(text: "Albert Flores"),
                textStyle0(text: "LifeStyle", color: ColorManager.grayColor),
                textStyle0(text: "20k Students"),
                textStyle0(text: "17 Courses"),
                textStyle0(text: "(4.5)⭐"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
