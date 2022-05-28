

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/my_courses_model.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';

import '../../../../models/courses_model.dart';
import '../../../../models/wishlist_model.dart';

class OverviewScreen extends StatelessWidget {
  final CoursesModel? coursesDetail;
  final DataItem? favCourseDetail;
  final MyCoursesModel? myCoursesModel;
  final bool isWishlist;
  final String isMyCourse;
  const OverviewScreen({Key? key, this.coursesDetail, required this.isWishlist, this.favCourseDetail, this.myCoursesModel, required this.isMyCourse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWishlist ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textStyle2(text: "Overview"),
              buildSpaceVertical(2.h),
              textStyle0(text: _parseHtmlString(favCourseDetail!.content!)),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Lectures:"),
              textStyle0_5(text: favCourseDetail!.courseData!.result!.items!.lesson!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Quizzes:"),
              textStyle0_5(text: favCourseDetail!.courseData!.result!.items!.quiz!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Assignments:"),
              textStyle0_5(text: favCourseDetail!.courseData!.result!.items!.assignment!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Duration:"),
              textStyle0_5(text: favCourseDetail!.duration!),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Students:"),
              textStyle0_5(text: favCourseDetail!.countStudents.toString()),
            ],
          ),
        ),
        buildSpaceVertical(7.h),
      ],
    )
    :
    isMyCourse == "true" ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textStyle2(text: "Overview"),
              buildSpaceVertical(2.h),
              textStyle0(text: _parseHtmlString(myCoursesModel!.content!)),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Lectures:"),
              textStyle0_5(text: myCoursesModel!.courseData!.result!.items!.lesson!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Quizzes:"),
              textStyle0_5(text: myCoursesModel!.courseData!.result!.items!.quiz!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Assignments:"),
              textStyle0_5(text: myCoursesModel!.courseData!.result!.items!.assignment!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Duration:"),
              textStyle0_5(text: myCoursesModel!.duration!.name.substring(3)),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Students:"),
              textStyle0_5(text: myCoursesModel!.countStudents.toString()),
            ],
          ),
        ),
        buildSpaceVertical(7.h),
      ],
    )
    :
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textStyle2(text: "Overview"),
              buildSpaceVertical(2.h),
              textStyle0(text: _parseHtmlString(coursesDetail!.content!)),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Lectures:"),
              textStyle0_5(text: coursesDetail!.courseData!.result!.items!.lesson!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Quizzes:"),
              textStyle0_5(text: coursesDetail!.courseData!.result!.items!.quiz!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Assignments:"),
              textStyle0_5(text: coursesDetail!.courseData!.result!.items!.assignment!.total!.toString()),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Duration:"),
              textStyle0_5(text: coursesDetail!.duration!.name.substring(3)),
            ],
          ),
        ),
        buildSpaceVertical(0.5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Students:"),
              textStyle0_5(text: coursesDetail!.countStudents.toString()),
            ],
          ),
        ),
        buildSpaceVertical(7.h),
      ],
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
