import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/models/courses_model.dart';
import 'package:topgrade/network_module/api_base.dart';
import 'package:topgrade/network_module/api_path.dart';
import 'package:topgrade/utils/strings_manager.dart';
import '../services/remote_services.dart';
import 'package:http/http.dart' as http;

class CoursesController extends GetxController {
  static var client = http.Client();
  final box = GetStorage();

  var isLoading = true.obs;
  var coursesList = <CoursesModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchCourses();
    // fetchAllCourses();
    super.onInit();
  }

  Future<List<CoursesModel>> fetchCourses() async {
    isLoading.value = true;
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courses)),
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
