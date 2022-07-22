import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mytopgrade/controllers/InProgressController.dart';
import 'package:mytopgrade/controllers/my_all_courses_controller.dart';
import 'package:mytopgrade/controllers/wishlist_controller.dart';
import '../network_module/api_base.dart';
import '../network_module/api_path.dart';

class LoginController extends GetxController {
  final WishlistController wishlistController = WishlistController();
  final InProgressController inProgressController = InProgressController();
  final MyAllCoursesController myAllCoursesController =
      MyAllCoursesController();
  var isDataSubmitting = false.obs;
  var isDataReadingCompleted = false.obs;
  static var client = http.Client();
  final box = GetStorage();

  Future<Map<String, dynamic>> login(String userName, String password) async {
    Map<String, dynamic> result;
    isDataSubmitting.value = true;
    final queryParameters = {'username': userName, 'password': password};

    var response = await client.post(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.login))
            .replace(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      isDataReadingCompleted.value = true;
      box.write("token", responseData['token']);
      box.write("user_id", responseData['user_id']);
      box.write("user_login", responseData['user_login']);
      box.write("user_email", responseData['user_email']);
      box.write("user_display_name", responseData['user_display_name']);
      box.write("isLogged", true);
      result = {
        'status': true,
        'token': responseData['token'],
        'user_id': responseData['user_id'],
        'user_login': responseData['user_login'],
        'user_email': responseData['user_email'],
        'user_display_name': responseData['user_display_name'],
      };
      isDataSubmitting.value = false;
    } else {
      isDataSubmitting.value = false;
      isDataReadingCompleted.value = true;
      result = {
        'status': false,
        'message': "Server Error!\nFailed to finish the lesson",
        'data': {}
      };
    }
    return result;
  }
}
