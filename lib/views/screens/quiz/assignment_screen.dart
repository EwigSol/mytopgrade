

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:topgrade/controllers/assignments_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/assignments_model.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';

class AssignmentScreen extends StatelessWidget {
  AssignmentScreen({Key? key}) : super(key: key);

  final AssignmentController assignmentController = Get.put(AssignmentController());
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
        Obx((){
          if(assignmentController.isLoading.value){
            return const Center(child: CircularProgressIndicator());
          }else{
            return assignmentController.assignmentList.isNotEmpty ?
            Center(
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 5,
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceAround,
                  children: assignmentController.assignmentList.map((item) {
                    return buildAssignmentCard(item, context);
                  }).toList()
              ),
            )
                : Center(child: textStyle0_5(text: "No Assignments Available"));
          }
        }),
        buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
      ],
    );
  }

  Container buildAssignmentCard(AssignmentModel assignmentModel, BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s16),
        color: ColorManager.lightBlueColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Assignment Title:"),
            textStyle0_5(text: assignmentModel.name!),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Assignment Date:"),
            textStyle0_5(text: dateFormat.format(assignmentModel.dateCreated!)),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Assignment Duration:"),
            textStyle0_5(text: assignmentModel.duration!.format!),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            textStyle0(text: "Assignment Status:"),
            textStyle0_5(text: assignmentModel.status!),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          ],
        ),
      ),
    );
  }


}
