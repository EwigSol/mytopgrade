import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytopgrade/controllers/InProgressController.dart';
import 'package:mytopgrade/controllers/my_all_courses_controller.dart';
import 'package:mytopgrade/controllers/wishlist_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/helpers/text_helper.dart';
import 'package:mytopgrade/models/courses_model.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:mytopgrade/views/screens/details/details_screen.dart';

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
  final WishlistController wishlistController = Get.put(WishlistController());
  final InProgressController inProgressController =
      Get.put(InProgressController());
  final MyAllCoursesController myAllCoursesController =
      Get.put(MyAllCoursesController());
  double width = Get.width;
  double height = Get.height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: InkWell(
        onTap: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    // color: Colors.white.withOpacity(10),
                    height: 200,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Loading Data Hold Tight!',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                );
              });
          await wishlistController.fetchWishlist();
          await myAllCoursesController.fetchMyCourses();
          await inProgressController.fetchMyCourses();
          Navigator.of(context, rootNavigator: true).pop();
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
                  height: height * 0.11,
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
                              child: image != null
                                  ? Image.network(image, fit: BoxFit.fitWidth)
                                  : Image.asset('/assets/images/logo.png')),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.18,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )),
                          child: Center(
                            child: price != 0
                                ? Text(
                                    '\NGN\ ${price.toString()}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  )
                                : const Text(
                                    'Free',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 5),
                child: Text(
                  name,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                ),
                child: Text(
                  instructor.toString(),
                  style: const TextStyle(
                      color: ColorManager.grayColor, fontSize: 12),
                ),
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
                          height: height * 0.020,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                size: 16, color: ColorManager.whiteColor),
                          ),
                        ),
                        buildSpaceHorizontal(width * 0.02),
                        Text(
                          "Sections: ${sectionslength}",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        // textStyle0(text: "Sections: ${sectionslength}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "⭐",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        buildSpaceHorizontal(width * 0.01),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
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
