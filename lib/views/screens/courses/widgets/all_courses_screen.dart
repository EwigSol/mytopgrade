// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/models/my_courses_model.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/home/widgets/PopularCourse.dart';
import '../../../../controllers/my_all_courses_controller.dart';

class AllMyCourses extends StatefulWidget {
  const AllMyCourses({Key? key}) : super(key: key);

  @override
  State<AllMyCourses> createState() => _AllMyCoursesState();
}

class _AllMyCoursesState extends State<AllMyCourses> {
  final MyAllCoursesController myCoursesController = Get.put(MyAllCoursesController());

  List<MyCoursesModel> myCoursesModel = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Column(
          children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            Obx(() {
              if (myCoursesController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                // for (int i = 0; i < myCoursesController.myCoursesList.length;
                //     i++) {
                //   if (myCoursesController.myCoursesList[i].rating! >= 3) {
                //     // popularCoursesModel.clear();
                //     myCoursesModel.add(myCoursesController.myCoursesList[i]);
                //   }
                // }
                return myCoursesController.myCoursesList.isNotEmpty
                    ? GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: 3 / 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 10),
                        itemCount: myCoursesController.myCoursesList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return PopularCourse(
                            argument: myCoursesController.myCoursesList[index].id,
                            image: myCoursesController.myCoursesList[index].image,
                            sectionslength:
                            myCoursesController.myCoursesList[index].sections!.length,
                            instructor: myCoursesController.myCoursesList[index].instructor,
                            name: myCoursesController.myCoursesList[index].name,
                            price: myCoursesController.myCoursesList[index].price,
                            rating: myCoursesController.myCoursesList[index].rating,
                          );
                        })
                    : const Center(
                        child: Text("Sorry You have started no course yet"),
                      );
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

  @override
  void dispose() {
    myCoursesController.onClose();
    super.dispose();
  }
}
