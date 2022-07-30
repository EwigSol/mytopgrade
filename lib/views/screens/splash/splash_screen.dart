import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/utils/assets_manager.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? initScreen;
  bool? isLogged = false;
  final box = GetStorage();

  @override
  void initState() {
    initScreen = box.read("initScreen");
    box.write("initScreen", 1);
    isLogged = box.read("isLogged");

    Timer(const Duration(seconds: 3), () {
      if (initScreen == 0 || initScreen == null) {
        Get.offAllNamed(Paths.onBoard);
      } else if (isLogged == true) {
        Get.offAllNamed(Paths.homeBar);
      } else {
        Get.offAllNamed(Paths.authView);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ColorManager.primaryColor,
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.20,
                left: MediaQuery.of(context).size.width * 0.52,
                right: MediaQuery.of(context).size.width * 0.25,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      color: Colors.white24),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width * 0.10,
                      child:
                          Image.asset(AssetsManager.bookIcon, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  // width: MediaQuery.of(context).size.width * 0.60,
                  child: Image.asset(AssetsManager.logo, fit: BoxFit.fill),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.22,
                left: MediaQuery.of(context).size.width * 0.08,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      color: Colors.white24),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width * 0.20,
                      child:
                          Image.asset(AssetsManager.boxIcon, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.10,
                left: MediaQuery.of(context).size.width * 0.40,
                right: MediaQuery.of(context).size.width * 0.20,
                child: SizedBox(
                  child: Image.asset(AssetsManager.arrowIcon, fit: BoxFit.fill),
                ),
              ),
            ],
          )),
    );
  }
}
