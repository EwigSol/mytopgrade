// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytopgrade/controllers/FinishedCoursesController.dart';
import 'package:mytopgrade/controllers/courses_controller.dart';
import 'package:mytopgrade/controllers/finish_course_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/helpers/text_helper.dart';
import 'package:mytopgrade/models/FinishedCoursesModel.dart';
import 'package:mytopgrade/models/courses_model.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:mytopgrade/views/screens/home/widgets/MyCourseWidget.dart';
import 'package:mytopgrade/views/screens/home/widgets/PopularCourse.dart';

class FinishedCourses extends StatefulWidget {
  FinishedCourses({Key? key}) : super(key: key);

  @override
  State<FinishedCourses> createState() => _FinishedCoursesState();
}

class _FinishedCoursesState extends State<FinishedCourses> {
  final FinishedCoursesController finishedCoursesController =
      Get.put(FinishedCoursesController());

  List<FinishedCoursesModel> finishedCourseModel = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            Obx(() {
              if (finishedCoursesController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                for (int i = 0;
                    i < finishedCoursesController.finishedCourseList.length;
                    i++) {
                  if (finishedCoursesController.finishedCourseList[i].rating! >=
                      3) {
                    // popularCoursesModel.clear();
                    finishedCourseModel
                        .add(finishedCoursesController.finishedCourseList[i]);
                  }
                }
                return finishedCourseModel.isNotEmpty
                    ? GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: 3 / 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 10),
                        itemCount: finishedCourseModel.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return MyCourse(
                            argument: finishedCourseModel[index].id,
                            image: finishedCourseModel[index].image,
                            sectionslength:
                                finishedCourseModel[index].sections!.length,
                            instructor: finishedCourseModel[index].instructor,
                            name: finishedCourseModel[index].name,
                            price: finishedCourseModel[index].price,
                            rating: finishedCourseModel[index].rating,
                          );
                        })
                    : Center(
                        child: Text(
                            'Sorry You Have Not Finished Any Courses Yet!'),
                      );
              }
            }),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.04),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    finishedCoursesController.onClose();
    super.dispose();
  }
}
