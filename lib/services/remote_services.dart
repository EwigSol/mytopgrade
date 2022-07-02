import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/models/assignments_model.dart';
import 'package:mytopgrade/models/category_model.dart';
import 'package:mytopgrade/models/course_review_model.dart';
import 'package:mytopgrade/models/courses_model.dart';
import 'package:mytopgrade/models/lessons_model.dart';
import 'package:mytopgrade/models/quiz_model.dart';
import '../models/course_category_model.dart';
import '../models/payment_gateway_model.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';
import '../utils/strings_manager.dart';

class RemoteServices {
  static var client = http.Client();
  final box = GetStorage();

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
}
