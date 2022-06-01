


import 'package:get/state_manager.dart';
import 'package:topgrade/models/wishlist_model.dart';
import '../services/remote_services.dart';

class WishlistController extends GetxController {

  var isLoading = true.obs;
  var wishlist = Rxn<WishlistModel>();
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchWishlists();
    super.onInit();
  }

  void fetchWishlists() async {
    try {
      isLoading(true);
      var item = await remoteServices.fetchWishlist();
      if (item != null) {
        isLoading(false);
        wishlist.value = item;
      }
    } finally {
      isLoading(false);
    }
  }

}