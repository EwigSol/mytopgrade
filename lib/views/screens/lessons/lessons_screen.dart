// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:topgrade/controllers/assignment_byID_controller.dart';
import 'package:topgrade/controllers/lesson_byId_controller.dart';
import 'package:topgrade/controllers/quiz_byID_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/assignment_byID_model.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:get/get.dart';
import 'package:topgrade/models/lesson_byID_model.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:topgrade/utils/values_manager.dart';

class LessonsScreen extends StatefulWidget {
  List<Section>? lessonSections;
  LessonsScreen({Key? key, this.lessonSections}) : super(key: key);

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  final LessonByIDController lessonByIDController =
      Get.put(LessonByIDController());
  final AssignmentByIDController assignmentByIDController =
      Get.put(AssignmentByIDController());
  final QuizByIDController quizByIDController = Get.put(QuizByIDController());
  List<LessonByIdModel> lessonModelList = [];
  List<AssignmentByIdModel> assignmentModelList = [];
  List<QuizByIdModel> quizModelList = [];
  @override
  void initState() {
    var data = Get.arguments;
    widget.lessonSections = data;
    lessonModelList.clear();
    assignmentModelList.clear();
    quizModelList.clear();
    // getLessons();
    super.initState();
  }

  // getLessons() {
  //   for (int i = 0; i < widget.lessonSections!.length; i++) {
  //     if (widget.lessonSections![i].items!.isNotEmpty) {
  //       for (int j = 0; j < widget.lessonSections![i].items!.length; j++) {
  //         if (widget.lessonSections![i].items![j].type == Type.lesson) {
  //           lessonByIDController.fetchLessonById(
  //               widget.lessonSections![i].items![j].id.toString());
  //         } else if (widget.lessonSections![i].items![j].type ==
  //             Type.assignment) {
  //           assignmentByIDController.fetchAssignmentById(
  //               widget.lessonSections![i].items![j].id.toString());
  //         } else if (widget.lessonSections![i].items![j].type == Type.quiz) {
  //           quizByIDController.fetchQuizById(
  //               widget.lessonSections![i].items![j].id.toString());
  //         }
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
            // widget.lessonSections!.isNotEmpty ?
            // ListView.builder(
            //     itemCount: widget.lessonSections!.length,
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p16),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(AppSize.s16),
            //             color: ColorManager.whiteColor,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.5),
            //                 spreadRadius: 1,
            //                 blurRadius: 1,
            //                 offset: const Offset(0, 3), // changes position of shadow
            //               ),
            //             ],
            //           ),
            //           child: ExpandablePanel(
            //             header: Padding(
            //               padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
            //               child: textStyle0_5(text: widget.lessonSections![index].title!),
            //             ),
            //             collapsed: Padding(
            //               padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
            //               child: Text("Videos: ${widget.lessonSections![index].items!.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
            //             ),
            //             expanded: widget.lessonSections![index].items!.isNotEmpty ?
            //
            //                 : Center(child: textStyle0_5(text: "No Videos in this section")),
            //           ),
            //         ),
            //       );
            //     }
            // )
            // : Center(child: textStyle0_5(text: "No section available in this course")),
            Obx(() {
              if (lessonByIDController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                lessonByIDController.lessonByIDList.value != null
                    ? lessonModelList
                        .add(lessonByIDController.lessonByIDList.value!)
                    : null;
                return lessonModelList.isNotEmpty
                    ? Center(
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceEvenly,
                            children: lessonModelList.map((item) {
                              return buildLessonsCard(item);
                            }).toList()),
                      )
                    : Center(child: textStyle0_5(text: "No Lesson Available"));
              }
            }),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            Obx(() {
              if (assignmentByIDController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                assignmentByIDController.assignmentByIDList.value != null
                    ? assignmentModelList
                        .add(assignmentByIDController.assignmentByIDList.value!)
                    : null;
                return assignmentModelList.isNotEmpty
                    ? Center(
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceEvenly,
                            children: assignmentModelList.map((item) {
                              return buildAssignmentCard(item);
                            }).toList()),
                      )
                    : Center(
                        child: textStyle0_5(text: "No Assignment Available"));
              }
            }),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
            Obx(() {
              if (quizByIDController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                quizByIDController.quizByIDList.value != null
                    ? quizModelList.add(quizByIDController.quizByIDList.value!)
                    : null;
                return quizModelList.isNotEmpty
                    ? Center(
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceEvenly,
                            children: quizModelList.map((item) {
                              return buildQuizCard(item);
                            }).toList()),
                      )
                    : Center(child: textStyle0_5(text: "No Quiz Available"));
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
      title: textStyle2(text: StringsManager.lessons),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }

  Padding buildLessonsCard(LessonByIdModel lessonByIdModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => LessonViewScreen(
          //         id: lessonByIdModel.id.toString(),
          //         title: lessonByIdModel.name,
          //         url: _parseHtmlString(lessonByIdModel.content!)
          //     )
          // ));
          // var document = parse(lessonByIdModel.content);
          // dom.Element? link = document.querySelector('video/mp4');
          // String? imageLink = link != null ? link.attributes['src'] : '';
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: ColorManager.lightGreenColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Title:"),
                textStyle0_5(text: lessonByIdModel.name!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Duration:"),
                textStyle0_5(text: lessonByIdModel.duration!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Status:"),
                textStyle0_5(text: lessonByIdModel.status!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildAssignmentCard(AssignmentByIdModel assignmentByIdModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LessonViewScreen(title: assignmentByIdModel.name, url: _parseHtmlString(assignmentByIdModel.content!))));
          // var document = parse(lessonByIdModel.content);
          // dom.Element? link = document.querySelector('video/mp4');
          // String? imageLink = link != null ? link.attributes['src'] : '';
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: ColorManager.lightGreenColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Title:"),
                textStyle0_5(text: assignmentByIdModel.name!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Duration:"),
                textStyle0_5(text: assignmentByIdModel.duration!.format!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Status:"),
                textStyle0_5(text: assignmentByIdModel.status!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildQuizCard(QuizByIdModel quizByIdModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LessonViewScreen(title: quizByIdModel.name, url: _parseHtmlString(quizByIdModel.content!))));
          // var document = parse(lessonByIdModel.content);
          // dom.Element? link = document.querySelector('video/mp4');
          // String? imageLink = link != null ? link.attributes['src'] : '';
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              color: ColorManager.lightGreenColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Title:"),
                textStyle0_5(text: quizByIdModel.name!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Duration:"),
                textStyle0_5(text: quizByIdModel.duration!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                textStyle0(text: "Lesson Status:"),
                textStyle0_5(text: quizByIdModel.status!),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
