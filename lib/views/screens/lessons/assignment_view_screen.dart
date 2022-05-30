


import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/start_assignment_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'package:get/get.dart';
import '../../widgets/text_field.dart';

class AssignmentViewScreen extends StatefulWidget {
  final String? id, url, title, duration;
  const AssignmentViewScreen({Key? key, this.id, this.url, this.title, this.duration}) : super(key: key);

  @override
  State<AssignmentViewScreen> createState() => _AssignmentViewScreenState();
}

class _AssignmentViewScreenState extends State<AssignmentViewScreen> {

  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  var startAssignmentController = Get.put(StartAssignmentController());
  final assignmentController = TextEditingController();
  bool started = false;
  File? file;


  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

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
      body: started == false ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSpaceVertical(5.h),
              textStyle2(text: widget.title!),
              buildSpaceVertical(1.h),
              textStyle0_5(text: widget.duration!),
              buildSpaceVertical(3.h),
              Center(
                child: InkWell(
                  onTap: () {
                    startAssignmentController.startAssignment(widget.id.toString()).then((response) => {
                      if(response['message'] == 'You cannot start this Assignment') {
                        successToast("Success", "Assignment Started"),
                        setState((){ started = true; })
                      }else{
                        errorToast("Error", "Failed to Start Assignment"),
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
                      return startAssignmentController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                      Center(child: textStyle2(text: "Start Assignment", color: ColorManager.whiteColor));
                    }),
                  ),
                ),
              )
            ],
          )
          :
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceVertical(4.h),
                _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
                Center(
                  child: SizedBox(
                    height: 30.h,
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

                buildSpaceVertical(2.h),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p20),
                  child: textStyle2(text: "Answer"),
                ),
                buildSpaceVertical(1.h),
                CustomTextField(
                  controller: assignmentController,
                  hintName: "Enter your answer",
                  inputLines: 10,
                ),
                buildSpaceVertical(3.h),
                Center(
                  child: InkWell(
                    onTap: () async{
                      FilePickerResult? result = await FilePicker.platform.pickFiles();

                      if (result != null) {
                        file = File(result.files.single.path!);

                      } else {
                        errorToast("Error", "User canceled the picker");
                      }
                    },
                    child: Container(
                      height: 5.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          color: ColorManager.primaryColor
                      ),
                      child: Obx(() {
                        return startAssignmentController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                        Center(child: textStyle0_5(text: "Add File", color: ColorManager.whiteColor));
                      }),
                    ),
                  ),
                ),
                buildSpaceVertical(3.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // startAssignmentController.finishLesson(widget.id.toString()).then((response) => {
                          //   if(response['status'] == 'success') {
                          //     successToast("Success", "Lesson Finished"),
                          //   }else{
                          //     errorToast("Error", "Failed to finish Lesson"),
                          //   }
                          // });
                        },
                        child: Container(
                          height: 5.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              color: ColorManager.primaryColor
                          ),
                          child: Obx(() {
                            return startAssignmentController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                            Center(child: textStyle0_5(text: "Save", color: ColorManager.whiteColor));
                          }),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // startAssignmentController.finishLesson(widget.id.toString()).then((response) => {
                          //   if(response['status'] == 'success') {
                          //     successToast("Success", "Lesson Finished"),
                          //   }else{
                          //     errorToast("Error", "Failed to finish Lesson"),
                          //   }
                          // });
                        },
                        child: Container(
                          height: 5.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              color: ColorManager.primaryColor
                          ),
                          child: Obx(() {
                            return startAssignmentController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                            Center(child: textStyle0_5(text: "Send", color: ColorManager.whiteColor));
                          }),
                        ),
                      ),

                    ],
                  ),
                ),

                buildSpaceVertical(5.h),
              ],
            ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: widget.title!),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
