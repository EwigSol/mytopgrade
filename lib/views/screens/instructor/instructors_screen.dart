

import 'package:flutter/material.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:get/get.dart';
import '../../../controllers/courses_controller.dart';
import '../../../helpers/helper.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';

class BestInstructorScreen extends StatefulWidget {
  const BestInstructorScreen({Key? key}) : super(key: key);

  @override
  State<BestInstructorScreen> createState() => _BestInstructorScreenState();
}

class _BestInstructorScreenState extends State<BestInstructorScreen> {

  final CoursesController popularCoursesController = Get.put(CoursesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            Obx((){
              if(popularCoursesController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }else{
                return popularCoursesController.coursesList.isNotEmpty ?
                Center(
                  child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceEvenly,
                      children: popularCoursesController.coursesList.map((item) {
                        return buildInstructorCard(item);
                      }).toList()
                  ),
                )
                    : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: double.infinity,
                    child: Center(child: textStyle0_5(text: "No Instructor Available"))
                );
              }
            }),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.06),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.instructor),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      automaticallyImplyLeading: false,
    );
  }

  Padding buildInstructorCard(CoursesModel catModel) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.17,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(AppSize.s10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            buildSpaceHorizontal(MediaQuery.of(context).size.width * 0.02),
            catModel.instructor!.avatar != '' ?
            CircleAvatar(
              radius: 35,
              backgroundColor: ColorManager.whiteColor,
              backgroundImage: NetworkImage(catModel.instructor!.avatar!),
            )
                :
            const CircleAvatar(
              radius: 35,
              backgroundColor: ColorManager.whiteColor,
              backgroundImage: AssetImage(AssetsManager.girl),
            ),
            buildSpaceHorizontal(MediaQuery.of(context).size.width * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Text(catModel.instructor!.name!.name, maxLines: 3, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
                  Flexible(
                    child: Text(catModel.instructor!.description!, maxLines: 5, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: ColorManager.grayColor),),
                  ),
                ],
              ),
            ),

          ],
        ),
        //  Row(
        //           children: [
        //             SizedBox(
        //               height: 18.h,
        //               width: 18.w,
        //               child: catModel.instructor!.avatar != '' ?
        //               Image.network(catModel.instructor!.avatar!, fit: BoxFit.fill) :
        //               Image.asset(AssetsManager.girl, fit: BoxFit.fill),
        //             ),
        //             buildSpaceHorizontal(1.w),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   buildSpaceVertical(3.h),
        //                   Flexible(
        //                     child: Text(catModel.instructor!.name!.name, maxLines: 3, overflow: TextOverflow.ellipsis,
        //                       style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
        //                   ),
        //                   buildSpaceVertical(1.h),
        //                   Flexible(
        //                     child: Text(catModel.instructor!.description!, maxLines: 5, overflow: TextOverflow.ellipsis,
        //                       style: const TextStyle(fontSize: 11, color: ColorManager.grayColor),),
        //                   ),
        //                   // textStyle0(text: "LifeStyle", color: ColorManager.grayColor),
        //                   // textStyle0(text: "20k Students"),
        //                   // textStyle0(text: "17 Courses"),
        //                   // textStyle0(text: "(4.5)⭐"),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
      ),
    );
  }
}
