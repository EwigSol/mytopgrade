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

  Future<List<CoursesModel>?> fetchCourses() async {
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.courses)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      var jsonString = response.body;
      coursesList.value = coursesModelFromJson(jsonString);
      return coursesModelFromJson(jsonString);
    } else {
      //show error message
      errorToast(StringsManager.error, "Unable to Fetch Courses");
      return null;
    }
  }

  // void fetchAllCourses() async {
  //   try {
  //     isLoading(true);
  //     var courses = await fetchCourses();
  //     if (courses != null) {
  //       isLoading(false);
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
