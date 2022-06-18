import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/models/InProgressModel.dart';
import '../models/my_courses_model.dart';
import '../services/remote_services.dart';
import 'package:http/http.dart' as http;

class InProgressController extends GetxController {
  static var client = http.Client();
  var isLoading = true.obs;
  var inProgressCourseList = <InProgressModel>[].obs;
  RemoteServices remoteServices = RemoteServices();
  final box = GetStorage();

  @override
  void onInit() {
    fetchMyCourses();
    super.onInit();
  }

  Future<List<InProgressModel>?> fetchMyCourses() async {
    isLoading.value = true;
    String token = box.read("token");
    final uri = Uri.parse(
        'https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1/courses?learned=true&course_filter=in-progress');
    var response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var jsonString = response.body;
    inProgressCourseList.value = inProgressCoursesFromJson(jsonString);
    isLoading.value = false;
    return inProgressCoursesFromJson(jsonString);
  }
}
