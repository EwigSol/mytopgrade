
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/category/categories_screen.dart';
import 'package:topgrade/views/screens/details/details_screen.dart';
import 'package:topgrade/views/screens/instructor/instructors_screen.dart';
import 'package:topgrade/views/screens/popular/popular_courses_screen.dart';
import '../../../models/category_model.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../widgets/text_field.dart';
import 'package:get/get.dart';
import '../notification/notifications_screen.dart';
import 'widgets/filter_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  List<CategoryModel> categoryModel = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      categoryModel.add(CategoryModel(
          id: "1", icon: const Icon(Icons.design_services_rounded, color: ColorManager.lightPurpleColor), title: "Design", color: ColorManager.pinkColor));
      categoryModel.add(CategoryModel(
          id: "2", icon: const Icon(Icons.favorite, color: ColorManager.redColor), title: "Healthy", color: ColorManager.greenColor));
      categoryModel.add(CategoryModel(
          id: "3", icon: const Icon(Icons.announcement_rounded, color: ColorManager.pinkColor), title: "Marketing", color: ColorManager.lightPurpleColor));
      categoryModel.add(CategoryModel(
          id: "4", icon: const Icon(Icons.lightbulb, color: ColorManager.lightBlueColor), title: "Business", color: ColorManager.lightGreenColor));
      categoryModel.add(CategoryModel(
          id: "5", icon: const Icon(Icons.developer_mode_outlined ,color: ColorManager.lightPurpleColor), title: "Development", color: ColorManager.lightBlueColor));
      categoryModel.add(CategoryModel(
          id: "6", icon: const Icon(Icons.photo, color: ColorManager.greenColor), title: "Photography", color: ColorManager.lightPurpleColor));
      categoryModel.add(CategoryModel(
          id: "7", icon: const Icon(Icons.volunteer_activism, color: ColorManager.lightBlueColor), title: "LifeStyle", color: ColorManager.greenColor));
      categoryModel.add(CategoryModel(
          id: "8", icon: const Icon(Icons.music_note_rounded, color: ColorManager.pinkColor), title: "Music", color: ColorManager.lightBlueColor));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(7.h),
              buildAppBar(),
              buildSpaceVertical(5.h),
              buildSearchAndFilterRow(context),
              buildSpaceVertical(3.h),
              buildTitle(StringsManager.categories),
              buildSpaceVertical(2.h),
              SizedBox(
                height: 7.h,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: categoryModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final catModel = categoryModel[index];
                      return buildCategoryCard(catModel);
                    }),
              ),
              buildSpaceVertical(3.h),
              buildTitle(StringsManager.popular),
              buildSpaceVertical(2.h),
              SizedBox(
                height: 27.h,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildPopularCard();
                    }),
              ),
              buildSpaceVertical(3.h),
              buildTitle(StringsManager.instructor),
              buildSpaceVertical(2.h),
              SizedBox(
                height: 20.h,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: categoryModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final catM = categoryModel[index];
                      return buildInstructorCard(catM);
                    }),
              ),
              buildSpaceVertical(3.h),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildInstructorCard(CategoryModel catModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 48.w,
        decoration: BoxDecoration(
          color: catModel.color,
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 27.h,
              width: 20.w,
              child: Image.asset(AssetsManager.girl, fit: BoxFit.fill),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceVertical(3.h),
                textStyle0_5(text: "Albert Flores"),
                textStyle0(text: "LifeStyle", color: ColorManager.grayColor),
                textStyle0(text: "20k Students"),
                textStyle0(text: "17 Courses"),
                textStyle0(text: "(4.5)⭐"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildPopularCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          // Get.toNamed(Paths.details);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen()));
        },
        child: Container(
          width: 48.w,
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
                              child: Image.asset(AssetsManager.card,
                                  fit: BoxFit.fill)),
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
                              child: textStyle0_5(
                                  text: "\$50", color: ColorManager.whiteColor)),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0_5(text: "User Interface Design"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0(
                    text: "By Talent Tamer", color: ColorManager.grayColor),
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
                        textStyle0(text: "27 Videos")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(2.w),
                        textStyle0(text: "3.5")
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

  Padding buildCategoryCard(CategoryModel categoryModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: Container(
        width: 42.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s30),
          color: categoryModel.color,
        ),
        child: Row(
          children: [
            buildSpaceHorizontal(3.w),
            Container(
              height: 5.h,
              width: 10.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s30),
                color: ColorManager.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: categoryModel.icon,
            ),
            buildSpaceHorizontal(1.w),
            Expanded(child: textStyle0_5(text: categoryModel.title!)),
          ],
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
              if(title == "Categories"){
                // Get.toNamed(Paths.allCat);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesScreen()));
              }
              else if(title == "Popular Courses"){
                // Get.toNamed(Paths.allPopular);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PopularCoursesScreen()));
              }
              else if(title == "Best Instructors"){
                // Get.toNamed(Paths.alInstructor);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BestInstructorScreen()));
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
          height: 6.h,
          width: 70.w,
          child: TextFormField(
            controller: searchController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Search Value}';
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder:  const OutlineInputBorder(
                borderRadius: BorderRadius.all( Radius.circular(AppSize.s10)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all( Radius.circular(AppSize.s10)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              errorBorder : const OutlineInputBorder(
                borderRadius: BorderRadius.all( Radius.circular(AppSize.s10)),
                borderSide: BorderSide(color: ColorManager.redColor),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all( Radius.circular(AppSize.s10)),
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
        buildSpaceHorizontal(4.w),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                builder: (context) {
                  return StatefulBuilder(builder: (context, StateSetter customSetState) {
                    return const FilterSheet();
                  });
                });
          },
          child: Container(
            height: 5.h,
            width: 10.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s8),
              color: ColorManager.redColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child:
                const Icon(Icons.apps, color: ColorManager.whiteColor, size: 28),
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
            textStyle4(text: "Hi, Zain"),
            textStyle0_5(
                text: "Find a source you want to learn!",
                color: ColorManager.grayColor),
          ],
        ),
        InkWell(
          onTap: () {
            // Get.toNamed(Paths.notify);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
          },
          child: Container(
            height: 4.h,
            width: 8.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              color: ColorManager.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.notifications),
          ),
        ),
      ],
    );
  }
}
