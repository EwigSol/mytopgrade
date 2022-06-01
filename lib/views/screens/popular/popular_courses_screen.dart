


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:topgrade/helpers/helper.dart';
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

class _PopularCoursesScreenState extends State<PopularCoursesScreen> with SingleTickerProviderStateMixin {

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p6),
            child: TabBar(
              isScrollable: true,
              indicator: BoxDecoration(color: ColorManager.redColor, borderRadius: BorderRadius.circular(AppSize.s22)),
              controller: _controller,
              unselectedLabelColor: ColorManager.blackColor,
              unselectedLabelStyle: const TextStyle(color: ColorManager.blackColor),
              tabs: [
                buildPopularTab(),
                buildTrendingTab()

              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
              controller: _controller,
              children: [
                MostPopularScreen(),
                TrendingScreen()
              ],
            ),
          )
        ],
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

  Tab buildTrendingTab() {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(StringsManager.trending, style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),),
      ),
    );
  }

  Tab buildPopularTab() {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(StringsManager.mostP, style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),),
      ),
    );
  }
}
