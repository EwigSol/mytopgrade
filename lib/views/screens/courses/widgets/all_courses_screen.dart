//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../controllers/courses_controller.dart';
// import '../../../../helpers/helper.dart';
// import '../../../../helpers/text_helper.dart';
// import '../../../../models/courses_model.dart';
// import '../../../../routes/appPages.dart';
// import '../../../../utils/color_manager.dart';
// import '../../../../utils/values_manager.dart';
//
// class AllCoursesScreen extends StatelessWidget {
//   AllCoursesScreen({Key? key}) : super(key: key);
//
//   final CoursesController coursesController = Get.put(CoursesController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
//         child: Column(
//           children: [
//             buildSpaceVertical(5.h),
//             Obx(() {
//               if(coursesController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               } else {
//                 return coursesController.coursesList.isNotEmpty ?
//                 Center(
//                   child: Wrap(
//                       direction: Axis.horizontal,
//                       spacing: 5,
//                       runSpacing: 10,
//                       alignment: WrapAlignment.spaceEvenly,
//                       children: coursesController.coursesList.map((item) {
//                         return buildCoursesCard(item, context);
//                       }).toList()
//                   ),
//                 )
//                 : Center(child: textStyle0_5(text: "No Courses Available"));
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Padding buildCoursesCard(CoursesModel coursesModel, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6, vertical: AppPadding.p10),
//       child: InkWell(
//         onTap: () {
//           Get.toNamed(Paths.details, arguments: coursesModel);
//           // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(coursesDetail: coursesModel, isWishlist: false)));
//         },
//         child: Container(
//           width: 44.w,
//           decoration: const BoxDecoration(
//             color: ColorManager.whiteColor,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(AppSize.s10),
//                 topRight: Radius.circular(AppSize.s10)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                   height: 14.h,
//                   width: 100.w,
//                   child: Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           height: 14.h,
//                           width: 100.w,
//                           child: ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(AppSize.s10),
//                                   topRight: Radius.circular(AppSize.s10)),
//                               child: Image.network(coursesModel.image!, fit: BoxFit.fill)),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 4,
//                         right: 0,
//                         child: Container(
//                           height: 4.h,
//                           width: 12.w,
//                           decoration: const BoxDecoration(
//                               color: ColorManager.redColor,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(AppSize.s16),
//                                 bottomLeft: Radius.circular(AppSize.s16),
//                               )),
//                           child: Center(
//                               child: textStyle0(text: "\$${coursesModel.price.toString()}", color: ColorManager.whiteColor)),
//                         ),
//                       ),
//                     ],
//                   )),
//               Padding(
//                 padding: const EdgeInsets.only(left: AppPadding.p4),
//                 child: textStyle0_5(text: coursesModel.name!),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: AppPadding.p4),
//                 child: textStyle0(text: coursesModel.instructor!.name.toString(), color: ColorManager.grayColor),
//               ),
//               buildSpaceVertical(2.h),
//               Padding(
//                 padding: const EdgeInsets.only(left: AppPadding.p4, right: AppPadding.p4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     textStyle00(text: "Sections: ${coursesModel.sections!.length}"),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         textStyle0(text: "⭐"),
//                         buildSpaceHorizontal(2.w),
//                         textStyle0(text: coursesModel.rating.toString())
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
