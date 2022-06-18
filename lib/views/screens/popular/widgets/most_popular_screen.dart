// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topgrade/controllers/courses_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/home/widgets/PopularCourse.dart';

class MostPopularScreen extends StatelessWidget {
  MostPopularScreen({Key? key}) : super(key: key);

  final CoursesController popularCoursesController =
      Get.put(CoursesController());
  List<CoursesModel> popularCoursesModel = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            Obx(() {
              if (popularCoursesController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                for (int i = 0;
                    i < popularCoursesController.coursesList.length;
                    i++) {
                  if (popularCoursesController.coursesList[i].rating! >= 3) {
                    // popularCoursesModel.clear();
                    popularCoursesModel
                        .add(popularCoursesController.coursesList[i]);
                  }
                }
                return popularCoursesModel.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: 3 / 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 10),
                        itemCount: popularCoursesModel.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return PopularCourse(
                            argument: popularCoursesModel[index].id,
                            image: popularCoursesModel[index].image,
                            sectionslength:
                                popularCoursesModel[index].sections!.length,
                            instructor: popularCoursesModel[index].instructor,
                            name: popularCoursesModel[index].name,
                            price: popularCoursesModel[index].price,
                            rating: popularCoursesModel[index].rating,
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      );
                // ? Wrap(
                //     crossAxisAlignment: WrapCrossAlignment.start,
                //     direction: Axis.vertical,
                //     spacing: 10,
                //     runSpacing: 2,
                //     alignment: WrapAlignment.start,
                //     runAlignment: WrapAlignment.start,
                //     children: [
                //       for (int i = 0; i < popularCoursesModel.length; i++)
                //         PopularCourse(
                //           argument: popularCoursesModel[i].id,
                //           image: popularCoursesModel[i].image,
                //           sectionslength:
                //               popularCoursesModel[i].sections!.length,
                //           instructor: popularCoursesModel[i].instructor,
                //           name: popularCoursesModel[i].name,
                //           price: popularCoursesModel[i].price,
                //           rating: popularCoursesModel[i].rating,
                //         )
                //     ],
                //   )
                // : Center(
                //     child:
                //         textStyle0_5(text: "No Popular Courses Available"));
              }
            }),
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.04),
          ],
        ),
      ),
    );
  }

  Padding buildPopularCard(CoursesModel popularCourse, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p6, vertical: AppPadding.p4),
      child: InkWell(
        onTap: () {
          Get.toNamed(Paths.details, arguments: popularCourse);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.43,
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
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s10),
                                  topRight: Radius.circular(AppSize.s10)),
                              child: Image.network(popularCourse.image!,
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s16),
                                bottomLeft: Radius.circular(AppSize.s16),
                              )),
                          child: Center(
                              child: textStyle0(
                                  text: "\$${popularCourse.price.toString()}",
                                  color: ColorManager.whiteColor)),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0_5(text: popularCourse.name!),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0(
                    text: popularCourse.instructor!.name.toString(),
                    color: ColorManager.grayColor),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
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
                          height: MediaQuery.of(context).size.height * 0.02,
                          width: MediaQuery.of(context).size.width * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                size: 16, color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(
                            MediaQuery.of(context).size.width * 0.02),
                        textStyle0(
                            text: "Sections: ${popularCourse.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(
                            MediaQuery.of(context).size.width * 0.02),
                        textStyle0(text: popularCourse.rating.toString())
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
