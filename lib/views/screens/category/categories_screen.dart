import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/utils/strings_manager.dart';

import '../../../helpers/helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceEvenly,
                  children: categoryModel.map((item) {
                    return buildCategoryCard();
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
      title: textStyle2(text: StringsManager.allCat),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  Padding buildCategoryCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 8.h,
        width: 42.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s30),
          color: ColorManager.pinkColor,
        ),
        child: Row(
          children: [
            buildSpaceHorizontal(3.w),
            Container(
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
              child: const Icon(Icons.lightbulb_outline),
            ),
            buildSpaceHorizontal(3.w),
            textStyle1(text: "Business"),
          ],
        ),
      ),
    );
  }
}
