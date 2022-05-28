
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/my_courses_model.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../models/courses_model.dart';
import '../../../../models/wishlist_model.dart';
import '../../../../utils/values_manager.dart';

class InstructorScreen extends StatelessWidget {
  final CoursesModel? coursesDetail;
  final DataItem? favCourseDetail;
  final MyCoursesModel? myCoursesModel;
  final bool isWishlist;
  final String isMyCourse;
  const InstructorScreen({Key? key, this.coursesDetail, required this.isWishlist, this.favCourseDetail, this.myCoursesModel, required this.isMyCourse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWishlist ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSpaceVertical(2.h),
        favCourseDetail!.instructor!.avatar! != "" ?
        Center(
          child: CircleAvatar(
            radius: 80,
            backgroundColor: ColorManager.halfWhiteColor,
            backgroundImage: NetworkImage(favCourseDetail!.instructor!.avatar!),
          ),
        )
        :
        Center(
          child: CircleAvatar(
            radius: 80,
            backgroundColor: ColorManager.halfWhiteColor,
            child: Image.asset(AssetsManager.logo),
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Instructor Name:"),
              textStyle0_5(text: favCourseDetail!.instructor!.name!),
            ],
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textStyle0_5(text: "Description"),
              buildSpaceVertical(1.h),
              textStyle0(text: _parseHtmlString(favCourseDetail!.instructor!.description!)),
            ],
          ),
        ),



      ],
    )
    :
    isMyCourse == "true" ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSpaceVertical(2.h),
        Center(
          child: CircleAvatar(
            radius: 80,
            backgroundColor: ColorManager.halfWhiteColor,
            backgroundImage: NetworkImage(myCoursesModel!.instructor!.avatar!),
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Instructor Name:"),
              textStyle0_5(text: myCoursesModel!.instructor!.name!.name),
            ],
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textStyle0_5(text: "Description"),
              buildSpaceVertical(1.h),
              textStyle0(text: _parseHtmlString(myCoursesModel!.instructor!.description!)),
            ],
          ),
        ),



      ],
    )
    :
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSpaceVertical(2.h),
        Center(
          child: CircleAvatar(
            radius: 80,
            backgroundColor: ColorManager.halfWhiteColor,
            backgroundImage: NetworkImage(coursesDetail!.instructor!.avatar!),
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle0_5(text: "Instructor Name:"),
              textStyle0_5(text: coursesDetail!.instructor!.name!.name),
            ],
          ),
        ),
        buildSpaceVertical(2.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textStyle0_5(text: "Description"),
              buildSpaceVertical(1.h),
              textStyle0(text: _parseHtmlString(coursesDetail!.instructor!.description!)),
            ],
          ),
        ),



      ],
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
