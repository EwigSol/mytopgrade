


import 'package:flutter/material.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import '../../../controllers/send_assignment_controller.dart';
import '../../../controllers/start_quiz_controller.dart';
import '../../../controllers/submit_assignment_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'package:get/get.dart';

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
  var selectedAnswer = 0;
  List<int> listAnswer = [];
  int groupValue = -1;


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
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
          textStyle2(text: widget.quizByIdModel.name!),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          textStyle0_5(text: widget.quizByIdModel.duration!),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
          Center(
            child: InkWell(
              onTap: () {
                startQuizController.startQuiz(widget.quizByIdModel.id.toString()).then((response) => {
                  if(response['status'] == 'success') {
                    successToast("Success", response['message']),
                    setState((){ started = true; })
                  }else{
                    errorToast("Error", response['message']),
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
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.04),
            SizedBox(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: widget.quizByIdModel.questions!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    final questions = widget.quizByIdModel.questions![index];
                    if(questions.type == "true_or_false"){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p6),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s10),
                            color: ColorManager.whiteColor,
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
                              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                              textStyle0_5(text: questions.title!),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // _myRadioButton(
                                  //   title: "True",
                                  //   value: 0,
                                  //   onChanged: (newValue) => setState(() => groupValue = newValue),
                                  // ),
                                  // _myRadioButton(
                                  //   title: "False",
                                  //   value: 1,
                                  //   onChanged: (newValue) => setState(() => groupValue = newValue),
                                  // ),
                                  Expanded(
                                    child: RadioListTile(
                                        activeColor: ColorManager.blackColor,
                                        contentPadding: const EdgeInsets.only(right: 1.0),
                                        title: const Text(
                                          "True",
                                          style: TextStyle(color: ColorManager.blackColor, fontSize: 10),
                                        ),
                                        value: 0,
                                        groupValue: selectedAnswer,
                                        onChanged: (value) {
                                          setState(() {
                                            // listAnswer.add(int.parse(value.toString()));
                                            selectedAnswer = int.parse(value.toString());
                                          });
                                        }),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                        activeColor: ColorManager.blackColor,
                                        contentPadding: const EdgeInsets.only(right: 1.0),
                                        title: const Text(
                                          "False",
                                          style: TextStyle(color: ColorManager.blackColor, fontSize: 10),
                                        ),
                                        value: 1,
                                        groupValue: selectedAnswer,
                                        onChanged: (value) {
                                          setState(() {
                                            // listAnswer.add(int.parse(value.toString()));
                                            selectedAnswer = int.parse(value.toString());
                                          });
                                        }),
                                  ),
                                ],
                              ),
                              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                            ],
                          ),
                        ),
                      );
                    }
                    else if(questions.type == "multi_choice"){
                      listCheck = List.generate(questions.options!.length, (index) => false);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p6),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s10),
                            color: ColorManager.whiteColor,
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
                              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
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
                              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                            ],
                          ),
                        ),
                      );
                    }
                    else if(questions.type == "fill_in_blanks"){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p6),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s10),
                            color: ColorManager.whiteColor,
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
                              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                              textStyle0_5(text: questions.title!),
                              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }
              ),
            ),

            buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),

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
            ),

            buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
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

  Widget _myRadioButton({required String title, required int value, required Function onChanged}) {
    return Radio(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged(),
    );
  }
}
