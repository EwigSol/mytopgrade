import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:mytopgrade/controllers/lesson_byId_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/models/lesson_byID_model.dart';
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
  // LessonByIdModel? lessonByIdModel;
  String? _url;
  String? name;
  // VideoPlayerController? _controller;
  var isLoading = true;

  @override
  void initState() {
    lessonModelList;
    getLessonByIdData();

    super.initState();
  }

  getLessonByIdData() async {
    lessonModelList = await lessonByIDController.fetchLessonByID(widget.id);
    Future.delayed(const Duration(seconds: 3))
        .then(((value) => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    return lessonModelList.content != null
        ? Scaffold(
            backgroundColor: ColorManager.whiteColor,
            appBar: buildAppBar(lessonModelList.name!),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.08),
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child:
                          //  _controllerr!.value.isInitialized
                          //     ? AspectRatio(
                          //         aspectRatio: _controller!.value.aspectRatio,
                          //         child: VideoPlayer(_controller!),
                          //       )
                          //     : CircularProgressIndicator(),
                          VideoItems(
                        videoPlayerController: VideoPlayerController.network(
                            // 'https://musing-gould.18-141-157-112.plesk.page/wp-content/uploads/2021/11/a-negative-exponent.mp4'),
                            _parseHtmlString(lessonModelList.content!)),
                        looping: false,
                        autoplay: false,
                      ),
                    ),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        await finishLessonController
                            .finishLesson(widget.id.toString());
                        Get.back();
                        if (finishLessonController.isDataSubmitting == false) {
                          Get.snackbar(
                            'Hurrey',
                            'The Lesson is marked as finished',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          Get.snackbar(
                            'Sorry',
                            'The Lesson is Already marked as finished',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }

                        // .then((response) => {
                        //       if (response['status'] == 'success')
                        //         {
                        //           successToast(
                        //               "Success", "Lesson Finished"),
                        //           Get.back()
                        //         }
                        //       else
                        //         {
                        //           errorToast(
                        //               "Error", "Failed to finish Lesson"),
                        //         }
                        //     });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            color: ColorManager.primaryColor),
                        child: Obx(() {
                          return finishLessonController
                                      .isDataSubmitting.value ==
                                  true
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
          )
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(
                    height: 50,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Connecting to the Server..',
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        speed: const Duration(milliseconds: 180),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              color: ColorManager.primaryColor),
                          child: Obx(() {
                            return finishLessonController
                                        .isDataSubmitting.value ==
                                    true
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Center(
                                    child: textStyle2(
                                        text: "Taking Long! ReLoad",
                                        color: ColorManager.whiteColor));
                          }),
                        ),
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
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  String _parseHtmlString(String htmlString) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(htmlString);
    List<String> videoUrl = [];
    for (var match in matches) {
      videoUrl.add(htmlString.substring(match.start, match.end));
    }
    return videoUrl[1].toString();
  }

  @override
  void dispose() {
    lessonByIDController.onClose();
    super.dispose();
  }
}
