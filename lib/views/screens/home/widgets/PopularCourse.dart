import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/routes/appPages.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';

class PopularCourse extends StatelessWidget {
  var argument;
  var image;
  var price;
  var name;
  var instructor;
  var sectionslength;
  var rating;
  PopularCourse({
    this.rating,
    this.sectionslength,
    this.instructor,
    this.name,
    this.price,
    this.image,
    this.argument,
  });

  double width = Get.width;
  double height = Get.height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            Paths.details,
            arguments: argument,
          );
        },
        child: Container(
          width: width * 0.50,
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
                  // height: height * 0.14,
                  width: width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: height * 0.12,
                          width: width,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s10),
                                  topRight: Radius.circular(AppSize.s10)),
                              child: Image.network(image, fit: BoxFit.cover)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.12,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )),
                          child: Center(
                            child: price != 0
                                ? textStyle0(
                                    text: "\$\ ${price.toString()}",
                                    color: ColorManager.whiteColor)
                                : textStyle0(
                                    text: " Free ",
                                    color: ColorManager.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: textStyle0_5(text: name),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                ),
                child: textStyle0(
                    text: instructor.toString(), color: ColorManager.grayColor),
              ),
              buildSpaceVertical(height * 0.01),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: height * 0.024,
                          // width: width * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                size: 16, color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(width * 0.02),
                        textStyle0(text: "Sections: ${sectionslength}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(width * 0.02),
                        textStyle0(text: rating.toString())
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
