import 'package:get/state_manager.dart';
import 'package:mytopgrade/models/payment_gateway_model.dart';
import '../services/remote_services.dart';

class PaymentGatewayController extends GetxController {
  var isLoading = true.obs;
  var gatewayList = <PaymentGatewayModel>[].obs;

  @override
  void onInit() {
    fetchAssignmentsList();
    super.onInit();
  }

  void fetchAssignmentsList() async {
    try {
      isLoading(true);
      var paymentGateway = await RemoteServices.fetchGatewaysList();
      if (paymentGateway != null) {
        isLoading(false);
        gatewayList.value = paymentGateway;
      }
    } finally {
      isLoading(false);
    }
  }
}
