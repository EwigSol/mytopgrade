import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/models/FinishedCoursesModel.dart';
import '../services/remote_services.dart';
import 'package:http/http.dart' as http;

class FinishedCoursesController extends GetxController {
  static var client = http.Client();
  var isLoading = true.obs;
  var finishedCourseList = <FinishedCoursesModel>[].obs;
  RemoteServices remoteServices = RemoteServices();
  final box = GetStorage();

  @override
  void onInit() {
    fetchMyCourses();
    super.onInit();
  }

  Future<List<FinishedCoursesModel>?> fetchMyCourses() async {
    isLoading.value = true;
    String token = box.read("token");
    final uri = Uri.parse(
        'https://mytopgrade.com/wp-json/learnpress/v1/courses?learned=true&course_filter=passed');
    var response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var jsonString = response.body;
    finishedCourseList.value = finishedCoursesFromJson(jsonString);
    isLoading.value = false;
    return finishedCoursesFromJson(jsonString);
  }
}
