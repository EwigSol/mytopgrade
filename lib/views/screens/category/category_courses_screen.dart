import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytopgrade/utils/assets_manager.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../models/courses_model.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/values_manager.dart';
import '../../../controllers/courses_by_category_controller.dart';
import '../../../routes/appPages.dart';
import '../../../utils/strings_manager.dart';

class CategoryCoursesScreen extends StatefulWidget {
  final String id;
  const CategoryCoursesScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CategoryCoursesScreen> createState() => _CategoryCoursesScreenState();
}

class _CategoryCoursesScreenState extends State<CategoryCoursesScreen> {
  final CoursesByCategoryController coursesByCategoryController =
      Get.put(CoursesByCategoryController());

  @override
  void initState() {
    super.initState();
    coursesByCategoryController.fetchAllCoursesByCategory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          child: Column(
            children: [
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
              Obx(() {
                if (coursesByCategoryController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return coursesByCategoryController
                          .coursesByCategoryList.isNotEmpty
                      ? Center(
                          child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 5,
                              runSpacing: 10,
                              alignment: WrapAlignment.spaceEvenly,
                              children: coursesByCategoryController
                                  .coursesByCategoryList
                                  .map((item) {
                                return buildPopularCard(item, context);
                              }).toList()),
                        )
                      : Center(
                          child: textStyle0_5(
                              text:
                                  "No Courses in this Category is Available"));
                }
              }),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.courseCat),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }

  Padding buildPopularCard(CoursesModel courseByCat, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p6, vertical: AppPadding.p4),
      child: InkWell(
        onTap: () {
          Get.toNamed(Paths.details, arguments: courseByCat);
          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailsScreen(coursesDetail: courseByCat, isWishlist: false)));
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
                              child: courseByCat.image != ''
                                  ? Image.network(courseByCat.image!,
                                      fit: BoxFit.fill)
                                  : Image.asset(AssetsManager.card,
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
                                  text: "\$${courseByCat.price.toString()}",
                                  color: ColorManager.whiteColor)),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0_5(text: courseByCat.name!),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0(
                    text: courseByCat.instructor!.name.toString(),
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
                            text: "Sections: ${courseByCat.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(
                            MediaQuery.of(context).size.width * 0.02),
                        textStyle0(text: courseByCat.rating.toString())
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
