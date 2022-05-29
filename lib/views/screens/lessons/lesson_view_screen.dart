

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
  final String? title, url, id;
  const LessonViewScreen({Key? key, this.title, this.url, this.id}) : super(key: key);

  @override
  State<LessonViewScreen> createState() => _LessonViewScreenState();
}

class _LessonViewScreenState extends State<LessonViewScreen> {

  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  var finishLessonController = Get.put(FinishLessonController());

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  Future<void> initializePlayer() async {
    print(widget.url!);
    _controller = VideoPlayerController.network(widget.url!);
    await Future.wait([_controller.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
      hideControlsTimer: const Duration(seconds: 1),
      placeholder: Container(color: ColorManager.grayColor),
      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),

      // autoInitialize: true,
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
          children: [
            buildSpaceVertical(5.h),
            _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
            SizedBox(
              height: 50.h,
              width: 100.w,
              child: Chewie(
                controller: _chewieController!,
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
