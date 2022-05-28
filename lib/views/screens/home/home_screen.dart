
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:topgrade/views/screens/category/categories_screen.dart';
import 'package:topgrade/views/screens/details/details_screen.dart';
import 'package:topgrade/views/screens/instructor/instructors_screen.dart';
import 'package:topgrade/views/screens/popular/popular_courses_screen.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/courses_controller.dart';
import '../../../routes/appPages.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/strings_manager.dart';
import '../category/category_courses_screen.dart';
import '../notification/notifications_screen.dart';
import 'widgets/filter_sheet.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final CoursesController popularCoursesController = Get.put(CoursesController());
  final CategoryController categoryController = Get.put(CategoryController());
  List<CoursesModel> popularCoursesModel = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(7.h),
              buildAppBar(),
              buildSpaceVertical(3.h),
              buildSearchAndFilterRow(context),
              buildSpaceVertical(2.h),
              buildTitle(StringsManager.categories),
              buildSpaceVertical(2.h),
              Obx((){
                if(categoryController.isLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  return categoryController.catList.isNotEmpty ?
                  SizedBox(
                    height: 7.h,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: categoryController.catList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final catModel = categoryController.catList[index];
                          return buildCategoryCard(catModel, index);
                        }),
                  )
                    : SizedBox(
                      height: 7.h,
                      width: double.infinity,
                      child: Center(child: textStyle0_5(text: "No Category Available"))
                  );
                }
              }),

              buildSpaceVertical(2.h),
              buildTitle(StringsManager.popular),
              buildSpaceVertical(1.h),
              Obx((){
                if(popularCoursesController.isLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  for(int i=0; i<popularCoursesController.coursesList.length; i++){
                    if(popularCoursesController.coursesList[i].rating! >= 3 ){
                      popularCoursesModel.clear();
                      popularCoursesModel.add(popularCoursesController.coursesList[i]);
                    }
                  }
                  return popularCoursesModel.isNotEmpty ?
                  SizedBox(
                    height: 23.h,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: popularCoursesModel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildPopularCard(popularCoursesModel[index]);
                        }),
                  )
                  : SizedBox(
                      height: 22.h,
                      width: double.infinity,
                      child: Center(child: textStyle0_5(text: "No Popular Courses Available"))
                  );
                }
              }),
              buildSpaceVertical(2.h),
              buildTitle(StringsManager.instructor),
              buildSpaceVertical(1.h),
              Obx((){
                if(popularCoursesController.isLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  return popularCoursesController.coursesList.isNotEmpty ?
                  SizedBox(
                    height: 15.h,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: popularCoursesController.coursesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final catM = popularCoursesController.coursesList[index];
                          return buildInstructorCard(catM);
                        }),
                  )
                      : SizedBox(
                      height: 17.h,
                      width: double.infinity,
                      child: Center(child: textStyle0_5(text: "No Instructor Available"))
                  );
                }
              }),
              buildSpaceVertical(3.h),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildInstructorCard(CoursesModel catModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4, vertical: AppPadding.p4),
      child: Container(
        width: 60.w,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(AppSize.s10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            buildSpaceHorizontal(2.w),
            catModel.instructor!.avatar != '' ?
            CircleAvatar(
              radius: 35,
              backgroundColor: ColorManager.whiteColor,
              backgroundImage: NetworkImage(catModel.instructor!.avatar!),
            )
            :
            const CircleAvatar(
              radius: 35,
              backgroundColor: ColorManager.whiteColor,
              backgroundImage: AssetImage(AssetsManager.girl),
            ),
            buildSpaceHorizontal(2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpaceVertical(2.h),
                  Text(catModel.instructor!.name!.name, maxLines: 3, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  buildSpaceVertical(1.h),
                  Flexible(
                    child: Text(catModel.instructor!.description!, maxLines: 5, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: ColorManager.grayColor),),
                  ),
                ],
              ),
            ),

          ],
        ),
      //  Row(
        //           children: [
        //             SizedBox(
        //               height: 18.h,
        //               width: 18.w,
        //               child: catModel.instructor!.avatar != '' ?
        //               Image.network(catModel.instructor!.avatar!, fit: BoxFit.fill) :
        //               Image.asset(AssetsManager.girl, fit: BoxFit.fill),
        //             ),
        //             buildSpaceHorizontal(1.w),
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   buildSpaceVertical(3.h),
        //                   Flexible(
        //                     child: Text(catModel.instructor!.name!.name, maxLines: 3, overflow: TextOverflow.ellipsis,
        //                       style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
        //                   ),
        //                   buildSpaceVertical(1.h),
        //                   Flexible(
        //                     child: Text(catModel.instructor!.description!, maxLines: 5, overflow: TextOverflow.ellipsis,
        //                       style: const TextStyle(fontSize: 11, color: ColorManager.grayColor),),
        //                   ),
        //                   // textStyle0(text: "LifeStyle", color: ColorManager.grayColor),
        //                   // textStyle0(text: "20k Students"),
        //                   // textStyle0(text: "17 Courses"),
        //                   // textStyle0(text: "(4.5)⭐"),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
      ),
    );
  }

  Padding buildPopularCard(CoursesModel popularCourse) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: (){
          Get.toNamed(Paths.details, arguments: popularCourse);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(coursesDetail: popularCourse, isWishlist: false)));
        },
        child: Container(
          width: 60.w,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 12.h,
                  width: 100.w,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s10),
                                  topRight: Radius.circular(AppSize.s10)),
                              child: Image.network(popularCourse.image!, fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: 3.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s16),
                                bottomLeft: Radius.circular(AppSize.s16),
                              )),
                          child: Center(
                              child: textStyle0(text: "\$${popularCourse.price.toString()}", color: ColorManager.whiteColor)),
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
                child: textStyle0(text: popularCourse.instructor!.name.toString(), color: ColorManager.grayColor),
              ),
              buildSpaceVertical(1.h),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4, right: AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 2.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill, size: 16, color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(2.w),
                        textStyle0(text: "Sections: ${popularCourse.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(2.w),
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

  Padding buildCategoryCard(CategoriesModel categoryModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoryCoursesScreen(id: categoryModel.id.toString())));
        },
        child: Container(
          width: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s20),
            color: ColorManager.primaryColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // buildSpaceHorizontal(3.w),
              // Container(
              //   height: 5.h,
              //   width: 10.w,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(AppSize.s30),
              //     color: ColorManager.whiteColor,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 3,
              //         blurRadius: 4,
              //         offset: const Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child: const Icon(Icons.lightbulb, color: ColorManager.primaryColor),
              // ),
              // buildSpaceHorizontal(2.w),
              textStyle0_5(text: categoryModel.name!, color: ColorManager.whiteColor),
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
              if(title == "Categories"){
                // Get.toNamed(Paths.allCat);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoriesScreen()));
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
