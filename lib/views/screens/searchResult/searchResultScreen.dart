import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/controllers/searchController/searchController.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/helpers/text_helper.dart';
import 'package:mytopgrade/models/category_model.dart';
import 'package:mytopgrade/models/searchModel.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/strings_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:mytopgrade/views/screens/category/category_courses_screen.dart';
import 'package:mytopgrade/views/screens/home/widgets/PopularCourse.dart';
import 'package:mytopgrade/views/screens/popular/popular_courses_screen.dart';
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
      ],
    );
  }
}
