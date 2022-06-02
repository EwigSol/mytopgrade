import 'package:flutter/material.dart';
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
  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              buildSpaceVertical(height * 0.05),
              Obx(() {
                if (myCoursesController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return myCoursesController.myCoursesList.isNotEmpty
                      ? Center(
                          child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 5,
                              runSpacing: 10,
                              alignment: WrapAlignment.spaceEvenly,
                              children:
                                  myCoursesController.myCoursesList.map((item) {
                                return buildMyCoursesCard(item);
                              }).toList()),
                        )
                      : Center(
                          child: textStyle0_5(text: "No My Course Available"));
                }
              }),
              buildSpaceVertical(height * 0.05),
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: InkWell(
        onTap: () {
          Get.toNamed(Paths.details,
              arguments: myCoursesModel, parameters: {'isMyCourse': "true"});
        },
        child: Container(
          width: width * 0.44,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
                  height: height * 0.14,
                  width: width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: height * 0.14,
                          width: width,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.network(myCoursesModel.image!,
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: height * 0.04,
                          width: width * 0.16,
                          decoration: const BoxDecoration(
                              color: ColorManager.redColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              )),
                          child: Center(
                            child: myCoursesModel.price != 0
                                ? textStyle0_5(
                                    text:
                                        "\$${myCoursesModel.price.toString()}",
                                    color: ColorManager.whiteColor)
                                : textStyle0_5(
                                    text: "Free",
                                    color: ColorManager.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: textStyle0_5(text: myCoursesModel.name!),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: textStyle0(
                    text: myCoursesModel.instructor!.name.toString(),
                    color: ColorManager.grayColor),
              ),
              buildSpaceVertical(height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          // height: height * 0.03,
                          // width: width * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.redColor),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                color: ColorManager.whiteColor, size: 22),
                          ),
                        ),
                        buildSpaceHorizontal(width * 0.01),
                        textStyle0(
                            text:
                                "Sections: ${myCoursesModel.sections!.length}")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textStyle0(text: "⭐"),
                        buildSpaceHorizontal(width * 0.02),
                        textStyle0(text: myCoursesModel.rating.toString())
                      ],
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }
}
