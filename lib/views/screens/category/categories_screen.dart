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
            buildSpaceVertical(5.h),
            Center(
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 20,
                  alignment: WrapAlignment.spaceEvenly,
                  children: categoryModel.map((item) {
                    return buildCategoryCard(item);
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
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  Padding buildCategoryCard(CategoryModel categoryModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: Container(
        height: 6.h,
        width: 42.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s30),
          color: categoryModel.color,
        ),
        child: Row(
          children: [
            buildSpaceHorizontal(3.w),
            Container(
              height: 4.h,
              width: 8.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s30),
                color: ColorManager.whiteColor,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 1,
                //     offset: const Offset(0, 3),
                //   ),
                // ],
              ),
              child: Center(child: categoryModel.icon),
            ),
            buildSpaceHorizontal(1.w),
            Expanded(child: textStyle0_5(text: categoryModel.title!)),
          ],
        ),
      ),
    );
  }
}
