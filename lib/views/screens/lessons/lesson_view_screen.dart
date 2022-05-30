


import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/finish_lesson_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'package:get/get.dart';

class LessonViewScreen extends StatefulWidget {
  final String? id, url, title;
  const LessonViewScreen({Key? key, this.id, this.url, this.title}) : super(key: key);

  @override
  State<LessonViewScreen> createState() => _LessonViewScreenState();
}

class _LessonViewScreenState extends State<LessonViewScreen> {

  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  var finishLessonController = Get.put(FinishLessonController());
  // final LessonByIDController lessonByIDController = Get.put(LessonByIDController());
  // final AssignmentByIDController assignmentByIDController = Get.put(AssignmentByIDController());
  // final QuizByIDController quizByIDController = Get.put(QuizByIDController());
  // LessonByIdModel? lessonByIdModel;

  @override
  void initState() {
    super.initState();
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
    _controller = VideoPlayerController.network(widget.url!);
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
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(8.h),
            _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
            Center(
              child: SizedBox(
                height: 40.h,
                width: 95.w,
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),

            buildSpaceVertical(5.h),

            Center(
              child: InkWell(
                onTap: () {
                  finishLessonController.finishLesson(widget.id.toString()).then((response) => {
                    if(response['status'] == 'success') {
                      successToast("Success", "Lesson Finished"),
                    }else{
                      errorToast("Error", "Failed to finish Lesson"),
                    }
                  });
                },
                child: Container(
                  height: 6.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      color: ColorManager.primaryColor
                  ),
                  child: Obx(() {
                    return finishLessonController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                    Center(child: textStyle2(text: "Finish Lesson", color: ColorManager.whiteColor));
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
    );
  }

  // String _parseHtmlString(String htmlString) {
  //   final document = parse(htmlString);
  //   final String parsedString = parse(document.body!.text).documentElement!.text;
  //   return parsedString;
  // }
  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: widget.title!),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
