// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:topgrade/controllers/quiz_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/quiz_model.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);

  final QuizController quizController = Get.put(QuizController());
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
        Obx(() {
          if (quizController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return quizController.quizList.isNotEmpty
                ? Center(
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        runSpacing: 10,
                        alignment: WrapAlignment.spaceAround,
                        children: quizController.quizList.map((item) {
                          return buildQuizCard(item, context);
                        }).toList()),
                  )
                : Center(child: textStyle0_5(text: "No Quizzes Available"));
          }
        }),
        buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
      ],
    );
  }

  Container buildQuizCard(QuizModel quizModel, BuildContext context) {
    String? duration;
    if (quizModel.duration == Duration.the10Minutes) {
      duration = "10 Minutes";
    } else if (quizModel.duration == Duration.the30Minutes) {
      duration = "30 Minutes";
    } else if (quizModel.duration == Duration.lifeTime) {
      duration = "Life Time";
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s16),
        color: ColorManager.lightGreenColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Quiz Title:"),
            textStyle0_5(text: quizModel.name!),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Quiz Date:"),
            textStyle0_5(text: dateFormat.format(quizModel.dateCreated!)),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Quiz Duration:"),
            textStyle0_5(text: duration!),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Quiz Status:"),
            textStyle0_5(text: quizModel.status!.name),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          ],
        ),
      ),
    );
  }
}
