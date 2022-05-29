



import 'package:get/state_manager.dart';
import 'package:topgrade/models/assignment_byID_model.dart';
import '../services/remote_services.dart';


class AssignmentByIDController extends GetxController {

  var isLoading = true.obs;
  var assignmentByIDList = Rxn<AssignmentByIdModel>();


  void fetchAssignmentById(String id) async {
    try {
      isLoading(true);
      var assignmentByID = await RemoteServices.fetchAssignmentByID(id);
      if (assignmentByID != null) {
        isLoading(false);
        assignmentByIDList.value = assignmentByID;
      }
    } finally {
      isLoading(false);
    }
  }

}