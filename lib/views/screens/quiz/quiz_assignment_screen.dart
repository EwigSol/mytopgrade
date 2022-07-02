import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytopgrade/views/screens/quiz/quiz_screen.dart';
import '../../../helpers/helper.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import 'assignment_screen.dart';

class QuizAssignmentScreen extends StatefulWidget {
  const QuizAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<QuizAssignmentScreen> createState() => _QuizAssignmentScreenState();
}

class _QuizAssignmentScreenState extends State<QuizAssignmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
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
                tabs: [buildQuizTab(), buildAssignmentTab()],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: _controller,
                children: [QuizScreen(), AssignmentScreen()],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.allQuiz),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  Tab buildAssignmentTab() {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(
          StringsManager.assignments,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Tab buildQuizTab() {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Text(
          StringsManager.quizzes,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
