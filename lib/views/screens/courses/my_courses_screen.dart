

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/courses/widgets/all_courses_screen.dart';
import 'package:topgrade/views/screens/courses/widgets/completed_courses_screen.dart';
import 'package:topgrade/views/screens/courses/widgets/upcoming_courses_screen.dart';
import 'package:get/get.dart';
import '../../../controllers/my_courses_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';


class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  String? title;
  int? selectedIndex;

  final MyCoursesController myCoursesController = Get.put(MyCoursesController());

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedIndex = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildSpaceVertical(2.h),
          SizedBox(
            height: 6.h,
            width: double.infinity,
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if(index == 0){
                    title = StringsManager.all;
                  }else if(index == 1){
                    title = StringsManager.upComing;
                  } else if(index == 2){
                    title = StringsManager.completed;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s22),
                          color: selectedIndex == index ? ColorManager.redColor : ColorManager.whiteColor,
                          border: Border.all(color: ColorManager.blackColor, width: 0.5),
                        ),
                        child: Row(
                          children: [
                            buildSpaceHorizontal(3.w),
                            Container(
                              height: 4.h,
                              width: 8.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.s30),
                                color: ColorManager.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                            buildSpaceHorizontal(3.w),
                            textStyle1(text: title!, color: selectedIndex == index ? ColorManager.whiteColor : ColorManager.blackColor),
                            buildSpaceHorizontal(2.w),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
          Expanded(
              child: selectedIndex == 0 ? AllCoursesScreen() : selectedIndex == 1 ? const UpComingCoursesScreen() : const CompletedCoursesScreen()
          ),
          buildSpaceVertical(5.h),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.myCourse),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
