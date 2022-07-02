import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/helpers/text_helper.dart';
import 'package:mytopgrade/models/course_by_id_model.dart';
import 'package:mytopgrade/models/my_courses_model.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import '../../../../models/courses_model.dart';
import '../../../../models/wishlist_model.dart';

class OverviewScreen extends StatelessWidget {
  final CoursesModel? coursesDetail;
  final DataItem? favCourseDetail;
  final MyCoursesModel? myCoursesModel;
  final CourseByIdModel? courseByIdModel;
  final bool isWishlist;
  final String isMyCourse;
  const OverviewScreen(
      {Key? key,
      this.courseByIdModel,
      this.coursesDetail,
      required this.isWishlist,
      this.favCourseDetail,
      this.myCoursesModel,
      required this.isMyCourse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWishlist
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    buildSpaceVertical(
                        MediaQuery.of(context).size.height * 0.02),
                    Text(
                      _parseHtmlString(favCourseDetail!.content!),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lectures :',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      favCourseDetail!.courseData!.result!.items!.lesson!.total!
                          .toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quizzes :',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      favCourseDetail!.courseData!.result!.items!.quiz!.total!
                          .toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Assignments :',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      favCourseDetail!
                          .courseData!.result!.items!.assignment!.total!
                          .toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Duration :',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      favCourseDetail!.duration!.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Students :',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      favCourseDetail!.countStudents.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
            ],
          )
        : isMyCourse == "true"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overview',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.02),
                        Text(
                          _parseHtmlString(favCourseDetail!.content!),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Lectures :',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          myCoursesModel!
                              .courseData!.result!.items!.lesson!.total!
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quizzes :',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            myCoursesModel!
                                .courseData!.result!.items!.quiz!.total!
                                .toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ]),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Assignments :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          myCoursesModel!
                              .courseData!.result!.items!.assignment!.total!
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Duration :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          myCoursesModel!.duration!.name.substring(3),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Students :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          myCoursesModel!.countStudents.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overview',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.02),
                        Text(
                          _parseHtmlString(courseByIdModel!.content!),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Lectures :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          courseByIdModel!
                              .courseData!.result!.items!.lesson!.total!
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quizzes :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          courseByIdModel!
                              .courseData!.result!.items!.quiz!.total!
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Assignments :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        // textStyle0_5(text: "Assignments:"),
                        Text(
                          courseByIdModel!
                              .courseData!.result!.items!.assignment!.total!
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Duration :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        courseByIdModel!.duration != null
                            ? Text(
                                courseByIdModel!.duration!.substring(3),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Students :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          courseByIdModel!.countStudents.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
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
