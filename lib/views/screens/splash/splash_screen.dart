

import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';

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
     if(initScreen == 0 || initScreen == null){
       Get.offAllNamed(Paths.onBoard);
     }
     else if(isLogged == true){
       Get.offAllNamed(Paths.homeBar);
     }else{
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
              top: 20.h,
              left: 52.w,
              right: 25.w,
              child: Container(
                height: 10.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s28),
                  color: Colors.white24
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: 10.h,
                    width: 10.w,
                    child: Image.asset(AssetsManager.bookIcon, fit: BoxFit.fill),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 30.h,
                width: 60.w,
                child: Image.asset(AssetsManager.logo, fit: BoxFit.fill),
              ),
            ),



            Positioned(
              bottom: 22.h,
              left: 8.w,
              child: Container(
                height: 11.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s28),
                    color: Colors.white24
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: 10.h,
                    width: 23.w,
                    child: Image.asset(AssetsManager.boxIcon, fit: BoxFit.fill),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 10.h,
              left: 20.w,
              right: 20.w,
              child: SizedBox(
                height: 7.h,
                width: 50.w,
                child: Image.asset(AssetsManager.arrowIcon, fit: BoxFit.fill),
              ),
            ),

          ],
        )
      ),
    );
  }
}
