

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/controllers/quiz_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/quiz_model.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';

class QuizScreen extends StatelessWidget {
   QuizScreen({Key? key}) : super(key: key);

  final QuizController quizController = Get.put(QuizController());
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildSpaceVertical(5.h),
          Obx((){
            if(quizController.isLoading.value){
              return const Center(child: CircularProgressIndicator());
            }else{
              return quizController.quizList.isNotEmpty ?
              Center(
                child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 5,
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceAround,
                    children: quizController.quizList.map((item) {
                      return buildQuizCard(item);
                    }).toList()
                ),
              )
                  : Center(child: textStyle0_5(text: "No Category Available"));
            }
          }),
          buildSpaceVertical(5.h),
        ],
      ),
    );
  }

  Container buildQuizCard(QuizModel quizModel) {
    String? duration;
    if(quizModel.duration == Duration.the10Minutes){
      duration = "10 Minutes";
    }else if(quizModel.duration == Duration.the30Minutes){
      duration = "30 Minutes";
    }else if(quizModel.duration == Duration.lifeTime){
      duration = "Life Time";
    }
    return Container(
        // height: 36.h,
        width: 45.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s16),
          color: ColorManager.lightGreenColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(1.h),
              textStyle0(text: "Quiz Title:"),
              textStyle0_5(text: quizModel.name!),
              buildSpaceVertical(1.h),
              textStyle0(text: "Quiz Date:"),
              textStyle0_5(text: dateFormat.format(quizModel.dateCreated!)),
              buildSpaceVertical(1.h),
              textStyle0(text: "Quiz Duration:"),
              textStyle0_5(text: duration!),
              buildSpaceVertical(1.h),
              textStyle0(text: "Quiz Status:"),
              textStyle0_5(text: quizModel.status!.name),
              buildSpaceVertical(1.h),
            ],
          ),
        ),
      );
  }


}
