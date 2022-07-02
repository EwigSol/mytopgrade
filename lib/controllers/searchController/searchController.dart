import 'package:get/state_manager.dart';
import 'package:mytopgrade/models/searchModel.dart';
import 'package:mytopgrade/services/remote_services.dart';
import 'package:http/http.dart' as http;

class SearchController extends GetxController {
  static var client = http.Client();

  var isLoading = true.obs;
  var coursesList = <SearchModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<SearchModel>> searchCourses(String search) async {
    isLoading.value = true;
    var response = await client.get(
        Uri.parse(
            'https://musing-gould.18-141-157-112.plesk.page/wp-json/learnpress/v1/courses?search=$search'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    coursesList.value = searchModelFromJson(response.body);
    isLoading.value = false;
    return searchModelFromJson(response.body);
  }
}
