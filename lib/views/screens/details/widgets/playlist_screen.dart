

import 'package:html/parser.dart' show parse;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/my_courses_model.dart' as mcm;
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import '../../../../controllers/assignment_byID_controller.dart';
import '../../../../controllers/lesson_byId_controller.dart';
import '../../../../controllers/quiz_byID_controller.dart';
import '../../../../helpers/helper.dart';
import '../../../../models/assignment_byID_model.dart';
import '../../../../models/courses_model.dart' as cm;
import '../../../../models/lesson_byID_model.dart';
import '../../../../models/quiz_byID_model.dart';
import '../../../../models/wishlist_model.dart' as wm;
import 'package:get/get.dart';
import '../../lessons/assignment_view_screen.dart';
import '../../lessons/lesson_view_screen.dart';

class Playlist extends StatefulWidget {
  final cm.CoursesModel? coursesDetail;
  final wm.DataItem? favCourseDetail;
  final mcm.MyCoursesModel? myCoursesModel;
  final bool isWishlist;
  final String isMyCourse;
  final bool isLocked;
  const Playlist({Key? key, this.coursesDetail, required this.isWishlist, this.favCourseDetail, this.myCoursesModel, required this.isMyCourse, required this.isLocked}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {

  final LessonByIDController lessonByIDController = Get.put(LessonByIDController());
  final AssignmentByIDController assignmentByIDController = Get.put(AssignmentByIDController());
  final QuizByIDController quizByIDController = Get.put(QuizByIDController());
  List<LessonByIdModel> lessonModelList = [];
  List<AssignmentByIdModel> assignmentModelList = [];
  List<QuizByIdModel> quizModelList = [];

  @override
  void initState() {
    super.initState();
    getLessons();
  }

  getLessons() {
    if(widget.isWishlist){
      for(int i=0; i< widget.favCourseDetail!.sections!.length; i++){
        if(widget.favCourseDetail!.sections![i].items!.isNotEmpty){
          for(int j=0; j<widget.favCourseDetail!.sections![i].items!.length; j++){
            if(widget.favCourseDetail!.sections![i].items![j].type == wm.Type.lesson){
              lessonByIDController.fetchLessonById(widget.favCourseDetail!.sections![i].items![j].id.toString());
              setState(() { });
            }
            else if(widget.favCourseDetail!.sections![i].items![j].type == wm.Type.assignment){
              assignmentByIDController.fetchAssignmentById(widget.favCourseDetail!.sections![i].items![j].id.toString());
              setState(() { });
            }
            else if(widget.favCourseDetail!.sections![i].items![j].type == wm.Type.quiz){
              quizByIDController.fetchQuizById(widget.favCourseDetail!.sections![i].items![j].id.toString());
              setState(() { });
            }

          }
        }
      }
    }
    else if(widget.isMyCourse == "true"){
      for(int i=0; i< widget.myCoursesModel!.sections!.length; i++){
        if(widget.myCoursesModel!.sections![i].items!.isNotEmpty){
          for(int j=0; j<widget.myCoursesModel!.sections![i].items!.length; j++){
            if(widget.myCoursesModel!.sections![i].items![j].type == mcm.Type.lesson){
              lessonByIDController.fetchLessonById(widget.myCoursesModel!.sections![i].items![j].id.toString());
              setState(() { });
            }
            else if(widget.myCoursesModel!.sections![i].items![j].type == mcm.Type.assignment){
              assignmentByIDController.fetchAssignmentById(widget.myCoursesModel!.sections![i].items![j].id.toString());
              setState(() { });
            }
            else if(widget.myCoursesModel!.sections![i].items![j].type == mcm.Type.quiz){
              quizByIDController.fetchQuizById(widget.myCoursesModel!.sections![i].items![j].id.toString());
              setState(() { });
            }

          }
        }
      }
    }
    else{
      for(int i=0; i< widget.coursesDetail!.sections!.length; i++){
        if(widget.coursesDetail!.sections![i].items!.isNotEmpty){
          for(int j=0; j<widget.coursesDetail!.sections![i].items!.length; j++){
            if(widget.coursesDetail!.sections![i].items![j].type == cm.Type.lesson){
              lessonByIDController.fetchLessonById(widget.coursesDetail!.sections![i].items![j].id.toString());
              setState(() { });
            }
            else if(widget.coursesDetail!.sections![i].items![j].type == cm.Type.assignment){
              assignmentByIDController.fetchAssignmentById(widget.coursesDetail!.sections![i].items![j].id.toString());
              setState(() { });
            }
            else if(widget.coursesDetail!.sections![i].items![j].type == cm.Type.quiz){
              quizByIDController.fetchQuizById(widget.coursesDetail!.sections![i].items![j].id.toString());
              setState(() { });
            }

          }
        }
      }
    }

  }

  @override
  Widget build(BuildContext context) {

    return widget.isWishlist ?
    Column(
      children: [
        Obx((){
          if(lessonByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            lessonByIDController.lessonByIDList.value != null ? lessonModelList.add(lessonByIDController.lessonByIDList.value!) : null;
            return lessonModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Lessons"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Videos: ${lessonModelList.length} "),
              ),
              expanded: lessonModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 50.h,
                child: ListView.builder(
                  itemCount: lessonModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: lessonModelList[i].id.toString(),
                                  url: _parseHtmlString(lessonModelList[i].content!), title: lessonModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(lessonModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            lessonModelList[i].duration != null ?
                                            textStyle00(text: lessonModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  lessonModelList[i].results!.status == "completed" ?
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 24) :
                                  const Icon(Icons.close, color: ColorManager.greenColor, size: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Videos in this section")),
            )
                : Center(child: textStyle0_5(text: "No Lesson Available"));
          }
        }),
        buildSpaceVertical(2.h),
        Obx((){
          if(assignmentByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            assignmentByIDController.assignmentByIDList.value != null ? assignmentModelList.add(assignmentByIDController.assignmentByIDList.value!) : null;
            return assignmentModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Assignments"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Assignments: ${assignmentModelList.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
              expanded: assignmentModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 20.h,
                child: ListView.builder(
                  itemCount: assignmentModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: assignmentModelList[i].id.toString(),
                                  url: _parseHtmlString(assignmentModelList[i].content!), title: assignmentModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(assignmentModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            assignmentModelList[i].duration != null ?
                                            textStyle00(text: assignmentModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Assignments in this section")),
            )
                : Center(child: textStyle0_5(text: "No Assignments Available"));
          }
        }),
        buildSpaceVertical(2.h),
        Obx((){
          if(quizByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            quizByIDController.quizByIDList.value != null ? quizModelList.add(quizByIDController.quizByIDList.value!) : null;
            return quizModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Quizzes"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Quizzes: ${quizModelList.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
              expanded: quizModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 20.h,
                child: ListView.builder(
                  itemCount: quizModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: quizModelList[i].id.toString(),
                                  url: _parseHtmlString(quizModelList[i].content!), title: quizModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(quizModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            quizModelList[i].duration != null ?
                                            textStyle00(text: quizModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Quizzes in this section")),
            )
                : Center(child: textStyle0_5(text: "No Quizzes Available"));
          }
        }),
        buildSpaceVertical(2.h),
      ],
    )
    :
    widget.isMyCourse == "true" ?
    Column(
      children: [
        Obx((){
          if(lessonByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            lessonByIDController.lessonByIDList.value != null ? lessonModelList.add(lessonByIDController.lessonByIDList.value!) : null;
            return lessonModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Lessons"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Videos: ${lessonModelList.length} "),
              ),
              expanded: lessonModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 50.h,
                child: ListView.builder(
                  itemCount: lessonModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: lessonModelList[i].id.toString(),
                                  url: _parseHtmlString(lessonModelList[i].content!), title: lessonModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(lessonModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            lessonModelList[i].duration != null ?
                                            textStyle00(text: lessonModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  lessonModelList[i].results!.status == "completed" ?
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 24) :
                                  const Icon(Icons.close, color: ColorManager.greenColor, size: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Videos in this section")),
            )
                : Center(child: textStyle0_5(text: "No Lesson Available"));
          }
        }),
        buildSpaceVertical(2.h),
        Obx((){
          if(assignmentByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            assignmentByIDController.assignmentByIDList.value != null ? assignmentModelList.add(assignmentByIDController.assignmentByIDList.value!) : null;
            return assignmentModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Assignments"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Assignments: ${assignmentModelList.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
              expanded: assignmentModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 20.h,
                child: ListView.builder(
                  itemCount: assignmentModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                AssignmentViewScreen(id: assignmentModelList[i].id.toString(), duration: assignmentModelList[i].duration!.format,
                                  url: _parseHtmlString(assignmentModelList[i].content!), title: assignmentModelList[i].name, )
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(assignmentModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            assignmentModelList[i].duration != null ?
                                            textStyle00(text: assignmentModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Assignments in this section")),
            )
                : Center(child: textStyle0_5(text: "No Assignments Available"));
          }
        }),
        buildSpaceVertical(2.h),
        Obx((){
          if(quizByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            quizByIDController.quizByIDList.value != null ? quizModelList.add(quizByIDController.quizByIDList.value!) : null;
            return quizModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Quizzes"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Quizzes: ${quizModelList.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
              expanded: quizModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 20.h,
                child: ListView.builder(
                  itemCount: quizModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: quizModelList[i].id.toString(),
                                  url: _parseHtmlString(quizModelList[i].content!), title: quizModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(quizModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            quizModelList[i].duration != null ?
                                            textStyle00(text: quizModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Quizzes in this section")),
            )
                : Center(child: textStyle0_5(text: "No Quizzes Available"));
          }
        }),
        buildSpaceVertical(2.h),
      ],
    )
    :
    Column(
      children: [
        Obx((){
          if(lessonByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            lessonByIDController.lessonByIDList.value != null ? lessonModelList.add(lessonByIDController.lessonByIDList.value!) : null;
            return lessonModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Lessons"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Videos: ${lessonModelList.length} "),
              ),
              expanded: lessonModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 50.h,
                child: ListView.builder(
                  itemCount: lessonModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: lessonModelList[i].id.toString(),
                                  url: _parseHtmlString(lessonModelList[i].content!), title: lessonModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(lessonModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            lessonModelList[i].duration != null ?
                                            textStyle00(text: lessonModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  lessonModelList[i].results!.status == "completed" ?
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 24) :
                                  const Icon(Icons.close, color: ColorManager.greenColor, size: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Videos in this section")),
            )
                : Center(child: textStyle0_5(text: "No Lesson Available"));
          }
        }),
        buildSpaceVertical(2.h),
        Obx((){
          if(assignmentByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            assignmentByIDController.assignmentByIDList.value != null ? assignmentModelList.add(assignmentByIDController.assignmentByIDList.value!) : null;
            return assignmentModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Assignments"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Assignments: ${assignmentModelList.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
              expanded: assignmentModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 20.h,
                child: ListView.builder(
                  itemCount: assignmentModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: assignmentModelList[i].id.toString(),
                                  url: _parseHtmlString(assignmentModelList[i].content!), title: assignmentModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(assignmentModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            assignmentModelList[i].duration != null ?
                                            textStyle00(text: assignmentModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Assignments in this section")),
            )
                : Center(child: textStyle0_5(text: "No Assignments Available"));
          }
        }),
        buildSpaceVertical(2.h),
        Obx((){
          if(quizByIDController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            quizByIDController.quizByIDList.value != null ? quizModelList.add(quizByIDController.quizByIDList.value!) : null;
            return quizModelList.isNotEmpty ?
            ExpandablePanel(
              header: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                child: textStyle0_5(text: "Quizzes"),
              ),
              collapsed: Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                child: Text("Quizzes: ${quizModelList.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
              expanded: quizModelList.isNotEmpty ?
              SizedBox(
                width: 100.w,
                height: 20.h,
                child: ListView.builder(
                  itemCount: quizModelList.length,
                  itemBuilder: (context, i){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                      child: InkWell(
                        onTap: () {
                          if(widget.isLocked == false){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                LessonViewScreen(id: quizModelList[i].id.toString(),
                                  url: _parseHtmlString(quizModelList[i].content!), title: quizModelList[i].name,)
                            ));
                            // if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.lesson){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: true, isAssignment: false, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.assignment){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: true, isQuiz: false)
                            //   ));
                            // }
                            // else if(widget.myCoursesModel!.sections![index].items![i].type == mcm.Type.quiz){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            //       LessonViewScreen(id: widget.myCoursesModel!.sections![index].items![i].id.toString(),
                            //           isLesson: false, isAssignment: false, isQuiz: true)
                            //   ));
                            // }
                          }
                        },
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(quizModelList[i].name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            quizModelList[i].duration != null ?
                                            textStyle00(text: quizModelList[i].duration!.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
                                  const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(child: textStyle0_5(text: "No Quizzes in this section")),
            )
                : Center(child: textStyle0_5(text: "No Quizzes Available"));
          }
        }),
        buildSpaceVertical(2.h),
      ],
    );
    // widget.coursesDetail!.sections!.isNotEmpty ?
    // ListView.builder(
    //     itemCount: widget.coursesDetail!.sections!.length,
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
    //               child: textStyle0_5(text: widget.coursesDetail!.sections![index].title!),
    //             ),
    //             collapsed: Padding(
    //               padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
    //               child: Text("Videos: ${widget.coursesDetail!.sections![index].items!.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
    //             ),
    //             expanded: widget.coursesDetail!.sections![index].items!.isNotEmpty ?
    //             SizedBox(
    //               width: 100.w,
    //               height: 50.h,
    //               child: ListView.builder(
    //                 itemCount: widget.coursesDetail!.sections![index].items!.length,
    //                 itemBuilder: (context, i){
    //                   return Padding(
    //                     padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
    //                     child: InkWell(
    //                       onTap: () {
    //                         if(widget.isLocked == false){
    //                           if(widget.coursesDetail!.sections![index].items![i].type == cm.Type.lesson){
    //                             Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //                                 LessonViewScreen(id: widget.coursesDetail!.sections![index].items![i].id.toString(),
    //                                     isLesson: true, isAssignment: false, isQuiz: false)
    //                             ));
    //                           }
    //                           else if(widget.coursesDetail!.sections![index].items![i].type == cm.Type.assignment){
    //                             Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //                                 LessonViewScreen(id: widget.coursesDetail!.sections![index].items![i].id.toString(),
    //                                     isLesson: false, isAssignment: true, isQuiz: false)
    //                             ));
    //                           }
    //                           else if(widget.coursesDetail!.sections![index].items![i].type == cm.Type.quiz){
    //                             Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //                                 LessonViewScreen(id: widget.coursesDetail!.sections![index].items![i].id.toString(),
    //                                     isLesson: false, isAssignment: false, isQuiz: true)
    //                             ));
    //                           }
    //                         }
    //                       },
    //                       child: Container(
    //                         height: 8.h,
    //                         width: 95.w,
    //                         decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(AppSize.s16),
    //                             color: ColorManager.halfWhiteColor
    //                         ),
    //                         child: Padding(
    //                           padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
    //                           child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Expanded(
    //                                 child: Row(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   children: [
    //                                     Container(
    //                                       height: 4.h,
    //                                       width: 8.w,
    //                                       decoration: BoxDecoration(
    //                                           borderRadius: BorderRadius.circular(AppSize.s28),
    //                                           color: ColorManager.whiteColor
    //                                       ),
    //                                       child: Center(child: textStyle0_5(text: "${i+1}")),
    //                                     ),
    //                                     buildSpaceHorizontal(2.w),
    //                                     Expanded(
    //                                       child: Column(
    //                                         crossAxisAlignment: CrossAxisAlignment.start,
    //                                         mainAxisAlignment: MainAxisAlignment.center,
    //                                         mainAxisSize: MainAxisSize.min,
    //                                         children: [
    //                                           Text(widget.coursesDetail!.sections![index].items![i].title!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
    //                                           widget.coursesDetail!.sections![index].items![i].duration != null ?
    //                                           textStyle00(text: widget.coursesDetail!.sections![index].items![i].duration!.name.toString(), color: ColorManager.grayColor)
    //                                               :const SizedBox.shrink(),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                               Container(
    //                                 height: 4.h,
    //                                 width: 8.w,
    //                                 decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.circular(AppSize.s28),
    //                                     color: ColorManager.whiteColor
    //                                 ),
    //                                 child: widget.isLocked ? const Icon(Icons.lock, color: ColorManager.redColor, size: 20) :
    //                                 const Icon(Icons.check, color: ColorManager.greenColor, size: 20),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       )
    //
    //                     ),
    //                   );
    //                 },
    //               ),
    //             )
    //                 : Center(child: textStyle0_5(text: "No Videos in this section")),
    //           ),
    //         ),
    //       );
    //     }
    // )
    //     : Center(child: textStyle0_5(text: "No section available in this course"));
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}

//  color: Color.fromRGBO(10, 255, index * 10, 100),