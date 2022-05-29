


import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/my_courses_model.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import '../../../../helpers/helper.dart';
import '../../../../models/courses_model.dart';
import '../../../../models/wishlist_model.dart';

class Playlist extends StatelessWidget {
  final CoursesModel? coursesDetail;
  final DataItem? favCourseDetail;
  final MyCoursesModel? myCoursesModel;
  final bool isWishlist;
  final String isMyCourse;
  const Playlist({Key? key, this.coursesDetail, required this.isWishlist, this.favCourseDetail, this.myCoursesModel, required this.isMyCourse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWishlist ?
    favCourseDetail!.sections!.isNotEmpty ?
    ListView.builder(
        itemCount: favCourseDetail!.sections!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p16),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s16),
                  color: ColorManager.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                  child: textStyle0_5(text: favCourseDetail!.sections![index].title!),
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                  child: Text("Videos: ${favCourseDetail!.sections![index].items!.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                ),
                expanded: favCourseDetail!.sections![index].items!.isNotEmpty ?
                SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: ListView.builder(
                      itemCount: favCourseDetail!.sections![index].items!.length,
                      itemBuilder: (context, i){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                          child: Container(
                            height: 8.h,
                            width: 95.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.s16),
                                color: ColorManager.halfWhiteColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 4.h,
                                          width: 8.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(AppSize.s28),
                                              color: ColorManager.whiteColor
                                          ),
                                          child: Center(child: textStyle0_5(text: "${i+1}")),
                                        ),
                                        buildSpaceHorizontal(2.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(favCourseDetail!.sections![index].items![i].title!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                              favCourseDetail!.sections![index].items![i].duration != null ?
                                              textStyle00(text: favCourseDetail!.sections![index].items![i].duration!, color: ColorManager.grayColor)
                                              :const SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 4.h,
                                    width: 8.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s28),
                                        color: ColorManager.whiteColor
                                    ),
                                    child: const Icon(Icons.lock, color: ColorManager.redColor, size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                  ),
                )
                 : Center(child: textStyle0_5(text: "No Videos in this section")),
              ),
            ),
          );
        }
    )
    : Center(child: textStyle0_5(text: "No section available in this course"))
    :
    isMyCourse == "true" ?
    myCoursesModel!.sections!.isNotEmpty ?
    ListView.builder(
        itemCount: myCoursesModel!.sections!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                  child: textStyle0_5(text: myCoursesModel!.sections![index].title!),
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                  child: Text("Videos: ${myCoursesModel!.sections![index].items!.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                ),
                expanded: myCoursesModel!.sections![index].items!.isNotEmpty ?
                SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: ListView.builder(
                    itemCount: myCoursesModel!.sections![index].items!.length,
                    itemBuilder: (context, i){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(myCoursesModel!.sections![index].items![i].title!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            myCoursesModel!.sections![index].items![i].duration != null ?
                                            textStyle00(text: myCoursesModel!.sections![index].items![i].duration!.name.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: const Icon(Icons.lock, color: ColorManager.redColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Center(child: textStyle0_5(text: "No Videos in this section")),
              ),
            ),
          );
        }
    )
        : Center(child: textStyle0_5(text: "No section available in this course"))
    :
    coursesDetail!.sections!.isNotEmpty ?
    ListView.builder(
        itemCount: coursesDetail!.sections!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p6, left: AppPadding.p12),
                  child: textStyle0_5(text: coursesDetail!.sections![index].title!),
                ),
                collapsed: Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p6, left: AppPadding.p16),
                  child: Text("Videos: ${coursesDetail!.sections![index].items!.length} ", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                ),
                expanded: coursesDetail!.sections![index].items!.isNotEmpty ?
                SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: ListView.builder(
                    itemCount: coursesDetail!.sections![index].items!.length,
                    itemBuilder: (context, i){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p4, horizontal: AppPadding.p16),
                        child: Container(
                          height: 8.h,
                          width: 95.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color: ColorManager.halfWhiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSize.s28),
                                            color: ColorManager.whiteColor
                                        ),
                                        child: Center(child: textStyle0_5(text: "${i+1}")),
                                      ),
                                      buildSpaceHorizontal(2.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(coursesDetail!.sections![index].items![i].title!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                            coursesDetail!.sections![index].items![i].duration != null ?
                                            textStyle00(text: coursesDetail!.sections![index].items![i].duration!.name.toString(), color: ColorManager.grayColor)
                                                :const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s28),
                                      color: ColorManager.whiteColor
                                  ),
                                  child: const Icon(Icons.lock, color: ColorManager.redColor, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Center(child: textStyle0_5(text: "No Videos in this section")),
              ),
            ),
          );
        }
    )
        : Center(child: textStyle0_5(text: "No section available in this course"));
  }
}

//  color: Color.fromRGBO(10, 255, index * 10, 100),