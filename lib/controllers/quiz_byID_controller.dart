


import 'package:get/state_manager.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import '../services/remote_services.dart';


class QuizByIDController extends GetxController {

  var isLoading = true.obs;
  var quizByIDList = Rxn<QuizByIdModel>();


  void fetchQuizById(String id) async {
    try {
      isLoading(true);
      var courseByID = await RemoteServices.fetchQuizByID(id);
      if (courseByID != null) {
        isLoading(false);
        quizByIDList.value = courseByID;
      }else{
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

}