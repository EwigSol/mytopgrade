

import 'package:flutter/material.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:get/get.dart';
import '../../../controllers/category_controller.dart';
import '../../../helpers/helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'category_courses_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
            Obx((){
              if(categoryController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }else{
                return categoryController.catList.isNotEmpty ?
                Center(
                  child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 20,
                      alignment: WrapAlignment.spaceEvenly,
                      children: categoryController.catList.map((item) {
                        return buildCategoryCard(item, context);
                      }).toList()
                  ),
                )
                    : Center(child: textStyle0_5(text: "No Category Available"));
              }
            }),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
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
      automaticallyImplyLeading: false,
    );
  }

  Padding buildCategoryCard(CategoriesModel categoryModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoryCoursesScreen(id: categoryModel.id.toString())));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: ColorManager.primaryColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // buildSpaceHorizontal(3.w),
              // Container(
              //   height: 5.h,
              //   width: 10.w,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(AppSize.s30),
              //     color: ColorManager.whiteColor,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 3,
              //         blurRadius: 4,
              //         offset: const Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child: const Icon(Icons.lightbulb, color: ColorManager.primaryColor),
              // ),
              // buildSpaceHorizontal(2.w),
              textStyle0_5(text: categoryModel.name!, color: ColorManager.whiteColor),
            ],
          ),
        ),
      ),
    );
  }
}

