import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/controllers/order_controller.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:get/get.dart';
import 'package:mytopgrade/routes/appPages.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/text_field.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double height = Get.height;
  double width = Get.width;
  final box = GetStorage();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();
  String? productId;
  String? paymentMethod;
  String? paymentMethodTitle;
  var orderController = Get.put(OrderController());
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? lineItemModel;

  @override
  void initState() {
    super.initState();
    var data = Get.arguments;
    lineItemModel = data;
    paymentMethod = Get.parameters['paymentMethod'];
    paymentMethodTitle = Get.parameters['paymentMethodTitle'];
    firstName = box.read("user_display_name");
    lastName = box.read("user_display_name");
    email = box.read("user_email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(height * 0.03),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: AppPadding.p10, bottom: AppPadding.p10),
              //   child: textStyle11(text: "Address"),
              // ),
              // CustomTextField(
              //   controller: addressController,
              //   hintName: "Enter Your Address",
              //   inputLines: 4,
              // ),
              buildSpaceVertical(height * 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p10),
                child: textStyle11(text: "City"),
              ),
              CustomTextField(
                controller: cityController,
                hintName: "Enter Your City",
              ),
              buildSpaceVertical(height * 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p10),
                child: textStyle11(text: "State"),
              ),
              CustomTextField(
                controller: stateController,
                hintName: "Enter Your State",
              ),
              // buildSpaceVertical(height * 0.03),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: AppPadding.p10, bottom: AppPadding.p10),
              //   child: textStyle11(text: "Postal Code"),
              // ),
              // CustomTextField(
              //   controller: postalCodeController,
              //   hintName: "Enter Your Postal Code",
              //   inputType: TextInputType.number,
              // ),
              buildSpaceVertical(height * 0.03),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p10, bottom: AppPadding.p10),
                child: textStyle11(text: "Country"),
              ),
              CustomTextField(
                controller: countryController,
                hintName: "Enter Your Country",
              ),
              buildSpaceVertical(height * 0.05),
              Center(
                child: InkWell(
                  onTap: () {
                    if (cityController.text.isNotEmpty) {
                      if (stateController.text.isNotEmpty) {
                        if (countryController.text.isNotEmpty) {
                          orderController
                              .order(
                                  paymentMethod!,
                                  paymentMethodTitle,
                                  firstName,
                                  lastName,
                                  addressController.text,
                                  cityController.text,
                                  stateController.text,
                                  postalCodeController.text,
                                  countryController.text,
                                  email,
                                  "+9231397897654",
                                  lineItemModel)
                              .then((response) => {
                                    if (response['status'] == true)
                                      {
                                        successToast("Success",
                                            "Course Ordered Successfully"),
                                        Get.toNamed(Paths.paymentSuccess),
                                      }
                                    else
                                      {
                                        errorToast(
                                            "Error", "Failed to Order Course")
                                      }
                                  });
                        } else {
                          errorToast("Warning", "Country is required");
                        }
                      } else {
                        errorToast("Warning", "State is required");
                      }
                    } else {
                      errorToast("Warning", "City is required");
                    }
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        color: ColorManager.primaryColor),
                    child: Obx(() {
                      return orderController.isDataSubmitting.value == true
                          ? const Center(child: CircularProgressIndicator())
                          : Center(
                              child: textStyle2(
                                  text: "Place Order",
                                  color: ColorManager.whiteColor));
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: "Payment Details"),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }
}
