


import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/send_assignment_controller.dart';
import '../../../controllers/start_assignment_controller.dart';
import '../../../controllers/submit_assignment_controller.dart';
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
  var submitAssignmentController = Get.put(SubmitAssignmentController());
  var sendAssignmentController = Get.put(SendAssignmentController());
  final assignmentController = TextEditingController();
  bool started = false;
  bool submitted = false;
  File? file;
  String fileName = "";


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
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
              textStyle2(text: widget.title!),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              textStyle0_5(text: widget.duration!),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
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
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.primaryColor
                    ),
                    child: Obx(() {
                      return startAssignmentController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                      Center(child: textStyle0_15(text: "Start Assignment", color: ColorManager.whiteColor));
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
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.04),
                _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ?
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width * 0.95,
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

                buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p20),
                  child: textStyle2(text: "Answer"),
                ),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                CustomTextField(
                  controller: assignmentController,
                  hintName: "Enter your answer",
                  inputLines: 10,
                ),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.93,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          color: ColorManager.whiteColor,
                          border: Border.all()
                      ),
                      child: InkWell(
                        onTap: () async{
                          FilePickerResult? result = await FilePicker.platform.pickFiles();
                          if (result != null) {
                            file = File(result.files.single.path!);
                            fileName = result.files.single.name;
                            setState(() {  });

                          } else {
                            errorToast("Error", "User canceled the picker");
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.attach_file, color: ColorManager.primaryColor, size: 30),
                            Expanded(child: textStyle0_5(text: fileName.isNotEmpty || fileName != "" ? fileName : "Add Assignment File" , color: ColorManager.primaryColor)),
                          ],
                        ),
                      )
                  ),
                ),
                buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),

                submitted == false ?
                Center(
                  child: InkWell(
                    onTap: () {
                     if(assignmentController.text.isNotEmpty){
                       if(file != null){
                         submitAssignmentController.submit(widget.id.toString(), assignmentController.text, file!).then((response) => {
                           if(response['status'] == true) {
                             successToast("Success", response['message']),
                             setState(() { submitted = true; })
                           }else{
                             errorToast("Error", response['message']),
                           }
                         });
                       }else{
                         errorToast("Error", "Add File Please");
                       }
                     }else{
                       errorToast("Error", "Add answer Please");
                     }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          color: ColorManager.primaryColor
                      ),
                      child: Obx(() {
                        return submitAssignmentController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                        Center(child: textStyle0_5(text: "Save", color: ColorManager.whiteColor));
                      }),
                    ),
                  ),
                )
                :
                Center(
                  child: InkWell(
                    onTap: () {
                      if(assignmentController.text.isNotEmpty){
                        if(file != null){
                          sendAssignmentController.send(widget.id.toString(), assignmentController.text, file!).then((response) => {
                            if(response['status'] == true) {
                              successToast("Success", response['message']),
                              Get.offAllNamed(Paths.homeBar),
                            }else{
                              errorToast("Error", response['message']),
                            }
                          });
                        }else{
                          errorToast("Error", "Add File Please");
                        }
                      }else{
                        errorToast("Error", "Add answer Please");
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          color: ColorManager.primaryColor
                      ),
                      child: Obx(() {
                        return sendAssignmentController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                        Center(child: textStyle0_5(text: "Send", color: ColorManager.whiteColor));
                      }),
                    ),
                  ),
                ),

                buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
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
