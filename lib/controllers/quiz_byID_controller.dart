


import 'package:get/state_manager.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import '../services/remote_services.dart';


class QuizByIDController extends GetxController {

  var isLoading = true.obs;
  var quizByIDList = Rxn<QuizByIdModel>();

  @override
  void onInit() {
    fetchQuizById();
    super.onInit();
  }

  void fetchQuizById() async {
    try {
      isLoading(true);
      var courseByID = await RemoteServices.fetchQuizByID("24789");
      if (courseByID != null) {
        isLoading(false);
        quizByIDList.value = courseByID;
      }
    } finally {
      isLoading(false);
    }
  }

}