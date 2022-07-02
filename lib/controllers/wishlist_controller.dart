import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/models/wishlist_model.dart';
import 'package:mytopgrade/network_module/api_base.dart';
import 'package:mytopgrade/network_module/api_path.dart';
import '../services/remote_services.dart';
import 'package:http/http.dart' as http;

class WishlistController extends GetxController {
  final box = GetStorage();
  var isLoading = true.obs;
  var wishlist = Rxn<WishlistModel>();
  RemoteServices remoteServices = RemoteServices();
  static var client = http.Client();

  // @override
  // void onInit() {
  //   fetchWishlist();
  //   super.onInit();
  // }

  Future<WishlistModel?> fetchWishlist() async {
    isLoading.value = true;
    String token = box.read("token");
    var response = await client.get(
        Uri.parse(APIBase.baseURL + APIPathHelper.getValue(APIPath.wishlist)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    var jsonString = response.body;
    wishlist.value = wishlistModelFromJson(jsonString);
    isLoading.value = false;
    return wishlistModelFromJson(jsonString);
  }
}
