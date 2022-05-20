

import 'package:http/http.dart' as http;
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/category_model.dart';
import 'package:topgrade/models/course_by_id_model.dart';
import 'package:topgrade/models/course_review_model.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/models/lesson_byID_model.dart';
import 'package:topgrade/models/lessons_model.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import 'package:topgrade/models/quiz_model.dart';
import '../models/course_category_model.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';
import '../utils/strings_manager.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<CoursesModel>?> fetchCourses() async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courses)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return coursesModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Courses");
      return null;
    }
  }

  static Future<List<CoursesModel>?> fetchMyCourses(bool learned) async {
    final queryParameters = {  'learned': learned };
    final uri = Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courses)).replace(queryParameters: queryParameters);
    var response = await client.get(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return coursesModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch My Courses");
      return null;
    }
  }

  static Future<List<CourseCategoryModel>?> fetchCourseCategories() async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courseCategory)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseCategoryModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Course Categories");
      return null;
    }
  }

  static Future<CourseByIdModel?> fetchCourseByID(String id) async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courses)+"/"+id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseByIdModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Course By ID");
      return null;
    }
  }

  static Future<List<LessonsModel>?> fetchLessons() async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.lessons)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return lessonsModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Lessons");
      return null;
    }
  }

  static Future<LessonByIdModel?> fetchLessonByID(String id) async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.lessons)+"/"+id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return lessonByIdModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Lesson By ID");
      return null;
    }
  }

  static Future<CourseReviewModel?> fetchCourseReviews(String id) async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.review)+id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseReviewModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Course Reviews");
      return null;
    }
  }

  static Future<List<QuizModel>?> fetchQuizList() async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.quiz)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return quizModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Course Quiz List");
      return null;
    }
  }

  static Future<QuizByIdModel?> fetchQuizByID(String id) async {
    var response = await client.get(Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.quiz)+"/"+id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return quizByIdModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Quiz By ID");
      return null;
    }
  }

  static Future<List<CategoriesModel>?> fetchCategories() async {
    var response = await client.get(Uri.parse("https://musing-gould.18-141-157-112.plesk.page/wp-json/wp/v2/course_category"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoriesModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Courses");
      return null;
    }
  }

  static Future<List<CoursesModel>?> fetchCoursesByCategory(String id) async {
    var response = await client.get(Uri.parse("https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1/courses/?category=$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${StringsManager.token}',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return coursesModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Courses By Category");
      return null;
    }
  }
}