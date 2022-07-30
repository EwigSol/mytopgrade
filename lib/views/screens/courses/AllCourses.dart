import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytopgrade/controllers/getAllCourses.dart';
import 'package:mytopgrade/views/screens/home/widgets/PopularCourse.dart';
import '../../../../controllers/courses_controller.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../models/courses_model.dart';
import '../../../../routes/appPages.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';

class AllCoursesScreen extends StatelessWidget {
  // AllCoursesScreen({Key? key}) : super(key: key);
  final AllCoursesController trendingCoursesController =
      Get.put(AllCoursesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Courses',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Get.back();
        //     print('button clicked');
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p10, horizontal: AppPadding.p20),
          child: Column(children: [
            buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
            Obx(() {
              if (trendingCoursesController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                // trendingCoursesController.coursesList.sort((a, b) => a.countStudents!.compareTo(int.parse(b.countStudents.toString())));
                return trendingCoursesController.coursesList.isNotEmpty
                    ? GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: 3 / 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 10),
                        itemCount: trendingCoursesController.coursesList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return PopularCourse(
                            argument:
                                trendingCoursesController.coursesList[index].id,
                            image: trendingCoursesController
                                .coursesList[index].image,
                            sectionslength: trendingCoursesController
                                .coursesList[index].sections!.length,
                            instructor: trendingCoursesController
                                .coursesList[index].instructor,
                            name: trendingCoursesController
                                .coursesList[index].name,
                            price: trendingCoursesController
                                .coursesList[index].price,
                            rating: trendingCoursesController
                                .coursesList[index].rating,
                          );
                        })
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }
            }),
            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }

  Padding buildPopularCard(CoursesModel trendingModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p6, vertical: AppPadding.p4),
      child: InkWell(
        onTap: () {
          Get.toNamed(Paths.details, arguments: trendingModel);
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
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s10),
                                  topRight: Radius.circular(AppSize.s10)),
                              child: Image.network(trendingModel.image!,
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s16),
                                bottomLeft: Radius.circular(AppSize.s16),
                              )),
                          child: Center(
                              child: textStyle0(
                                  text: "\$${trendingModel.price.toString()}",
                                  color: ColorManager.whiteColor)),
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
                child: textStyle0(
                    text: trendingModel.instructor!.name.toString(),
                    color: ColorManager.grayColor),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
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
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: MediaQuery.of(context).size.width * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(
                            MediaQuery.of(context).size.width * 0.02),
                        textStyle0(
                            text: "Sections: ${trendingModel.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(
                            MediaQuery.of(context).size.width * 0.02),
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
