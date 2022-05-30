


import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import '../../../controllers/send_assignment_controller.dart';
import '../../../controllers/start_quiz_controller.dart';
import '../../../controllers/submit_assignment_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'package:get/get.dart';
import '../../widgets/text_field.dart';

class QuizViewScreen extends StatefulWidget {
  final QuizByIdModel quizByIdModel;
  const QuizViewScreen({Key? key, required this.quizByIdModel}) : super(key: key);

  @override
  State<QuizViewScreen> createState() => _QuizViewScreenState();
}

class _QuizViewScreenState extends State<QuizViewScreen> {

  var startQuizController = Get.put(StartQuizController());
  var submitAssignmentController = Get.put(SubmitAssignmentController());
  var sendAssignmentController = Get.put(SendAssignmentController());
  final assignmentController = TextEditingController();
  bool started = false;
  bool submitted = false;
  List<bool> listCheck = [];


  @override
  void initState() {
    super.initState();
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
          textStyle2(text: widget.quizByIdModel.name!),
          buildSpaceVertical(1.h),
          textStyle0_5(text: widget.quizByIdModel.duration!),
          buildSpaceVertical(3.h),
          Center(
            child: InkWell(
              onTap: () {
                startQuizController.startQuiz(widget.quizByIdModel.id.toString()).then((response) => {
                  if(response['status'] == 'success') {
                    successToast("Success", "Quiz Started"),
                    setState((){ started = true; })
                  }else{
                    errorToast("Error", "Failed to Start Quiz"),
                  }
                });
              },
              child: Container(
                height: 6.h,
                width: 45.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    color: ColorManager.primaryColor
                ),
                child: Obx(() {
                  return startQuizController.isDataSubmitting.value == true ? const Center(child: CircularProgressIndicator()) :
                  Center(child: textStyle0_15(text: "Start Quiz", color: ColorManager.whiteColor));
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
            Expanded(
              child: ListView.builder(
                  itemCount: widget.quizByIdModel.questions!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    final questions = widget.quizByIdModel.questions![index];
                    if(questions.type == "true_or_false"){
                      return Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            buildSpaceVertical(1.h),
                            textStyle0_5(text: questions.title!),
                            Center(
                              child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: questions.options!.map((item) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(
                                          value: listCheck[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              listCheck[index] = value!;
                                            });
                                          },
                                        ),
                                        textStyle0(text: item.title!)
                                      ],
                                    );
                                  }).toList()
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    else if(questions.type == "multi_choice"){
                      return Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            buildSpaceVertical(1.h),
                            textStyle0_5(text: questions.title!),
                            Center(
                              child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.spaceEvenly,
                                  children: questions.options!.map((item) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(
                                          value: listCheck[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              listCheck[index] = value!;
                                            });
                                          },
                                        ),
                                        textStyle0(text: item.title!)
                                      ],
                                    );
                                  }).toList()
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    else if(questions.type == "fill_in_blanks"){
                      return Container();
                    }
                    return const SizedBox.shrink();
                  }
              ),
            ),
            buildSpaceVertical(3.h),

            Center(
              child: InkWell(
                onTap: () {
                  // if(assignmentController.text.isNotEmpty){
                  //   if(file != null){
                  //     submitAssignmentController.submit(widget.id.toString(), assignmentController.text, file!).then((response) => {
                  //       if(response['status'] == true) {
                  //         successToast("Success", response['message']),
                  //         setState(() { submitted = true; })
                  //       }else{
                  //         errorToast("Error", response['message']),
                  //       }
                  //     });
                  //   }else{
                  //     errorToast("Error", "Add File Please");
                  //   }
                  // }else{
                  //   errorToast("Error", "Add answer Please");
                  // }
                },
                child: Container(
                  height: 6.h,
                  width: 50.w,
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
            ),

            buildSpaceVertical(5.h),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: widget.quizByIdModel.name!),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
