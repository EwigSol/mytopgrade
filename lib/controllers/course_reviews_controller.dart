


import 'package:get/state_manager.dart';
import 'package:topgrade/models/course_review_model.dart';
import '../services/remote_services.dart';


class CourseReviewsController extends GetxController {

  var isLoading = true.obs;
  var courseReviews = Rxn<CourseReviewModel>();
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchCourseById();
    super.onInit();
  }

  void fetchCourseById() async {
    try {
      isLoading(true);
      var courseReview = await remoteServices.fetchCourseReviews("32492");
      if (courseReview != null) {
        isLoading(false);
        courseReviews.value = courseReview;
      }
    } finally {
      isLoading(false);
    }
  }

}