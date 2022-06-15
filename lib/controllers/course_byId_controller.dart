// ignore_for_file: file_names

import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/models/course_by_id_model.dart';
import 'package:topgrade/network_module/api_base.dart';
import 'package:topgrade/network_module/api_path.dart';
import '../services/remote_services.dart';
import 'package:http/http.dart' as http;

class CourseByIDController extends GetxController {
  var isLoading = true.obs;
  var courseByIDList = Rxn<CourseByIdModel>();
  RemoteServices remoteServices = RemoteServices();
  static var client = http.Client();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
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
      courseByIDList.value = await courseByIdModelFromJson(jsonString);
      return courseByIdModelFromJson(jsonString);
    } else {
      // errorToast(StringsManager.error, "Unable to Fetch Course By ID");
      return null;
    }
  }

  // void fetchCourseById() async {
  //   try {
  //     isLoading(true);
  //     var courseByID = await remoteServices.fetchCourseByID("32492");
  //     if (courseByID != null) {
  //       isLoading(false);
  //       courseByIDList.value = courseByID;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
