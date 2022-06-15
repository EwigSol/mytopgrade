import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/assignment_byID_model.dart';
import 'package:topgrade/models/assignments_model.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/models/course_by_id_model.dart';
import 'package:topgrade/models/course_review_model.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/models/lesson_byID_model.dart';
import 'package:topgrade/models/lessons_model.dart';
import 'package:topgrade/models/my_courses_model.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import 'package:topgrade/models/quiz_model.dart';
import 'package:topgrade/models/wishlist_model.dart';
import '../models/course_category_model.dart';
import '../models/payment_gateway_model.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';
import '../utils/strings_manager.dart';

class RemoteServices {
  static var client = http.Client();
  final box = GetStorage();

  Future<List<MyCoursesModel>?> fetchMyCourses() async {
    String token = box.read("token");
    final uri =
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courses));
    var response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return myCoursesModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch My Courses");
      return null;
    }
  }

  Future<List<CourseCategoryModel>?> fetchCourseCategories() async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(
            APIBase.baseURL + APIPathHelper.getValue(APIPath.courseCategory)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseCategoryModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Course Categories");
      return null;
    }
  }

  Future<CourseByIdModel?> fetchCourseByID(String id) async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL +
            APIPathHelper.getValue(APIPath.courses) +
            "/" +
            id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseByIdModelFromJson(jsonString);
    } else {
      // errorToast(StringsManager.error, "Unable to Fetch Course By ID");
      return null;
    }
  }

  Future<List<LessonsModel>?> fetchLessons() async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.lessons)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return lessonsModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Lessons");
      return null;
    }
  }

  Future<LessonByIdModel?> fetchLessonByID(String id) async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL +
            APIPathHelper.getValue(APIPath.lessons) +
            "/" +
            id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return lessonByIdModelFromJson(jsonString);
    } else {
      // errorToast(StringsManager.error, "Unable to Fetch Lesson By ID");
      return null;
    }
  }

  Future<CourseReviewModel?> fetchCourseReviews(String id) async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(
            APIBase.baseURL + APIPathHelper.getValue(APIPath.review) + id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseReviewModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Course Reviews");
      return null;
    }
  }

  Future<List<QuizModel>?> fetchQuizList() async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.quiz)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return quizModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Course Quiz List");
      return null;
    }
  }

  Future<QuizByIdModel?> fetchQuizByID(String id) async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(
            APIBase.baseURL + APIPathHelper.getValue(APIPath.quiz) + "/" + id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return quizByIdModelFromJson(jsonString);
    } else {
      // errorToast(StringsManager.error, "Unable to Fetch Quiz By ID");
      return null;
    }
  }

  Future<List<CategoriesModel>?> fetchCategories() async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(
            "https://musing-gould.18-141-157-112.plesk.page/wp-json/wp/v2/course_category"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoriesModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Courses");
      return null;
    }
  }

  Future<List<CoursesModel>?> fetchCoursesByCategory(String id) async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(
            "https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1/courses/?category=$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return coursesModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Courses By Category");
      return null;
    }
  }

  Future<List<AssignmentModel>?> fetchAssignmentsList() async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(
            APIBase.baseURL + APIPathHelper.getValue(APIPath.assignments)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return assignmentModelFromJson(jsonString);
    } else {
      // errorToast(StringsManager.error, "Unable to Fetch Assignments List");
      return null;
    }
  }

  Future<WishlistModel?> fetchWishlist() async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.wishlist)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return wishlistModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Wishlist");
      return null;
    }
  }

  static Future<List<PaymentGatewayModel>?> fetchGatewaysList() async {
    String userName = "ck_62b64e6a92c2c362330491e2044f7e49414ca6c9";
    String password = "cs_6dab149b45ec92999adfc637192d53b3f589d41a";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$password'));
    var response = await client.get(
        Uri.parse(
            "https://musing-gould.18-141-157-112.plesk.page/wp-json/wc/v3/payment_gateways"),
        headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return paymentGatewayModelFromJson(jsonString);
    } else {
      errorToast(StringsManager.error, "Unable to Fetch Payment Gateway List");
      return null;
    }
  }

  Future<AssignmentByIdModel?> fetchAssignmentByID(String id) async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL +
            APIPathHelper.getValue(APIPath.assignmentById) +
            id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return assignmentByIdModelFromJson(jsonString);
    } else {
      // errorToast(StringsManager.error, "Unable to Fetch Lesson By ID");
      return null;
    }
  }
}
