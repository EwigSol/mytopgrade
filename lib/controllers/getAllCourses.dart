import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/models/courses_model.dart';
import 'package:mytopgrade/network_module/api_base.dart';
import 'package:mytopgrade/network_module/api_path.dart';
import 'package:mytopgrade/utils/strings_manager.dart';
import '../services/remote_services.dart';
import 'package:http/http.dart' as http;

class AllCoursesController extends GetxController {
  static var client = http.Client();
  final box = GetStorage();

  var isLoading = true.obs;
  var coursesList = <CoursesModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchAllCourses();
    // fetchAllCourses();
    super.onInit();
  }

  Future<List<CoursesModel>> fetchAllCourses() async {
    isLoading.value = true;
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL +
            APIPathHelper.getValue(APIPath.courses) +
            ('?per_page=100')),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    coursesList.value = coursesModelFromJson(response.body);
    isLoading.value = false;
    return coursesModelFromJson(response.body);
  }
}
