// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:mytopgrade/helpers/helper.dart';
// import 'package:mytopgrade/routes/appPages.dart';
// import 'package:mytopgrade/utils/values_manager.dart';
//
// import '../../../helpers/text_helper.dart';
// import '../../../utils/color_manager.dart';
// import '../../../utils/strings_manager.dart';
// import '../../widgets/text_field.dart';
// import 'package:get/get.dart';
//
// class ChatListScreen extends StatefulWidget {
//   const ChatListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatListScreen> createState() => _ChatListScreenState();
// }
//
// class _ChatListScreenState extends State<ChatListScreen> {
//   final searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.whiteColor,
//       appBar: buildAppBar(),
//       body: Column(
//         children: [
//           buildSpaceVertical(2.h),
//           Center(
//             child: SizedBox(
//               height: 7.h,
//               width: 90.w,
//               child: CustomTextField(
//                 controller: searchController,
//                 hintName: StringsManager.search,
//               ),
//             ),
//           ),
//           buildSpaceVertical(3.h),
//           SizedBox(
//             height: 67.h,
//             width: 100.w,
//             child: ListView.separated(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return buildChatCard();
//               },
//               separatorBuilder: (context, index) {
//                 return const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
//                   child: Divider(
//                     color: ColorManager.grayColor,
//                     thickness: 0.5,
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   InkWell buildChatCard() {
//     return InkWell(
//       onTap: () {
//         Get.toNamed(Paths.chat);
//       },
//       child: SizedBox(
//         height: 10.h,
//         width: 100.w,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     height: 7.h,
//                     width: 7.h,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(AppSize.s30),
//                         color: ColorManager.pinkColor),
//                     child: const Icon(Icons.person_sharp),
//                   ),
//                   buildSpaceHorizontal(3.w),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       textStyle1(text: "Wade Warren"),
//                       textStyle00(text: "Hello Sir i need a design course ...")
//                     ],
//                   ),
//                 ],
//               ),
//               textStyle00(text: "1 min ")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       title: textStyle2(text: StringsManager.chat),
//       centerTitle: true,
//       backgroundColor: ColorManager.whiteColor,
//       elevation: 0.5,
//     );
//   }
// }
