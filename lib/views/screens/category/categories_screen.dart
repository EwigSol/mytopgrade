import 'package:flutter/material.dart';
import 'package:topgrade/controllers/category_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:get/get.dart';
import 'category_courses_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.put(CategoryController());
  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(height * 0.05),
            Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return categoryController.catList.isNotEmpty
                    ? Center(
                        child: Wrap(
                            direction: Axis.vertical,
                            spacing: 10,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
                            children: categoryController.catList.map((item) {
                              return buildCategoryCard(item, context);
                            }).toList()),
                      )
                    : Center(
                        child: textStyle0_5(text: "No Category Available"));
              }
            }),
            buildSpaceVertical(height * 0.05),
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

  Widget buildCategoryCard(
      CategoriesModel categoryModel, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CategoryCoursesScreen(
            id: categoryModel.id.toString(),
          ),
        );
      },
      child: Container(
        height: height * 0.07,
        width: width * 0.90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorManager.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textStyle0_5(
                text: categoryModel.name!, color: ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }
}
