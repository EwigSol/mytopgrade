import 'dart:convert';

import 'package:flutter/material.dart';
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
  // LessonByIdModel? lessonByIdModel;
  String? _url;
  String? name;
  // VideoPlayerController? _controller;
  var isLoading = true;

  @override
  void initState() {
    lessonModelList;
    getLessonByIdData();
    print('get lesson called');
    // initialize();
    super.initState();
  }

  getLessonByIdData() async {
    lessonModelList = await lessonByIDController.fetchLessonByID(widget.id);
    Future.delayed(Duration(seconds: 3)).then(((value) => setState(() {})));
  }

  // bhb

  @override
  Widget build(BuildContext context) {
    return isLoading == true && lessonModelList.name != null
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
                        autoplay: true,
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
                                      successToast(
                                          "Success", "Lesson Finished"),
                                      Get.back()
                                    }
                                  else
                                    {
                                      errorToast(
                                          "Error", "Failed to finish Lesson"),
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
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
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
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    final String result =
        parsedString.substring(0, parsedString.lastIndexOf(':'));
    final String finalurl = jsonEncode(result);
    final String url = finalurl.replaceAll('\\n', '\n').replaceAll('', '');

    print(url);
    print(result);

    return url;
  }

  @override
  void dispose() {
    lessonByIDController.onClose();
    super.dispose();
  }
}
