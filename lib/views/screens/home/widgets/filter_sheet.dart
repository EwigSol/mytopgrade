import 'package:flutter/material.dart';
import 'package:mytopgrade/helpers/helper.dart';
import '../../../../controllers/category_controller.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../models/category_model.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';
import 'package:get/get.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool paidCourses = false;
  bool freeCourses = false;
  double lowerValue = 0;
  double upperValue = 100;
  int isSelected = 0;
  int isCatSelected = 0;
  final CategoryController categoryController = Get.put(CategoryController());

  _isSelected(int index) {
    setState(() {
      isSelected = index;
    });
  }

  _isCatSelected(int i) {
    setState(() {
      isCatSelected = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          Center(child: textStyle4(text: "Filter by")),
          Padding(
            padding: const EdgeInsets.only(
                left: AppPadding.p16, right: AppPadding.p16),
            child: textStyle2(text: "Categories"),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.005),
          Obx(() {
            if (categoryController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return categoryController.catList.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: categoryController.catList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            final catModel = categoryController.catList[i];
                            return buildCategoryCard(catModel, i);
                          }),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: textStyle0_5(text: "No Category Available")));
            }
          }),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle2(text: "Price"),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: paidCourses,
                      onChanged: (bool? value) {
                        setState(() {
                          paidCourses = value!;
                        });
                      },
                    ),
                    textStyle0(text: "Paid Courses")
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: freeCourses,
                      onChanged: (bool? value) {
                        setState(() {
                          freeCourses = value!;
                        });
                      },
                    ),
                    textStyle0(text: "Free Courses")
                  ],
                ),
              ],
            ),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle2(text: "Ratings"),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return buildRatingCard(index);
                }),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         height: MediaQuery.of(context).size.height * 0.05,
          //         width: MediaQuery.of(context).size.width * 0.33,
          //         decoration: BoxDecoration(
          //           color: ColorManager.halfWhiteColor,
          //           borderRadius: BorderRadius.circular(AppSize.s28),
          //           border: Border.all(color: ColorManager.blackColor),
          //         ),
          //         child: const Center(
          //           child: Text(
          //             "Reset",
          //             style: TextStyle(
          //               color: ColorManager.blackColor,
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //
          //     ],
          //   ),
          // ),
          Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(AppSize.s28),
                ),
                child: const Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      color: ColorManager.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
        ],
      ),
    );
  }

  Padding buildRatingCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: () {
          _isSelected(index);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.22,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s22),
              color: isSelected == index
                  ? ColorManager.primaryColor
                  : ColorManager.halfWhiteColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textStyle2(text: "5"),
              buildSpaceHorizontal(MediaQuery.of(context).size.width * 0.01),
              textStyle2(text: "⭐"),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCategoryCard(CategoriesModel categoryModel, int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: () {
          _isCatSelected(i);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: isCatSelected == i
                  ? ColorManager.primaryColor
                  : ColorManager.halfWhiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textStyle2(
                  text: categoryModel.name!, color: ColorManager.blackColor),
            ],
          ),
        ),
      ),
    );
  }
}
