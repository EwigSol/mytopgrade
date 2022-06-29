import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import '../models/my_courses_model.dart';
import '../services/remote_services.dart';
import 'package:http/http.dart' as http;

class MyAllCoursesController extends GetxController {
  static var client = http.Client();
  var isLoading = true.obs;
  var myCoursesList = <MyCoursesModel>[].obs;
  RemoteServices remoteServices = RemoteServices();
  final box = GetStorage();

  @override
  void onInit() {
    fetchMyCourses();
    super.onInit();
  }

  Future<List<MyCoursesModel>> fetchMyCourses() async {
    isLoading.value = true;
    String token = box.read("token");
    final uri = Uri.parse(
        'https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1/courses?learned=true');
    var response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var jsonString = response.body;
    myCoursesList.value = myCoursesModelFromJson(jsonString);
    print(jsonString);
    isLoading.value = false;
    return myCoursesModelFromJson(jsonString);
  }
}
