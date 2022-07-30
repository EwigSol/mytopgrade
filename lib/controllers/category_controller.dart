import 'package:get/state_manager.dart';
import 'package:mytopgrade/models/category_model.dart';
import '../services/remote_services.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var catList = <CategoriesModel>[].obs;
  RemoteServices remoteServices = RemoteServices();

  @override
  void onInit() {
    fetchAllCategories();
    super.onInit();
  }

  void fetchAllCategories() async {
    try {
      isLoading(true);
      var categories = await remoteServices.fetchCategories();
      if (categories != null) {
        isLoading(false);
        catList.value = categories;
      }
    } finally {
      isLoading(false);
    }
  }
}
