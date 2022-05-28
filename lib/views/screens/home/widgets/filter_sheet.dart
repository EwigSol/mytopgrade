
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';

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

  _isSelected(int index) {
    setState(() {
      isSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: 100.w,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSpaceVertical(3.h),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle1(text: "Categories"),
          ),
          SizedBox(
            height: 8.h,
            width: 100.w,
            child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return buildCategoryCard();
                }),
          ),
          buildSpaceVertical(2.h),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle1(text: "Price"),
          ),
          buildSpaceVertical(2.h),
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
          buildSpaceVertical(2.h),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
          //   child: FlutterSlider(
          //     values: [lowerValue, upperValue],
          //     rangeSlider: true,
          //     max: 1000,
          //     min: 0,
          //     onDragging: (handlerIndex, lValue, uValue) {
          //       lowerValue = lValue;
          //       upperValue = uValue;
          //       setState(() {});
          //     },
          //   ),
          // ),
          buildSpaceVertical(2.h),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle1(text: "Ratings"),
          ),
          buildSpaceVertical(2.h),
          SizedBox(
            height: 6.h,
            width: 100.w,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return buildRatingCard(index);
                }),
          ),
          buildSpaceVertical(3.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 5.h,
                  width: 33.w,
                  decoration: BoxDecoration(
                    color: ColorManager.halfWhiteColor,
                    borderRadius: BorderRadius.circular(AppSize.s28),
                    border: Border.all(color: ColorManager.blackColor),
                  ),
                  child: const Center(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        color: ColorManager.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 33.w,
                  decoration: BoxDecoration(
                    color: ColorManager.redColor,
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
              ],
            ),
          ),
          buildSpaceVertical(3.h),
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
          height: 6.h,
          width: 20.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s22),
              color: isSelected == index
                  ? ColorManager.redColor
                  : ColorManager.halfWhiteColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textStyle2(text: "5"),
              buildSpaceHorizontal(1.w),
              textStyle2(text: "⭐"),
            ],
          ),
        ),
      ),
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
