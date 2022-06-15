// ignore_for_file: file_names
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/models/assignment_byID_model.dart';
import 'package:http/http.dart' as http;
import 'package:topgrade/network_module/api_path.dart';

import '../network_module/api_base.dart';

class AssignmentByIDController extends GetxController {
  var isLoading = false.obs;
  var assignmentByIDList = Rxn<AssignmentByIdModel>();
  static var client = http.Client();
  final box = GetStorage();

  Future<AssignmentByIdModel?> fetchAssignmentByID(String id) async {
    isLoading.value = true;
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
      isLoading.value = false;
      return assignmentByIdModelFromJson(jsonString);
    } else {
      isLoading.value = false;
      // errorToast(StringsManager.error, "Unable to Fetch Lesson By ID");
      return null;
    }
  }

  // void fetchAssignmentById(String id) async {
  //   try {
  //     isLoading(true);
  //     var assignmentByID = await remoteServices.fetchAssignmentByID(id);
  //     if (assignmentByID != null) {
  //       isLoading(false);
  //       assignmentByIDList.value = assignmentByID;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
