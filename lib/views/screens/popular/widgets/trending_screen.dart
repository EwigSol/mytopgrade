
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../controllers/courses_controller.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../models/courses_model.dart';
import '../../../../routes/appPages.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';
import '../../details/details_screen.dart';

class TrendingScreen extends StatelessWidget {
  TrendingScreen({Key? key}) : super(key: key);
  final CoursesController trendingCoursesController = Get.put(CoursesController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Column(
          children: [
            buildSpaceVertical(1.h),
            Obx((){
              if(trendingCoursesController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }else{
                // trendingCoursesController.coursesList.sort((a, b) => a.countStudents!.compareTo(int.parse(b.countStudents.toString())));
                return trendingCoursesController.coursesList.isNotEmpty ?
                Center(
                  child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceEvenly,
                      children: trendingCoursesController.coursesList.map((item) {
                        return buildPopularCard(item, context);
                      }).toList()
                  ),
                )
                    : Center(child: textStyle0_5(text: "No Trending Courses Available"));
              }
            }),
            buildSpaceVertical(4.h),
          ],
        ),
      ),
    );
  }

  Padding buildPopularCard(CoursesModel trendingModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6, vertical: AppPadding.p4),
      child: InkWell(
        onTap: (){
          Get.toNamed(Paths.details, arguments: trendingModel);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(coursesDetail: trendingModel, isWishlist: false,)));
        },
        child: Container(
          width: 43.w,
          decoration: const BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s10),
                topRight: Radius.circular(AppSize.s10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 14.h,
                  width: 100.w,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 14.h,
                          width: 100.w,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s10),
                                  topRight: Radius.circular(AppSize.s10)),
                              child: Image.network(trendingModel.image!, fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: 4.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s16),
                                bottomLeft: Radius.circular(AppSize.s16),
                              )),
                          child: Center(
                              child: textStyle0(text: "\$${trendingModel.price.toString()}", color: ColorManager.whiteColor)),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0_5(text: trendingModel.name!),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0(text: trendingModel.instructor!.name.toString(), color: ColorManager.grayColor),
              ),
              buildSpaceVertical(2.h),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p4, right: AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 3.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(2.w),
                        textStyle0(text: "Sections: ${trendingModel.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(2.w),
                        textStyle0(text: trendingModel.rating.toString())
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

