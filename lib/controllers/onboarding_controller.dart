


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/onboarding_model.dart';
import '../routes/appPages.dart';
import '../utils/assets_manager.dart';
import '../utils/strings_manager.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      Get.toNamed(Paths.authView);
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfoModel> onboardingPages = [
    OnboardingInfoModel(AssetsManager.splash1, StringsManager.splash1Title),
    OnboardingInfoModel(AssetsManager.splash2, StringsManager.splash2Title),
    OnboardingInfoModel(AssetsManager.splash3, StringsManager.splash3Title)
  ];

}