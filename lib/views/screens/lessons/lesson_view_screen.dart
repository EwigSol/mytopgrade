import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:topgrade/controllers/lesson_byId_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/lesson_byID_model.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/finish_lesson_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;

class LessonViewScreen extends StatefulWidget {
  var id;
  LessonViewScreen({Key? key, this.id}) : super(key: key);

  @override
  State<LessonViewScreen> createState() => _LessonViewScreenState();
}

class _LessonViewScreenState extends State<LessonViewScreen> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  final FinishLessonController finishLessonController = Get.put(FinishLessonController());
  final LessonByIDController lessonByIDController = Get.put(LessonByIDController());
  LessonByIdModel? lessonModelList;

  @override
  void initState() {
    super.initState();
    getLessonByIdData();
  }
  getLessonByIdData()async {
    lessonModelList = await lessonByIDController.fetchLessonByID(widget.id);
    initializePlayer();
  }

  // getData(){
  //   if(widget.isLesson == true){
  //     lessonByIDController.fetchLessonById(widget.id!);
  //   }
  //   else if(widget.isAssignment == true){
  //     assignmentByIDController.fetchAssignmentById(widget.id!);
  //   }
  //   else if(widget.isQuiz == true){
  //     quizByIDController.fetchQuizById(widget.id!);
  //   }
  //
  //
  // }

  Future<void> initializePlayer() async {
    _controller = VideoPlayerController.network(_parseHtmlString(lessonModelList!.content!));
    await Future.wait([_controller.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: false,
      hideControlsTimer: const Duration(seconds: 1),
      placeholder: Container(color: ColorManager.grayColor),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return lessonModelList != null ?
        Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.08),
                 Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Chewie(
                        controller: _chewieController!,
                      ),
                    ),
                  ),

            buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
            Center(
              child: InkWell(
                onTap: () {
                  finishLessonController
                      .finishLesson(widget.id.toString())
                      .then((response) => {
                            if (response['status'] == 'success')
                              {
                                successToast("Success", "Lesson Finished"),
                              }
                            else
                              {
                                errorToast("Error", "Failed to finish Lesson"),
                              }
                          });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      color: ColorManager.primaryColor),
                  child: Obx(() {
                    return finishLessonController.isDataSubmitting.value == true
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: textStyle2(
                                text: "Finish Lesson",
                                color: ColorManager.whiteColor));
                  }),
                ),
              ),
            )
          ],
        ),
      ),
      // body: widget.isLesson == true ?
      // Obx(() {
      //   if(lessonByIDController.isLoading.value){
      //     return const Center(child: CircularProgressIndicator());
      //   }else{
      //     initializePlayer(_parseHtmlString(lessonByIDController.lessonByIDList.value!.content!));
      //     return lessonByIDController.lessonByIDList.value != null ?
      //     SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           buildSpaceVertical(8.h),
      //           textStyle2(text: lessonByIDController.lessonByIDList.value!.name!),
      //           buildSpaceVertical(8.h),
      //           _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
      //           SizedBox(
      //             height: 50.h,
      //             width: 100.w,
      //             child: Chewie(
      //               controller: _chewieController!,
      //             ),
      //           )
      //               : Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: const [
      //               CircularProgressIndicator(),
      //               SizedBox(height: 20),
      //               Text('Loading'),
      //             ],
      //           ),
      //
      //           buildSpaceVertical(5.h),
      //
      //           Center(
      //             child: InkWell(
      //               onTap: () {
      //                 finishLessonController.finishLesson(lessonByIDController.lessonByIDList.value!.id.toString()).then((response) => {
      //                   if(response['status'] == 'success') {
      //                     successToast("Success", "Lesson Finished"),
      //                   }else{
      //                     errorToast("Error", "Failed to finish Lesson"),
      //                   }
      //                 });
      //               },
      //               child: Container(
      //                 height: 6.h,
      //                 width: 60.w,
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(AppSize.s12),
      //                     color: ColorManager.primaryColor
      //                 ),
      //                 child: Obx(() {
      //                   return finishLessonController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
      //                   Center(child: textStyle2(text: "Finish Lesson", color: ColorManager.whiteColor));
      //                 }),
      //               ),
      //             ),
      //           )
      //
      //         ],
      //       ),
      //     )
      //         : Center(child: textStyle0_5(text: "No Data Available in this Lesson"));
      //   }
      // })
      // :
      // widget.isAssignment == true ?
      // Obx(() {
      //   if(assignmentByIDController.isLoading.value){
      //     return const Center(child: CircularProgressIndicator());
      //   }else{
      //     initializePlayer(_parseHtmlString(assignmentByIDController.assignmentByIDList.value!.content!));
      //     return assignmentByIDController.assignmentByIDList.value != null ?
      //     SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           buildSpaceVertical(5.h),
      //           textStyle2(text: assignmentByIDController.assignmentByIDList.value!.name!),
      //           _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
      //           SizedBox(
      //             height: 50.h,
      //             width: 100.w,
      //             child: Chewie(
      //               controller: _chewieController!,
      //             ),
      //           )
      //               : Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: const [
      //               CircularProgressIndicator(),
      //               SizedBox(height: 20),
      //               Text('Loading'),
      //             ],
      //           ),
      //
      //           buildSpaceVertical(5.h),
      //
      //           Center(
      //             child: InkWell(
      //               onTap: () {
      //                 finishLessonController.finishLesson(assignmentByIDController.assignmentByIDList.value!.id.toString()).then((response) => {
      //                   if(response['status'] == 'success') {
      //                     successToast("Success", "Lesson Finished"),
      //                   }else{
      //                     errorToast("Error", "Failed to finish Lesson"),
      //                   }
      //                 });
      //               },
      //               child: Container(
      //                 height: 6.h,
      //                 width: 60.w,
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(AppSize.s12),
      //                     color: ColorManager.primaryColor
      //                 ),
      //                 child: Obx(() {
      //                   return finishLessonController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
      //                   Center(child: textStyle2(text: "Finish Lesson", color: ColorManager.whiteColor));
      //                 }),
      //               ),
      //             ),
      //           )
      //
      //         ],
      //       ),
      //     )
      //         : Center(child: textStyle0_5(text: "No Data Available in this Lesson"));
      //   }
      // })
      // :
      // Obx(() {
      //   if(quizByIDController.isLoading.value){
      //     return const Center(child: CircularProgressIndicator());
      //   }else{
      //     initializePlayer(_parseHtmlString(quizByIDController.quizByIDList.value!.content!));
      //     return quizByIDController.quizByIDList.value != null ?
      //     SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           buildSpaceVertical(5.h),
      //           textStyle2(text: quizByIDController.quizByIDList.value!.name!),
      //           _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
      //           SizedBox(
      //             height: 50.h,
      //             width: 100.w,
      //             child: Chewie(
      //               controller: _chewieController!,
      //             ),
      //           )
      //               : Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: const [
      //               CircularProgressIndicator(),
      //               SizedBox(height: 20),
      //               Text('Loading'),
      //             ],
      //           ),
      //
      //           buildSpaceVertical(5.h),
      //
      //           Center(
      //             child: InkWell(
      //               onTap: () {
      //                 finishLessonController.finishLesson(quizByIDController.quizByIDList.value!.id.toString()).then((response) => {
      //                   if(response['status'] == 'success') {
      //                     successToast("Success", "Lesson Finished"),
      //                   }else{
      //                     errorToast("Error", "Failed to finish Lesson"),
      //                   }
      //                 });
      //               },
      //               child: Container(
      //                 height: 6.h,
      //                 width: 60.w,
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(AppSize.s12),
      //                     color: ColorManager.primaryColor
      //                 ),
      //                 child: Obx(() {
      //                   return finishLessonController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
      //                   Center(child: textStyle2(text: "Finish Lesson", color: ColorManager.whiteColor));
      //                 }),
      //               ),
      //             ),
      //           )
      //
      //         ],
      //       ),
      //     )
      //         : Center(child: textStyle0_5(text: "No Data Available in this Lesson"));
      //   }
      // }),
    )
    : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  // String _parseHtmlString(String htmlString) {
  //   final document = parse(htmlString);
  //   final String parsedString = parse(document.body!.text).documentElement!.text;
  //   return parsedString;
  // }
  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: lessonModelList!.name!),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
