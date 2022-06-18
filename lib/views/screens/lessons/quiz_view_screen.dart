import 'package:flutter/material.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import '../../../controllers/finish_quiz_controller.dart';
import '../../../controllers/quiz_byID_controller.dart';
import '../../../controllers/start_quiz_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../routes/appPages.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import 'package:get/get.dart';

import '../../widgets/text_field.dart';

class QuizViewScreen extends StatefulWidget {
  var id;
  // var model;
  // var name;
  // var duration;

  QuizViewScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<QuizViewScreen> createState() => _QuizViewScreenState();
}

class _QuizViewScreenState extends State<QuizViewScreen> {
  var quizByIdController = Get.put(QuizByIDController());
  var startQuizController = Get.put(StartQuizController());
  var finishQuizController = Get.put(FinishQuizController());

  late QuizByIdModel quizModelList = QuizByIdModel();
  bool started = false;
  bool submitted = false;
  var selectedAnswer = 0;
  final answerController = TextEditingController();

  //store all question list in the below list and if question type is multi choice so we store list in fasle
  List<List<dynamic>> answerList = [];
  int? multiChoiceQuestion;
  List<String> multiChoiceAnswers = [];
  String? trueFalseQuestion;
  var trueFalseAnswers = true.obs;
  String? sortingQuestion;
  List<dynamic> sortingAnswers = [];
  String? singleChoiceQuestion;
  List<dynamic> singleChoiceAnswers = [];
  String? fillBlanksQuestion;
  List<dynamic> fillBlanksAnswers = [];
  List<int> listRadio = [];

  @override
  void initState() {
    quizModelList;
    getQuizByIdData();
    print('get quiz called');
    super.initState();
  }

  getQuizByIdData() async {
    quizModelList = await quizByIdController.fetchQuizByID(widget.id);
    Future.delayed(Duration(seconds: 1)).then(((value) => setState(() {})));
    getAnswers();
  }

  getAnswers() {
    for (int i = 0; i < quizModelList.questions!.length; i++) {
      if (quizModelList.questions![i].type == 'multi_choice') {
        answerList.add(List.generate(
            quizModelList.questions![i].options!.length, (index) => false));
        listRadio.add(0);
      } else if (quizModelList.questions![i].type == 'true_or_false') {
        answerList.add([-1]);
        listRadio.add(1);
      } else if (quizModelList.questions![i].type == 'sorting_choice') {
        answerList.add(List.generate(
            quizModelList.questions![i].options!.length, (index) => false));
        listRadio.add(0);
      } else if (quizModelList.questions![i].type == 'single_choice') {
        answerList.add(List.generate(
            quizModelList.questions![i].options!.length, (index) => false));
        listRadio.add(0);
      } else {
        answerList.add([false]);
        listRadio.add(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return quizModelList.name != null
        ? Scaffold(
            backgroundColor: ColorManager.whiteColor,
            appBar: buildAppBar(),
            body: started == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildSpaceVertical(
                          MediaQuery.of(context).size.height * 0.05),
                      textStyle2(text: quizModelList.name.toString()),
                      buildSpaceVertical(
                          MediaQuery.of(context).size.height * 0.01),
                      textStyle0_5(text: quizModelList.duration!),
                      buildSpaceVertical(
                          MediaQuery.of(context).size.height * 0.03),
                      Center(
                        child: InkWell(
                          onTap: () {
                            startQuizController
                                .startQuiz(quizModelList.id.toString())
                                .then((response) => {
                                      if (response['status'] == 'success')
                                        {
                                          successToast(
                                              "Success", response['message']),
                                          setState(() {
                                            started = true;
                                          })
                                        }
                                      else
                                        {
                                          errorToast(
                                              "Error", response['message']),
                                        }
                                    });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12),
                                color: ColorManager.primaryColor),
                            child: Obx(() {
                              return startQuizController
                                          .isDataSubmitting.value ==
                                      true
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Center(
                                      child: textStyle0_15(
                                          text: "Start Quiz",
                                          color: ColorManager.whiteColor));
                            }),
                          ),
                        ),
                      )
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.04),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: quizModelList.questions!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final questions =
                                    quizModelList.questions![index];

                                if (questions.type == "true_or_false") {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p12,
                                        vertical: AppPadding.p6),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10),
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
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          textStyle0_5(text: questions.title!),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: RadioListTile(
                                                    activeColor:
                                                        ColorManager.blackColor,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            right: 1.0),
                                                    title: const Text("True",
                                                        style: TextStyle(
                                                            color: ColorManager
                                                                .blackColor,
                                                            fontSize: 10)),
                                                    value: 0,
                                                    groupValue:
                                                        listRadio[index],
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        listRadio[index] =
                                                            value!;
                                                        trueFalseQuestion =
                                                            questions.id
                                                                .toString();
                                                        trueFalseAnswers =
                                                            true.obs;
                                                      });
                                                    }),
                                              ),
                                              Expanded(
                                                child: RadioListTile(
                                                    activeColor:
                                                        ColorManager.blackColor,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            right: 1.0),
                                                    title: const Text(
                                                      "False",
                                                      style: TextStyle(
                                                          color: ColorManager
                                                              .blackColor,
                                                          fontSize: 10),
                                                    ),
                                                    value: 1,
                                                    groupValue:
                                                        listRadio[index],
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        listRadio[index] =
                                                            value!;
                                                        trueFalseQuestion =
                                                            questions.id
                                                                .toString();
                                                        trueFalseAnswers =
                                                            false.obs;
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (questions.type == "multi_choice") {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p12,
                                        vertical: AppPadding.p6),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10),
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
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          textStyle0_5(text: questions.title!),
                                          SizedBox(
                                            height: 40,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    questions.options!.length,
                                                itemBuilder: (context, i) {
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Checkbox(
                                                        value: answerList[index]
                                                            [i],
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            answerList[index]
                                                                    [i] =
                                                                !answerList[
                                                                    index][i];
                                                            multiChoiceQuestion =
                                                                questions.id;
                                                            multiChoiceAnswers
                                                                .add(questions
                                                                    .options![i]
                                                                    .uid
                                                                    .toString());
                                                          });
                                                        },
                                                      ),
                                                      textStyle0(
                                                          text: questions
                                                              .options![i]
                                                              .title!)
                                                    ],
                                                  );
                                                }),
                                          ),
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (questions.type == "sorting_choice") {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p12,
                                        vertical: AppPadding.p6),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10),
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
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          textStyle0_5(text: questions.title!),
                                          SizedBox(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    questions.options!.length,
                                                itemBuilder: (context, j) {
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Checkbox(
                                                        value: answerList[index]
                                                            [j],
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            answerList[index]
                                                                    [j] =
                                                                !answerList[
                                                                    index][j];
                                                            sortingQuestion =
                                                                questions.id
                                                                    .toString();
                                                            sortingAnswers.add(
                                                                questions
                                                                    .options![j]
                                                                    .value);
                                                          });
                                                        },
                                                      ),
                                                      textStyle0(
                                                          text: questions
                                                              .options![j]
                                                              .title!)
                                                    ],
                                                  );
                                                }),
                                          ),
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (questions.type == "single_choice") {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p12,
                                        vertical: AppPadding.p6),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10),
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
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          textStyle0_5(text: questions.title!),
                                          SizedBox(
                                            height: 40,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    questions.options!.length,
                                                itemBuilder: (context, i) {
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Checkbox(
                                                        value: answerList[index]
                                                            [i],
                                                        onChanged:
                                                            (bool? value) {
                                                          singleChoiceAnswers
                                                              .clear();
                                                          setState(() {
                                                            for (var element
                                                                in questions
                                                                    .options!) {
                                                              answerList[index]
                                                                  [i] = false;
                                                            }
                                                            answerList[index]
                                                                [i] = value;
                                                            singleChoiceQuestion =
                                                                questions.id
                                                                    .toString();
                                                            singleChoiceAnswers
                                                                .add(questions
                                                                    .options![i]
                                                                    .value
                                                                    .toString());
                                                          });
                                                        },
                                                      ),
                                                      textStyle0(
                                                          text: questions
                                                              .options![i]
                                                              .title!)
                                                    ],
                                                  );
                                                }),
                                          ),
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (questions.type == "fill_in_blanks") {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p12,
                                        vertical: AppPadding.p6),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s10),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          Center(
                                              child: textStyle0_5(
                                                  text: questions.title!)),
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          CustomTextField(
                                            controller: answerController,
                                            hintName: "Enter Answer",
                                          ),
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          InkWell(
                                            onTap: () {
                                              fillBlanksQuestion =
                                                  questions.id.toString();
                                              fillBlanksAnswers
                                                  .add(answerController.text);
                                            },
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s10),
                                                    color: ColorManager
                                                        .primaryColor),
                                                child: Center(
                                                    child: textStyle0_5(
                                                        text: 'Submit')),
                                              ),
                                            ),
                                          ),
                                          buildSpaceVertical(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                        ),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.03),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              await finishQuizController
                                  .finishQuiz(
                                      multiChoiceAnswers,
                                      trueFalseAnswers,
                                      sortingAnswers,
                                      singleChoiceAnswers,
                                      fillBlanksAnswers,
                                      multiChoiceQuestion!,
                                      trueFalseQuestion,
                                      sortingQuestion,
                                      singleChoiceQuestion,
                                      fillBlanksQuestion,
                                      quizModelList.id.toString())
                                  .then((response) => {
                                        if (response['status'] == true)
                                          {
                                            Get.snackbar(
                                                'Quiz Submited Successfully',
                                                "Please Check 'Your Results' in results Segment",
                                                snackPosition:
                                                    SnackPosition.BOTTOM),
                                            Get.toNamed(Paths.homeBar)
                                          }
                                        else
                                          {
                                            errorToast(
                                                "Error", "Unable Finish Quiz"),
                                          }
                                      });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                  color: ColorManager.primaryColor),
                              child: Obx(() {
                                return finishQuizController
                                            .isDataSubmitting.value ==
                                        true
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Center(
                                        child: textStyle0_5(
                                            text: "Finish",
                                            color: ColorManager.whiteColor));
                              }),
                            ),
                          ),
                        ),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.05),
                      ],
                    ),
                  ),
          )
        : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: quizModelList.name!),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  @override
  void dispose() {
    quizByIdController.onClose();
    super.dispose();
  }
}
