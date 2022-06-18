import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/controllers/category_controller.dart';
import 'package:topgrade/controllers/courses_controller.dart';
import 'package:topgrade/controllers/my_courses_controller.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/category/categories_screen.dart';
import 'package:topgrade/views/screens/category/category_courses_screen.dart';
import 'package:topgrade/views/screens/instructor/instructors_screen.dart';
import 'package:topgrade/views/screens/popular/popular_courses_screen.dart';
import 'widgets/filter_sheet.dart';
import 'package:get/get.dart';

import 'widgets/PopularCourse.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final CoursesController popularCoursesController =
      Get.put(CoursesController());
  final CategoryController categoryController = Get.put(CategoryController());
  var myCoursesController = Get.put(MyCoursesController());
  final CoursesController coursesController = Get.put(CoursesController());
  List<CoursesModel> popularCoursesModel = [];
  final box = GetStorage();
  List<String> myCoursesId = [];
  String? name;
  double height = Get.height;
  double width = Get.width;

  @override
  void initState() {
    super.initState();
    myCoursesId.clear();
    // popularCoursesModel.clear();
    name = box.read("user_display_name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(height * 0.07),
              buildAppBar(),
              buildSpaceVertical(height * 0.03),
              buildSearchAndFilterRow(context),
              buildSpaceVertical(height * 0.02),
              buildTitle(StringsManager.categories),
              buildSpaceVertical(height * 0.02),
              Obx(() {
                if (categoryController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  for (int i = 0;
                      i < myCoursesController.myCoursesList.length;
                      i++) {
                    myCoursesId.add(
                        myCoursesController.myCoursesList[i].id.toString());
                    box.write("myCoursesId", myCoursesId);
                  }

                  return categoryController.catList.isNotEmpty
                      ? SizedBox(
                          height: height * 0.07,
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: categoryController.catList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final catModel =
                                    categoryController.catList[index];
                                return buildCategoryCard(catModel, index);
                              }),
                        )
                      : SizedBox(
                          height: height * 0.07,
                          width: double.infinity,
                          child: Center(
                              child:
                                  textStyle0_5(text: "No Category Available")));
                }
              }),
              buildSpaceVertical(height * 0.02),
              buildTitle(StringsManager.popular),
              buildSpaceVertical(height * 0.01),
              Obx(() {
                if (popularCoursesController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  for (int i = 0;
                      i < popularCoursesController.coursesList.length;
                      i++) {
                    if (popularCoursesController.coursesList[i].rating! >= 3) {
                      popularCoursesModel
                          .add(popularCoursesController.coursesList[i]);
                    }
                  }
                  return popularCoursesModel.isNotEmpty
                      ? SizedBox(
                          height: height * 0.23,
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: popularCoursesModel.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return PopularCourse(
                                  argument: popularCoursesModel[index].id,
                                  image: popularCoursesModel[index].image,
                                  sectionslength: popularCoursesModel[index]
                                      .sections!
                                      .length,
                                  instructor:
                                      popularCoursesModel[index].instructor,
                                  name: popularCoursesModel[index].name,
                                  price: popularCoursesModel[index].price,
                                  rating: popularCoursesModel[index].rating,
                                );
                              }),
                        )
                      : SizedBox(
                          height: height * 0.22,
                          width: double.infinity,
                          child: Center(
                              child: textStyle0_5(
                                  text: "No Popular Courses Available")));
                }
              }),
              buildSpaceVertical(height * 0.02),
              buildTitle('All Courses'),
              // buildSpaceVertical(height * 0.01),
              Obx(() => coursesController.isLoading.value != null
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
                      itemCount: coursesController.coursesList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return PopularCourse(
                          argument: coursesController.coursesList[index].id,
                          image: coursesController.coursesList[index].image,
                          sectionslength: coursesController
                              .coursesList[index].sections!.length,
                          instructor:
                              coursesController.coursesList[index].instructor,
                          name: coursesController.coursesList[index].name,
                          price: coursesController.coursesList[index].price,
                          rating: coursesController.coursesList[index].rating,
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
              buildSpaceVertical(height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCategoryCard(CategoriesModel categoryModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () {
          Get.to(() => CategoryCoursesScreen(id: categoryModel.id.toString()));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.primaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: textStyle0_5(
                    text: categoryModel.name!, color: ColorManager.whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textStyle0_5(text: title),
        InkWell(
            onTap: () {
              if (title == "Categories") {
                // Get.toNamed(Paths.allCat);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoriesScreen()));
              } else if (title == "Popular Courses") {
                // Get.toNamed(Paths.allPopular);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PopularCoursesScreen()));
              } else if (title == "All Courses") {
                // Get.toNamed(Paths.alInstructor);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PopularCoursesScreen()));
              }
            },
            child: textStyle0_5(text: StringsManager.seeAll)),
      ],
    );
  }

  Row buildSearchAndFilterRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.06,
          width: width * 0.70,
          child: TextFormField(
            controller: searchController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Search Value}';
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                borderSide: BorderSide(color: ColorManager.redColor),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                borderSide: BorderSide(color: ColorManager.redColor),
              ),
              hintText: StringsManager.search,
              fillColor: Colors.grey[200],
              hintStyle: const TextStyle(fontSize: AppSize.s16),
              filled: true,
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        buildSpaceHorizontal(width * 0.04),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                builder: (context) {
                  return StatefulBuilder(
                      builder: (context, StateSetter customSetState) {
                    return const FilterSheet();
                  });
                });
          },
          child: Container(
            height: height * 0.05,
            width: width * 0.10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s8),
              color: ColorManager.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.apps,
                color: ColorManager.whiteColor, size: 28),
          ),
        ),
      ],
    );
  }

  Row buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textStyle4(text: "Hi, $name"),
            textStyle0_5(
                text: "Find a source you want to learn!",
                color: ColorManager.grayColor),
          ],
        ),
        // InkWell(
        //   onTap: () {
        //     // Get.toNamed(Paths.notify);
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
        //   },
        //   child: Container(
        //     height: height * 0.04,
        //     width: width * 0.08,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(AppSize.s10),
        //       color: ColorManager.whiteColor,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.5),
        //           spreadRadius: 3,
        //           blurRadius: 4,
        //           offset: const Offset(0, 3),
        //         ),
        //       ],
        //     ),
        //     child: const Icon(Icons.notifications),
        //   ),
        // ),
      ],
    );
  }
}
