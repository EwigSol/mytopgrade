import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/models/course_by_id_model.dart';
import 'package:mytopgrade/models/my_courses_model.dart';
import 'package:mytopgrade/utils/assets_manager.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import '../../../../models/courses_model.dart';
import '../../../../models/wishlist_model.dart';
import '../../../../utils/values_manager.dart';

class InstructorScreen extends StatelessWidget {
  final CoursesModel? coursesDetail;
  final DataItem? favCourseDetail;
  final MyCoursesModel? myCoursesModel;
  final CourseByIdModel? courseByIdModel;
  final bool isWishlist;
  final String isMyCourse;
  const InstructorScreen(
      {Key? key,
      this.coursesDetail,
      required this.isWishlist,
      this.favCourseDetail,
      this.myCoursesModel,
      required this.isMyCourse,
      this.courseByIdModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWishlist
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              favCourseDetail!.instructor!.avatar! != ""
                  ? Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: ColorManager.halfWhiteColor,
                        backgroundImage:
                            NetworkImage(favCourseDetail!.instructor!.avatar!),
                      ),
                    )
                  : const Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: ColorManager.halfWhiteColor,
                        backgroundImage: AssetImage(
                          'assets/images/placeholder.png',
                        ),
                      ),
                    ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Instructor Name :',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      favCourseDetail!.instructor!.name!,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description :',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    buildSpaceVertical(
                        MediaQuery.of(context).size.height * 0.01),
                    Text(
                      _parseHtmlString(
                          favCourseDetail!.instructor!.description!),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          )
        : isMyCourse == "true"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  myCoursesModel!.instructor!.avatar! != ""
                      ? Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: ColorManager.halfWhiteColor,
                            backgroundImage: NetworkImage(
                                myCoursesModel!.instructor!.avatar!),
                          ),
                        )
                      : const Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: ColorManager.halfWhiteColor,
                            backgroundImage: AssetImage(
                              'assets/images/placeholder.png',
                            ),
                          ),
                        ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Instructor Name :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          myCoursesModel!.instructor!.name!.name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.01),
                        Text(
                          _parseHtmlString(
                              myCoursesModel!.instructor!.description!),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  courseByIdModel!.instructor!.avatar! != ""
                      ? Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: ColorManager.halfWhiteColor,
                            backgroundImage: NetworkImage(
                                courseByIdModel!.instructor!.avatar!),
                          ),
                        )
                      : const Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: ColorManager.halfWhiteColor,
                            backgroundImage: AssetImage(
                              'assets/images/placeholder.png',
                            ),
                          ),
                        ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Instructor Name :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          courseByIdModel!.instructor!.name!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.01),
                        Text(
                          _parseHtmlString(
                              courseByIdModel!.instructor!.description!),
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
