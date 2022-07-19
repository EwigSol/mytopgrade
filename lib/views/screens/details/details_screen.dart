// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytopgrade/controllers/StartCourseController.dart';
import 'package:mytopgrade/controllers/add_favorite_controller.dart';
import 'package:mytopgrade/controllers/cart_controller.dart';
import 'package:mytopgrade/controllers/course_byId_controller.dart';
import 'package:mytopgrade/controllers/my_all_courses_controller.dart';
import 'package:mytopgrade/controllers/payment_gateway_controller.dart';
import 'package:mytopgrade/controllers/wishlist_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/helpers/text_helper.dart';
import 'package:mytopgrade/models/course_by_id_model.dart';
import 'package:mytopgrade/models/courses_model.dart';
import 'package:mytopgrade/models/my_courses_model.dart';
import 'package:mytopgrade/models/payment_gateway_model.dart';
import 'package:mytopgrade/models/wishlist_model.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:mytopgrade/views/screens/details/widgets/instructor_screen.dart';
import '../../../controllers/my_courses_controller.dart';
import 'widgets/description_screen.dart';
import 'package:get/get.dart';
import 'widgets/payment_sheet.dart';
import 'widgets/playlist_screen.dart';

class DetailsScreen extends StatefulWidget {
  CoursesModel? coursesDetail;
  MyCoursesModel? myCoursesModel;
  DataItem? favCourseDetail;
  bool isWishlist;
  DetailsScreen(
      {Key? key,
      this.coursesDetail,
      this.favCourseDetail,
      required this.isWishlist})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final CartController cartController = Get.put(CartController());
  final AddFavoriteController addFavController =
      Get.put(AddFavoriteController());
  final WishlistController wishlistController = Get.put(WishlistController());
  final PaymentGatewayController paymentGatewayController =
      Get.put(PaymentGatewayController());
  final CourseByIDController courseByIDController =
      Get.put(CourseByIDController());
  final MyCoursesController myCourseController = Get.put(MyCoursesController());
  final MyAllCoursesController myAllCoursesController =
      Get.put(MyAllCoursesController());
  final StartCourseController startCourseController =
      Get.put(StartCourseController());
  List<PaymentGatewayModel> paymentGatewayModel = [];
  List<MyCoursesModel> myCourseModel = [];
  CourseByIdModel? courseByIdModel;
  WishlistModel? wishlistModel;
  final box = GetStorage();
  List<String> myCoursesId = [];
  bool isPaid = false;
  bool isLocked = true;
  bool isPressed = false;
  String? isMyCourse;
  double width = Get.width;
  double height = Get.height;
  bool inWishlist = false;
  bool isLoading = false;
  bool isStarted = true;
  var courseId;

  @override
  void initState() {
    courseId = Get.arguments;
    super.initState();
    checkCourseStarted();
    checkWishlist();
    initalize();
  }

  initalize() async {
    var data = Get.arguments;

    var _courseByIdModel =
        await courseByIDController.fetchCourseByID(data.toString());
    setState(() {
      courseByIdModel = _courseByIdModel;
    });

    for (int i = 0; i < myCourseController.myCoursesList.length; i++) {
      if (data == myCourseController.myCoursesList.value[i].id) {
        setState(() {
          isPaid = true;
        });
      }
    }
    cartController.open();
    _controller = TabController(length: 3, vsync: this);
  }

  checkWishlist() async {
    var data = Get.arguments;
    wishlistModel = await wishlistController.fetchWishlist();
    setState(() {});
    for (int i = 0;
        i < wishlistController.wishlist.value!.data!.items!.length;
        i++) {
      if (data == wishlistController.wishlist.value!.data!.items![i].id) {
        setState(() {
          inWishlist = true;
        });
      }
    }
    Future.delayed(const Duration(seconds: 3))
        .then(((value) => setState(() {})));
    // setState(() {
    //   isLoading = true;
    // });
  }

  checkCourseStarted() async {
    var data = Get.arguments;
    print(data);
    myCourseModel = (await myAllCoursesController.fetchMyCourses());
    setState(() {});
    for (int i = 0;
        i < myAllCoursesController.myCoursesList.value.length;
        i++) {
      print(myAllCoursesController.myCoursesList.value[i].id);
      if (data == myAllCoursesController.myCoursesList.value[i].id) {
        setState(() {
          isStarted = false;
        });
        break;
      } else {
        // setState(() {
        //   isStarted = true;
        // });
      }
    }
    Future.delayed(const Duration(seconds: 3))
        .then(((value) => setState(() {})));
    setState(() {
      isLoading = true;
    });
  }

  // checkPayment() {
  //   if (myCoursesId.isNotEmpty) {
  //     if (widget.isWishlist == true) {
  //       for (int i = 0; i < myCoursesId.length; i++) {
  //         if (widget.favCourseDetail!.id.toString() == myCoursesId[i]) {
  //           setState(() {
  //             isPaid = false;
  //           });
  //         }
  //       }
  //     } else if (isMyCourse == "true") {
  //       for (int i = 0; i < myCoursesId.length; i++) {
  //         if (widget.myCoursesModel!.id.toString() == myCoursesId[i]) {
  //           setState(() {
  //             isPaid = false;
  //           });
  //         }
  //       }
  //     } else {
  //       for (int i = 0; i < myCoursesId.length; i++) {
  //         if (widget.coursesDetail!.id.toString() == myCoursesId[i]) {
  //           setState(() {
  //             isPaid = false;
  //           });
  //         }
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return courseByIDController.isLoading.value
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            backgroundColor: ColorManager.whiteColor,
            appBar: buildAppBar(courseByIdModel!.name!),
            body: widget.isWishlist
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.01),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.28,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft:
                                                Radius.circular(AppSize.s10),
                                            topRight:
                                                Radius.circular(AppSize.s10),
                                            bottomLeft:
                                                Radius.circular(AppSize.s10),
                                            bottomRight:
                                                Radius.circular(AppSize.s10)),
                                        child: Image.network(
                                            widget.favCourseDetail!.image!,
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 20,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.13,
                                    decoration: const BoxDecoration(
                                        color: ColorManager.redColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(AppSize.s10),
                                          bottomLeft:
                                              Radius.circular(AppSize.s10),
                                          topRight:
                                              Radius.circular(AppSize.s10),
                                          bottomRight:
                                              Radius.circular(AppSize.s10),
                                        )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textStyle0(
                                            text: "Price",
                                            color: ColorManager.whiteColor),
                                        textStyle0(
                                            text:
                                                "\NGN\ ${widget.favCourseDetail!.price.toString()}",
                                            color: ColorManager.whiteColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.01),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.85,
                                child: Text(
                                  courseByIdModel!.name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 28),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: AppPadding.p34),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        Text(
                                          courseByIdModel!.rating!.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 16),
                                        ),
                                        buildSpaceHorizontal(
                                            MediaQuery.of(context).size.height *
                                                0.005),
                                        const Text(
                                          "⭐",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 32.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Course Sections : ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "${courseByIdModel!.sections!.length}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildSpaceVertical(
                            MediaQuery.of(context).size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p6,
                              horizontal: AppPadding.p22),
                          child: TabBar(
                            isScrollable: true,
                            indicator: BoxDecoration(
                                color: ColorManager.redColor,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s22)),
                            controller: _controller,
                            unselectedLabelColor: ColorManager.blackColor,
                            unselectedLabelStyle:
                                const TextStyle(color: ColorManager.blackColor),
                            tabs: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Tab(
                                    child: Text(
                                      "Overview",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Tab(
                                    child: Text(
                                      "Curriculum",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  child: Tab(
                                    child: Text(
                                      "Instructor",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              OverviewScreen(
                                  favCourseDetail: widget.favCourseDetail,
                                  isWishlist: true,
                                  isMyCourse: "false"),
                              Playlist(
                                  // courseByIdModel: courseByIdModel,
                                  courseId: courseId,
                                  favCourseDetail: widget.favCourseDetail,
                                  isWishlist: true,
                                  isMyCourse: "false",
                                  isLocked: isPressed ? false : true),
                              InstructorScreen(
                                  favCourseDetail: widget.favCourseDetail,
                                  isWishlist: true,
                                  isMyCourse: "false"),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : isMyCourse == "true"
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSpaceVertical(
                                MediaQuery.of(context).size.height * 0.01),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.90,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        AppSize.s10),
                                                    topRight: Radius.circular(
                                                        AppSize.s10),
                                                    bottomLeft: Radius.circular(
                                                        AppSize.s10),
                                                    bottomRight:
                                                        Radius.circular(
                                                            AppSize.s10)),
                                            child: Image.network(
                                                widget.myCoursesModel!.image!,
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 20,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        decoration: const BoxDecoration(
                                            color: ColorManager.redColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(AppSize.s10),
                                              bottomLeft:
                                                  Radius.circular(AppSize.s10),
                                              topRight:
                                                  Radius.circular(AppSize.s10),
                                              bottomRight:
                                                  Radius.circular(AppSize.s10),
                                            )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            textStyle0(
                                                text: "Price",
                                                color: ColorManager.whiteColor),
                                            textStyle0(
                                                text:
                                                    "\NGN\ ${widget.myCoursesModel!.price.toString()}",
                                                color: ColorManager.whiteColor),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            buildSpaceVertical(
                                MediaQuery.of(context).size.height * 0.01),
                            buildSpaceVertical(
                                MediaQuery.of(context).size.height * 0.02),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: width * 0.85,
                                    child: Text(
                                      courseByIdModel!.name!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 28),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p34),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005),
                                            Text(
                                              courseByIdModel!.rating!
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 16),
                                            ),
                                            buildSpaceHorizontal(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005),
                                            const Text(
                                              "⭐",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 32.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Course Sections : ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "${courseByIdModel!.sections!.length}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            buildSpaceVertical(
                                MediaQuery.of(context).size.height * 0.02),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p6,
                                  horizontal: AppPadding.p22),
                              child: TabBar(
                                isScrollable: true,
                                indicator: BoxDecoration(
                                    color: ColorManager.redColor,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s22)),
                                controller: _controller,
                                unselectedLabelColor: ColorManager.blackColor,
                                unselectedLabelStyle: const TextStyle(
                                    color: ColorManager.blackColor),
                                tabs: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      child: Tab(
                                        child: Text(
                                          "Overview",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      child: Tab(
                                        child: Text(
                                          "Curriculum",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      child: Tab(
                                        child: Text(
                                          "Instructor",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width,
                              child: TabBarView(
                                controller: _controller,
                                children: [
                                  OverviewScreen(
                                      myCoursesModel: widget.myCoursesModel,
                                      isWishlist: false,
                                      isMyCourse: "true"),
                                  Playlist(
                                      courseId: courseId,
                                      myCoursesModel: widget.myCoursesModel,
                                      isWishlist: false,
                                      isMyCourse: "true",
                                      isLocked: isPressed ? false : true),
                                  InstructorScreen(
                                      myCoursesModel: widget.myCoursesModel,
                                      isWishlist: false,
                                      isMyCourse: "true"),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : courseByIDController.isLoading.isTrue
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSpaceVertical(
                                  MediaQuery.of(context).size.height * 0.01),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.90,
                                          child: ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  topLeft: Radius.circular(
                                                      AppSize.s10),
                                                  topRight: Radius.circular(
                                                      AppSize.s10),
                                                  bottomLeft: Radius.circular(
                                                      AppSize.s10),
                                                  bottomRight: Radius.circular(
                                                      AppSize.s10)),
                                              child: Image.network(
                                                  courseByIdModel!.image!,
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 20,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                          decoration: const BoxDecoration(
                                              color: ColorManager.redColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    AppSize.s10),
                                                bottomLeft: Radius.circular(
                                                    AppSize.s10),
                                                topRight: Radius.circular(
                                                    AppSize.s10),
                                                bottomRight: Radius.circular(
                                                    AppSize.s10),
                                              )),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Price',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "\NGN\ ${courseByIdModel!.price.toString()}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              buildSpaceVertical(
                                  MediaQuery.of(context).size.height * 0.01),
                              buildSpaceVertical(
                                  MediaQuery.of(context).size.height * 0.02),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: width * 0.85,
                                      child: Text(
                                        courseByIdModel!.name!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 28),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: AppPadding.p34),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005),
                                              Text(
                                                courseByIdModel!.rating!
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 16),
                                              ),
                                              buildSpaceHorizontal(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005),
                                              const Text(
                                                "⭐",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 32.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Course Sections : ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "${courseByIdModel!.sections!.length}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildSpaceVertical(
                                  MediaQuery.of(context).size.height * 0.02),
                              buildSpaceVertical(
                                  MediaQuery.of(context).size.height * 0.02),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p6,
                                    horizontal: AppPadding.p22),
                                child: TabBar(
                                  isScrollable: true,
                                  indicator: BoxDecoration(
                                      color: ColorManager.redColor,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s22)),
                                  controller: _controller,
                                  unselectedLabelColor: ColorManager.blackColor,
                                  unselectedLabelStyle: const TextStyle(
                                      color: ColorManager.blackColor),
                                  tabs: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        child: Tab(
                                          child: Text(
                                            "Overview",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        child: Tab(
                                          child: Text(
                                            "Curriculum",
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        child: Tab(
                                          child: Text(
                                            "Instructor",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width,
                                child: TabBarView(
                                  controller: _controller,
                                  children: [
                                    OverviewScreen(
                                        courseByIdModel: courseByIdModel,
                                        isWishlist: false,
                                        isMyCourse: "false"),
                                    Playlist(
                                        courseId: courseId,
                                        courseByIdModel: courseByIdModel,
                                        isWishlist: false,
                                        isMyCourse: "false",
                                        isLocked: isStarted),
                                    InstructorScreen(
                                        // coursesDetail: widget.coursesDetail,
                                        courseByIdModel: courseByIdModel,
                                        isWishlist: false,
                                        isMyCourse: "false"),
                                  ],
                                ),
                              )
                            ],
                          )),
            bottomSheet: SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppPadding.p10, top: AppPadding.p10),
                  child:
                      isStarted == false ? const SizedBox() : buildBottomCard(),
                )),
          );
  }

  Center buildBottomCard() {
    var data = Get.arguments;
    return Center(
      child: isPaid == true ||
              courseByIDController.courseByIDList.value!.price == 0
          ? isPressed
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: () async {
                    setState(() {
                      isStarted = false;
                      isPressed = true;
                    });
                    await startCourseController.startCourse(data.toString());
                    successToast("Congrats",
                        "Go to Curriculum and start the lessons one by one");
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.primaryColor),
                    child: Center(
                        child: textStyle2(
                            text: "Start Now", color: ColorManager.whiteColor)),
                  ),
                )
          : Obx(() {
              if (paymentGatewayController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                paymentGatewayModel.clear();
                for (int i = 0;
                    i < paymentGatewayController.gatewayList.length;
                    i++) {
                  if (paymentGatewayController.gatewayList[i].enabled == true) {
                    paymentGatewayModel
                        .add(paymentGatewayController.gatewayList[i]);
                  }
                }
                return InkWell(
                  onTap: () {
                    if (widget.isWishlist) {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, StateSetter customSetState) {
                              return PaymentSheet(
                                  productPrice:
                                      courseByIdModel!.price.toString(),
                                  paymentGatewayModel: paymentGatewayModel,
                                  productId:
                                      widget.favCourseDetail!.id.toString(),
                                  isCart: false);
                            });
                          });
                    } else if (isMyCourse == "true") {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, StateSetter customSetState) {
                              return PaymentSheet(
                                  productPrice:
                                      courseByIdModel!.price.toString(),
                                  paymentGatewayModel: paymentGatewayModel,
                                  productId:
                                      widget.myCoursesModel!.id.toString(),
                                  isCart: false);
                            });
                          });
                    } else {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, StateSetter customSetState) {
                              return PaymentSheet(
                                  productPrice:
                                      courseByIdModel!.price.toString(),
                                  paymentGatewayModel: paymentGatewayModel,
                                  productId: courseByIdModel!.id.toString(),
                                  isCart: false);
                            });
                          });
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.primaryColor),
                    child: Center(
                        child: textStyle2(
                            text: "Buy Now", color: ColorManager.whiteColor)),
                  ),
                );
              }
            }),
    );
  }

  AppBar buildAppBar(String text) {
    var data = Get.arguments;
    return AppBar(
      title: Text(
        text,
        overflow: TextOverflow.clip,
        maxLines: 1,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: false,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
      actions: [
        InkWell(
          onTap: () {
            addFavController.addFavorite(data.toString()).then((response) => {
                  if (response['message'] ==
                      'This course has been added to your wishlists')
                    {
                      Get.snackbar("Success", "Course Added to Wishlist",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.blue,
                          colorText: Colors.white),
                      setState(() {
                        inWishlist = true;
                      }),
                    }
                  else
                    {
                      Get.snackbar("Success", "Course Removed from WishList",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.blue,
                          colorText: Colors.white),
                      setState(() {
                        inWishlist = false;
                      }),
                    }
                });
            // wishlistController.fetchWishlist();
            // for (int i = 0; i < wishlistController.wishlist.value!.data!.items!.length; i++) {
            //   if (data == wishlistController.wishlist.value!.data!.items![i].id) {
            //     setState(() {
            //       inWishlist = true;
            //     });
            //   }else{
            //     setState(() {
            //       inWishlist = false;
            //     });
            //   }
            // }
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.05,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.whiteColor),
            child: inWishlist == true
                ? const Icon(Icons.favorite, color: ColorManager.redColor)
                : const Icon(Icons.favorite_border,
                    color: ColorManager.blackColor),
          ),
        ),
        buildSpaceHorizontal(MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }
}
