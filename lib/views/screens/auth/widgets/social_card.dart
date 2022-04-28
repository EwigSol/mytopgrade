





import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';

class SocialCard extends StatelessWidget {
  final String img;
  const SocialCard({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width: 20.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          height: 4.h,
          width: 10.w,
          child: Image.asset(img, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
