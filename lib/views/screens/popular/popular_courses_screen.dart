
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'widgets/most_popular_screen.dart';
import 'widgets/trending_screen.dart';

class PopularCoursesScreen extends StatefulWidget {
  const PopularCoursesScreen({Key? key}) : super(key: key);

  @override
  State<PopularCoursesScreen> createState() => _PopularCoursesScreenState();
}

class _PopularCoursesScreenState extends State<PopularCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(),
        body: const TabBarView(
          children: [
            MostPopularScreen(),
            TrendingScreen()
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
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
      bottom: PreferredSize(
        preferredSize: Size(85.w, 10.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
          child: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s22),
              color: ColorManager.redColor,
            ),
            tabs: [
              buildPopularTab(),
              buildTrendingTab(),
            ],
            unselectedLabelColor: ColorManager.blackColor,
            labelStyle: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: ColorManager.whiteColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Tab buildTrendingTab() {
    return Tab(
      child: textStyle2(text: StringsManager.trending),
    );
  }

  Tab buildPopularTab() {
    return Tab(
      child: textStyle2(text: StringsManager.mostP),
    );
  }
}
