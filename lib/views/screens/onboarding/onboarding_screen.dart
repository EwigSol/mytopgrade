
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/onboarding_controller.dart';
import '../../../helpers/helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';
import 'widgets/build_dot.dart';
import 'widgets/splash_content.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = OnboardingController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: PageView.builder(
                  controller: _controller.pageController,
                  onPageChanged: _controller.selectedPageIndex,
                  itemCount: _controller.onboardingPages.length,
                  itemBuilder: (context, index) {
                    return SplashContent(
                      image: _controller.onboardingPages[index].imageAsset,
                      text: _controller.onboardingPages[index].title,
                    );
                  }),
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Column(
                  children: <Widget>[
                    buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _controller.onboardingPages.length, (index) => Obx(() {
                        return buildDot(index: index, current: _controller.selectedPageIndex.value);
                      }),
                      ),
                    ),
                    buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20, color: ColorManager.secondaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.50, MediaQuery.of(context).size.height * 0.06),
                        primary: ColorManager.primaryColor,
                      ),
                      onPressed: _controller.forwardAction,
                      child: Obx(() {
                        return Text(_controller.isLastPage ? StringsManager.start : StringsManager.next);
                      }),
                    ),
                    buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
