


import 'package:get/state_manager.dart';
import 'package:topgrade/models/quiz_byID_model.dart';
import '../services/remote_services.dart';


class QuizByIDController extends GetxController {

  var isLoading = true.obs;
  var quizByIDList = Rxn<QuizByIdModel>();
  RemoteServices remoteServices = RemoteServices();


  void fetchQuizById(String id) async {
    try {
      isLoading(true);
      var courseByID = await remoteServices.fetchQuizByID(id);
      if (courseByID != null) {
        isLoading(false);
        quizByIDList.value = courseByID;
      }
    } finally {
      isLoading(false);
    }
  }

}