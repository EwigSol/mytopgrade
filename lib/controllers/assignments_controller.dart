


import 'package:get/state_manager.dart';
import 'package:topgrade/models/assignments_model.dart';
import '../services/remote_services.dart';


class AssignmentController extends GetxController {

  var isLoading = true.obs;
  var assignmentList = <AssignmentModel>[].obs;

  @override
  void onInit() {
    fetchAssignmentsList();
    super.onInit();
  }

  void fetchAssignmentsList() async {
    try {
      isLoading(true);
      var assignment = await RemoteServices.fetchAssignmentsList();
      if (assignment != null) {
        isLoading(false);
        assignmentList.value = assignment;
      }
    } finally {
      isLoading(false);
    }
  }

}