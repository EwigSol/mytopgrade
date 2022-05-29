//
//
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:topgrade/helpers/helper.dart';
// import 'package:topgrade/utils/values_manager.dart';
// import 'package:topgrade/views/screens/courses/widgets/all_courses_screen.dart';
// import 'package:topgrade/views/screens/courses/widgets/completed_courses_screen.dart';
// import 'package:topgrade/views/screens/courses/widgets/upcoming_courses_screen.dart';
// import 'package:get/get.dart';
// import '../../../controllers/my_courses_controller.dart';
// import '../../../helpers/text_helper.dart';
// import '../../../utils/color_manager.dart';
// import '../../../utils/strings_manager.dart';
//
//
// class MyCoursesScreen extends StatefulWidget {
//   const MyCoursesScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MyCoursesScreen> createState() => _MyCoursesScreenState();
// }
//
// class _MyCoursesScreenState extends State<MyCoursesScreen> {
//   String? title;
//   int? selectedIndex;
//
//   final MyCoursesController myCoursesController = Get.put(MyCoursesController());
//
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       selectedIndex = 0;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.whiteColor,
//       appBar: buildAppBar(),
//       body: Column(
//         children: [
//           buildSpaceVertical(2.h),
//           SizedBox(
//             height: 6.h,
//             width: double.infinity,
//             child: ListView.builder(
//                 itemCount: 3,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   if(index == 0){
//                     title = StringsManager.all;
//                   }else if(index == 1){
//                     title = StringsManager.upComing;
//                   } else if(index == 2){
//                     title = StringsManager.completed;
//                   }
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           selectedIndex = index;
//                         });
//                       },
//                       child: Container(
//                         height: 5.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(AppSize.s22),
//                           color: selectedIndex == index ? ColorManager.redColor : ColorManager.whiteColor,
//                           border: Border.all(color: ColorManager.blackColor, width: 0.5),
//                         ),
//                         child: Row(
//                           children: [
//                             buildSpaceHorizontal(3.w),
//                             Container(
//                               height: 4.h,
//                               width: 8.w,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(AppSize.s30),
//                                 color: ColorManager.whiteColor,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 3,
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 3),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             buildSpaceHorizontal(3.w),
//                             textStyle1(text: title!, color: selectedIndex == index ? ColorManager.whiteColor : ColorManager.blackColor),
//                             buildSpaceHorizontal(2.w),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//             ),
//           ),
//           Expanded(
//               child: selectedIndex == 0 ? AllCoursesScreen() : selectedIndex == 1 ? const UpComingCoursesScreen() : const CompletedCoursesScreen()
//           ),
//           buildSpaceVertical(5.h),
//         ],
//       ),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       title: textStyle2(text: StringsManager.myCourse),
//       centerTitle: true,
//       backgroundColor: ColorManager.whiteColor,
//       elevation: 0.5,
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:topgrade/models/my_courses_model.dart';
import '../../../controllers/my_courses_controller.dart';
import '../../../helpers/helper.dart';
import '../../../helpers/text_helper.dart';
import '../../../routes/appPages.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../../../utils/values_manager.dart';


class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {

  var myCoursesController = Get.put(MyCoursesController());

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
              buildSpaceVertical(5.h),
              Obx((){
                if(myCoursesController.isLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  return myCoursesController.myCoursesList.isNotEmpty ?
                  Center(
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        runSpacing: 10,
                        alignment: WrapAlignment.spaceEvenly,
                        children: myCoursesController.myCoursesList.map((item) {
                          return buildMyCoursesCard(item);
                        }).toList()
                    ),
                  )
                      : Center(child: textStyle0_5(text: "No My Course Available"));
                }
              }),
              buildSpaceVertical(5.h),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.myCourse),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }

  Padding buildMyCoursesCard(MyCoursesModel myCoursesModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6, vertical: AppPadding.p10),
      child: InkWell(
        onTap: () {
          Get.toNamed(Paths.details, arguments: myCoursesModel, parameters: {'isMyCourse': "true"});
          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailsScreen(favCourseDetail: wishlistModel, isWishlist: true)));
        },
        child: Container(
          width: 44.w,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.s10),
                topRight: Radius.circular(AppSize.s10),
                bottomLeft: Radius.circular(AppSize.s10),
                bottomRight: Radius.circular(AppSize.s10)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
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
                              child: Image.network(myCoursesModel.image!, fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 4.h,
                          width: 16.w,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s16),
                                bottomLeft: Radius.circular(AppSize.s16),
                              )),
                          child: Center(
                              child: textStyle0_5(text: "\$${myCoursesModel.price.toString()}", color: ColorManager.whiteColor)),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0_5(text: myCoursesModel.name!),
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4),
                child: textStyle0(text: myCoursesModel.instructor!.name.toString(), color: ColorManager.grayColor),
              ),
              buildSpaceVertical(2.h),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p4, right: AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 3.h,
                          width: 7.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.list, color: ColorManager.whiteColor, size: 22),
                          ),
                        ),
                        buildSpaceHorizontal(1.w),
                        textStyle0(text: "Sections: ${myCoursesModel.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(2.w),
                        textStyle0(text: myCoursesModel.rating.toString())
                      ],
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(1.h),
            ],
          ),
        ),
      ),
    );
  }
}
