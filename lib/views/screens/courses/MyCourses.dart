import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import 'package:topgrade/views/screens/courses/widgets/InProgress.dart';
import 'package:topgrade/views/screens/courses/widgets/all_courses_screen.dart';
import 'package:topgrade/views/screens/courses/widgets/FinishedCourses.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses>
    with SingleTickerProviderStateMixin {
  double height = Get.height;
  double width = Get.width;

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        child: Column(
          children: [
            buildSpaceVertical(height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p6, horizontal: AppPadding.p6),
              child: TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                    color: ColorManager.redColor,
                    borderRadius: BorderRadius.circular(AppSize.s22)),
                controller: _controller,
                unselectedLabelColor: ColorManager.blackColor,
                unselectedLabelStyle:
                    const TextStyle(color: ColorManager.blackColor),
                tabs: [
                  alMyCoursesTab(),
                  inProgrressCoursesTab(),
                  finishedCoursesTab()
                ],
              ),
            ),
            SizedBox(
              height: height * 0.65,
              width: width,
              child: TabBarView(
                controller: _controller,
                children: [
                  AllMyCourses(),
                  InProgressCourses(),
                  FinishedCourses()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.whiteColor,
      title: textStyle2(text: StringsManager.popular),
      centerTitle: true,
      elevation: 0.5,
      automaticallyImplyLeading: false,
    );
  }

  Tab alMyCoursesTab() {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(
          'My Courses',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Tab inProgrressCoursesTab() {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(
          'In Progress',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Tab finishedCoursesTab() {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(
          'Finished Courses',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
