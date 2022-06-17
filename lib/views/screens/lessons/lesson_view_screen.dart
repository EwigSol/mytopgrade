import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:topgrade/controllers/lesson_byId_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/lesson_byID_model.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/finish_lesson_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'package:get/get.dart';
import 'widgets/VideoItems.dart';

class LessonViewScreen extends StatefulWidget {
  var id;
  LessonViewScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<LessonViewScreen> createState() => _LessonViewScreenState();
}

class _LessonViewScreenState extends State<LessonViewScreen> {
  final FinishLessonController finishLessonController =
      Get.put(FinishLessonController());
  final LessonByIDController lessonByIDController =
      Get.put(LessonByIDController());
  late LessonByIdModel lessonModelList = LessonByIdModel();
  String? url;
  String? name;

  @override
  void initState() {
    super.initState();
    lessonByIDController;
    lessonModelList;
    getLessonByIdData();
  }

  getLessonByIdData() async {
    lessonModelList =
        (await lessonByIDController.fetchLessonByID(widget.id.toString()))!;
    url = _parseHtmlString(lessonModelList.content!);

    name = lessonModelList.name!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(name),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.08),
            // Center(
            //   child: SizedBox(
            //     height: MediaQuery.of(context).size.height * 0.40,
            //     width: MediaQuery.of(context).size.width * 0.95,
            //     child: VideoItems(
            //       videoPlayerController: VideoPlayerController.network(url!),
            //       looping: false,
            //       autoplay: true,
            //     ),
            //   ),
            // ),
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
                                Get.back()
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
    );
  }

  AppBar buildAppBar(text) {
    return AppBar(
      title: textStyle2(text: text),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}
// class LessonViewScreen extends StatefulWidget {


//   @override
//   State<LessonViewScreen> createState() => _LessonViewScreenState();
// }

// class _LessonViewScreenState extends State<LessonViewScreen> {
//   // VideoPlayerController? _controller;
//   // ChewieController? _chewieController;
  
//   // final LessonByIDController lessonByIDController =
//   //     Get.put(LessonByIDController());
//   // late LessonByIdModel lessonModelList = LessonByIdModel();

//   // String? url;

//   @override
//   void initState() {
//     super.initState();
//     // lessonModelList;
//     // getLessonByIdData();
//   }

//   // getLessonByIdData() async {
//   //   lessonModelList = (await lessonByIDController.fetchLessonByID(widget.id))!;


//   // _chewieController = ChewieController(
//   //   videoPlayerController: VideoPlayerController.network(
//   //       'https://musing-gould.18-141-157-112.plesk.page/wp-content/uploads/2020/06/Narrative-Essay2.mp4'),
//   //   autoPlay: false,
//   //   looping: false,
//   //   hideControlsTimer: const Duration(seconds: 1),
//   //   placeholder: Container(color: ColorManager.grayColor),
//   // );

//   // }

//   // Future<void> initializePlayer() async {
//   //   _controller = );

//   // }

//   // void _createChewieController() {
//   //   _chewieController = ChewieController(
//   //     videoPlayerController: _controller,
//   //     autoPlay: false,
//   //     looping: false,
//   //     hideControlsTimer: const Duration(seconds: 1),
//   //     placeholder: Container(color: ColorManager.grayColor),
//   //   );
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   // _controller.dispose();
//   //   _chewieController?.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.whiteColor,
//       appBar: widget.name != null
//           ? buildAppBar(widget.name.toString())
//           : buildAppBar('sorry not working'),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildSpaceVertical(MediaQuery.of(context).size.height * 0.08),
//             Center(
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.40,
//                 width: MediaQuery.of(context).size.width * 0.95,
//                 // child: Chewie(
//                 //   controller: _chewieController!,
//                 // )

//                 // lessonModelList.content != null
//                 child: VideoItems(
//                   videoPlayerController:
//                       VideoPlayerController.network('${widget.url}'),
//                   looping: false,
//                   autoplay: true,
//                 ),
//               ),
//             ),
//             buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
//             Center(
//               child: InkWell(
//                 onTap: () {
//                   finishLessonController
//                       .finishLesson(widget.id.toString())
//                       .then((response) => {
//                             if (response['status'] == 'success')
//                               {
//                                 successToast("Success", "Lesson Finished"),
//                                 Get.back()
//                               }
//                             else
//                               {
//                                 errorToast("Error", "Failed to finish Lesson"),
//                               }
//                           });
//                 },
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.06,
//                   width: MediaQuery.of(context).size.width * 0.60,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(AppSize.s12),
//                       color: ColorManager.primaryColor),
//                   child: Obx(() {
//                     return finishLessonController.isDataSubmitting.value == true
//                         ? const Center(child: CircularProgressIndicator())
//                         : Center(
//                             child: textStyle2(
//                                 text: "Finish Lesson",
//                                 color: ColorManager.whiteColor));
//                   }),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   AppBar buildAppBar(text) {
//     return AppBar(
//       title: textStyle2(text: text),
//       centerTitle: true,
//       backgroundColor: ColorManager.whiteColor,
//       elevation: 0.5,
//     );
//   }

//   String _parseHtmlString(String htmlString) {
//     final document = parse(htmlString);
//     final String parsedString =
//         parse(document.body!.text).documentElement!.text;
//     return parsedString;
//   }
// }
