import 'package:get/state_manager.dart';
import 'package:mytopgrade/models/quiz_model.dart';
import '../services/remote_services.dart';

class QuizController extends GetxController {
  var isLoading = true.obs;
  var quizList = <QuizModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchQuizList();
    super.onInit();
  }

  void fetchQuizList() async {
    try {
      isLoading(true);
      var quiz = await remoteServices.fetchQuizList();
      if (quiz != null) {
        isLoading(false);
        quizList.value = quiz;
      }
    } finally {
      isLoading(false);
    }
  }
}
