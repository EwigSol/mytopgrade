import 'package:flutter/material.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:topgrade/controllers/cart_controller.dart';
import 'package:topgrade/controllers/order_controller.dart';
import 'package:topgrade/controllers/order_controller_for_flutterwave.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:get/get.dart';
import 'package:topgrade/routes/appPages.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/values_manager.dart';
import '../../widgets/text_field.dart';
import 'package:flutterwave/flutterwave.dart';

class PaymentScreenFlutterWave extends StatefulWidget {
  const PaymentScreenFlutterWave({Key? key}) : super(key: key);

  @override
  State<PaymentScreenFlutterWave> createState() =>
      _PaymentScreenFlutterWaveState();
}

class _PaymentScreenFlutterWaveState extends State<PaymentScreenFlutterWave> {
  double height = Get.height;
  double width = Get.width;
  final box = GetStorage();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();
  final phoneController = TextEditingController();
  String? productId;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? prodcutPrice;
  var orderController = Get.put(FlutterWaveOrderController());
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? lineItemModel;
  String txref = 'xyz12hakjdsbfjhauey9876876';
  String currency = FlutterwaveCurrency.NGN;

  @override
  void initState() {
    super.initState();
    var data = Get.arguments;
    lineItemModel = data;
    prodcutPrice = Get.parameters['prodcutPrice'];
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(height * 0.03),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p10, bottom: AppPadding.p10),
              child: textStyle11(text: "Address"),
            ),
            CustomTextField(
              controller: addressController,
              hintName: "Enter Your Address",
              inputLines: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p10, bottom: AppPadding.p10),
              child: textStyle11(text: "Phone"),
            ),
            CustomTextField(
              controller: phoneController,
              hintName: "Enter Your Phone",
              inputLines: 4,
            ),
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
            buildSpaceVertical(height * 0.03),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p10, bottom: AppPadding.p10),
              child: textStyle11(text: "Postal Code"),
            ),
            CustomTextField(
              controller: postalCodeController,
              hintName: "Enter Your Postal Code",
              inputType: TextInputType.number,
            ),
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
                onTap: () async {
                  if (addressController.text.isNotEmpty) {
                    if (cityController.text.isNotEmpty) {
                      if (stateController.text.isNotEmpty) {
                        if (postalCodeController.text.isNotEmpty) {
                          if (countryController.text.isNotEmpty) {
                            await beginPayment(currency, productPrice, txref);
                            orderController
                                .flutterWaveOrder(
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
                                    phoneController.text,
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
                          errorToast("Warning", "Postal Code is required");
                        }
                      } else {
                        errorToast("Warning", "State is required");
                      }
                    } else {
                      errorToast("Warning", "City is required");
                    }
                  } else {
                    errorToast("Warning", "Address is required");
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
    );
  }

  beginPayment(
    currency,
    amount,
    txref,
  ) async {
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: this.context,
        encryptionKey: "2c24573c8914cdadcbc5399c",
        publicKey: "FLWPUBK-6119f871248dd5fa10b68e1a76660b6d-X",
        currency: currency,
        amount: amount,
        email: email!,
        fullName: "$firstName $lastName",
        txRef: txref,
        isDebugMode: true,
        phoneNumber: phoneController.text,
        acceptCardPayment: true,
        acceptUSSDPayment: false,
        acceptAccountPayment: false,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);
    print(flutterwave.fullName);

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      bool checkPaymentIsSuccessful(final ChargeResponse response) {
        return response.data!.status == FlutterwaveConstants.SUCCESSFUL &&
            response.data!.currency == currency &&
            response.data!.amount == amount &&
            response.data!.txRef == txref;
      }

      if (response == null) {
        // user didn't complete the transaction.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data!.processorResponse);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
    }
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: "Payment Details"),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
