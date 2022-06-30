import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/controllers/category_controller.dart';
import 'package:topgrade/controllers/courses_controller.dart';
import 'package:topgrade/controllers/my_courses_controller.dart';
import 'package:topgrade/controllers/searchController/searchController.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/models/searchModel.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/strings_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/category/categories_screen.dart';
import 'package:topgrade/views/screens/category/category_courses_screen.dart';
import 'package:topgrade/views/screens/home/widgets/PopularCourse.dart';
import 'package:topgrade/views/screens/instructor/instructors_screen.dart';
import 'package:topgrade/views/screens/popular/popular_courses_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchCourseController = Get.put(SearchController());
  List<SearchModel> popularCoursesModel = [];
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
              buildSpaceVertical(height * 0.02),
              buildTitle('Search Results'),
              // buildSpaceVertical(height * 0.01),
              Obx(() => searchCourseController.isLoading.value != null
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
                      itemCount: searchCourseController.coursesList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return PopularCourse(
                          argument:
                              searchCourseController.coursesList[index].id,
                          image:
                              searchCourseController.coursesList[index].image,
                          sectionslength: searchCourseController
                              .coursesList[index].sections!.length,
                          instructor: searchCourseController
                              .coursesList[index].instructor,
                          name: searchCourseController.coursesList[index].name,
                          price:
                              searchCourseController.coursesList[index].price,
                          rating:
                              searchCourseController.coursesList[index].rating,
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
              // if (title == "Categories") {
              //   // Get.toNamed(Paths.allCat);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => CategoriesScreen()));
              // } else if (title == "Popular Courses") {
              //   // Get.toNamed(Paths.allPopular);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const PopularCoursesScreen()));
              // } else if (title == "Search Results") {
              //   // Get.toNamed(Paths.alInstructor);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PopularCoursesScreen()));
            },
            // },
            child: textStyle0_5(text: StringsManager.seeAll)),
      ],
    );
  }

  // Row buildSearchAndFilterRow(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //         height: height * 0.06,
  //         width: width * 0.70,
  //         child: TextFormField(
  //           controller: searchController,
  //           validator: (value) {
  //             if (value == null || value.isEmpty) {
  //               return 'Please Enter Search Value}';
  //             }
  //             return null;
  //           },
  //           decoration: InputDecoration(
  //             enabledBorder: const OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
  //               borderSide: BorderSide(color: Colors.grey),
  //             ),
  //             focusedBorder: const OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
  //               borderSide: BorderSide(color: Colors.grey),
  //             ),
  //             errorBorder: const OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
  //               borderSide: BorderSide(color: ColorManager.redColor),
  //             ),
  //             focusedErrorBorder: const OutlineInputBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
  //               borderSide: BorderSide(color: ColorManager.redColor),
  //             ),
  //             hintText: StringsManager.search,
  //             fillColor: Colors.grey[200],
  //             hintStyle: const TextStyle(fontSize: AppSize.s16),
  //             filled: true,
  //             suffixIcon: InkWell(
  //               onTap:() async{
  //                 await searchCourseController.searchCourses(searchController.text);

  //               },
  //               child: const Icon(Icons.search)),
  //           ),
  //         ),
  //       ),
  //       buildSpaceHorizontal(width * 0.04),
  //       InkWell(
  //         onTap: () {
  //           showModalBottomSheet(
  //               context: context,
  //               isScrollControlled: true,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30)),
  //               builder: (context) {
  //                 return StatefulBuilder(
  //                     builder: (context, StateSetter customSetState) {
  //                   return const FilterSheet();
  //                 });
  //               });
  //         },
  //         child: Container(
  //           height: height * 0.05,
  //           width: width * 0.10,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(AppSize.s8),
  //             color: ColorManager.primaryColor,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.2),
  //                 spreadRadius: 3,
  //                 blurRadius: 2,
  //                 offset: const Offset(0, 3),
  //               ),
  //             ],
  //           ),
  //           child: const Icon(Icons.apps,
  //               color: ColorManager.whiteColor, size: 28),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
