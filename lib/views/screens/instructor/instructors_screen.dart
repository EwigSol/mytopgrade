

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
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(5.h),
            Center(
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 5,
                  runSpacing: 5,
                  alignment: WrapAlignment.spaceEvenly,
                  children: categoryModel.map((item) {
                    return buildInstructorCard();
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

  Padding buildInstructorCard() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: 45.w,
        decoration: BoxDecoration(
          color: ColorManager.greenColor,
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 25.h,
              width: 18.w,
              child: Image.asset(AssetsManager.girl, fit: BoxFit.fill),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceVertical(3.h),
                textStyle0_5(text: "Albert Flores"),
                textStyle0(text: "LifeStyle", color: ColorManager.grayColor),
                textStyle0_5(text: "20k Students"),
                textStyle0_5(text: "17 Courses"),
                textStyle0_5(text: "(4.5)⭐"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
