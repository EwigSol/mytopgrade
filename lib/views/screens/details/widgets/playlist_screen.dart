import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/course_by_id_model.dart';
import 'package:topgrade/models/my_courses_model.dart' as mcm;
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/lessons/widgets/assignment_card.dart';
import 'package:topgrade/views/screens/lessons/widgets/lesson_card.dart';
import 'package:topgrade/views/screens/lessons/widgets/quiz_card.dart';
import '../../../../controllers/quiz_byID_controller.dart';
import '../../../../models/assignment_byID_model.dart';
import '../../../../models/courses_model.dart' as cm;
import '../../../../models/quiz_byID_model.dart';
import '../../../../models/wishlist_model.dart' as wm;
import 'package:get/get.dart';

class Playlist extends StatefulWidget {
  final cm.CoursesModel? coursesDetail;
  final wm.DataItem? favCourseDetail;
  final mcm.MyCoursesModel? myCoursesModel;
  final CourseByIdModel? courseByIdModel;
  final bool isWishlist;
  final String isMyCourse;
  final bool isLocked;
  const Playlist(
      {Key? key,
      this.coursesDetail,
      required this.isWishlist,
      this.favCourseDetail,
      this.myCoursesModel,
      required this.isMyCourse,
      required this.isLocked,
      this.courseByIdModel})
      : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  // final LessonByIDController lessonByIDController =
  //     Get.put(LessonByIDController());
  // final AssignmentByIDController assignmentByIDController =
  //     Get.put(AssignmentByIDController());
  final QuizByIDController quizByIDController = Get.put(QuizByIDController());
  // LessonByIdModel? lessonModelList;
  List<AssignmentByIdModel> assignmentModelList = [];
  List<QuizByIdModel> quizModelList = [];

  @override
  void initState() {
    print(widget.isLocked);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.courseByIdModel!.sections!.isNotEmpty
        ? ListView.builder(
            itemCount: widget.courseByIdModel!.sections!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p6, horizontal: AppPadding.p16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: ColorManager.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(
                          top: AppPadding.p6, left: AppPadding.p12),
                      child: Text(
                        widget.courseByIdModel!.sections![index].title!,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppPadding.p6, left: AppPadding.p16),
                      child: Text(
                        "Videos: ${widget.courseByIdModel!.sections![index].items!.length} ",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    expanded: widget
                            .courseByIdModel!.sections![index].items!.isNotEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.builder(
                              itemCount: widget.courseByIdModel!
                                  .sections![index].items!.length,
                              itemBuilder: (context, i) {
                                return widget.courseByIdModel!.sections![index]
                                            .items![i].type ==
                                        Type.lpLesson
                                    ? LessonCard(
                                        isLocked: widget.isLocked,
                                        id: widget.courseByIdModel!
                                            .sections![index].items![i].id,
                                        title: widget.courseByIdModel!
                                            .sections![index].items![i].title,
                                        duration: widget
                                            .courseByIdModel!
                                            .sections![index]
                                            .items![i]
                                            .duration,
                                        section: widget
                                            .courseByIdModel!.sections![index],
                                        index: i)
                                    : widget.courseByIdModel!.sections![index]
                                                .items![i].type ==
                                            Type.lpQuiz
                                        ? QuizCard(
                                            isLocked: widget.isLocked,
                                            id: widget.courseByIdModel!
                                                .sections![index].items![i].id,
                                            title: widget
                                                .courseByIdModel!
                                                .sections![index]
                                                .items![i]
                                                .title,
                                            duration: widget
                                                .courseByIdModel!
                                                .sections![index]
                                                .items![i]
                                                .duration,
                                            index: i)
                                        : AssignmentCard(
                                            isLocked: widget.isLocked,
                                            id: widget.courseByIdModel!
                                                .sections![index].items![i].id,
                                            title: widget
                                                .courseByIdModel!
                                                .sections![index]
                                                .items![i]
                                                .title,
                                            duration: widget
                                                .courseByIdModel!
                                                .sections![index]
                                                .items![i]
                                                .duration,
                                            index: i);
                              },
                            ),
                          )
                        : Center(
                            child: textStyle0_5(
                                text: "No Videos in this section")),
                  ),
                ),
              );
            })
        : Center(
            child: textStyle0_5(text: "No section available in this course"));
  }
}

//  color: Color.fromRGBO(10, 255, index * 10, 100),