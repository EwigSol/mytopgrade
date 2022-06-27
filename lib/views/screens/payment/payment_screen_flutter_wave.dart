import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
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
  final currencyController = TextEditingController();
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
  String txref = 'ljkabndscohawehrfgaksdjbakjsd';
  String selectedCurrency = "";
  bool isTestMode = true;

  @override
  void initState() {
    super.initState();
    var data = Get.arguments;
    lineItemModel = data;
    prodcutPrice = Get.parameters['productPrice'];
    print(prodcutPrice);
    paymentMethod = Get.parameters['paymentMethod'];
    paymentMethodTitle = Get.parameters['paymentMethodTitle'];
    firstName = box.read("user_display_name");
    lastName = box.read("user_display_name");
    email = box.read("user_email");
  }

  @override
  Widget build(BuildContext context) {
    countryController.text = selectedCurrency;
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
            ),
            buildSpaceVertical(height * 0.03),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: TextFormField(
                controller: currencyController,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                readOnly: true,
                onTap: this._openBottomSheet,
                decoration: InputDecoration(
                  hintText: "Currency",
                ),
                validator: (value) =>
                    value!.isNotEmpty ? null : "Currency is required",
              ),
            ),
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
                  await _handlePaymentInitialization();
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

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "Pay Via Card",
      buttonColor: Colors.white,
      buttonTextStyle: const TextStyle(
          color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
      appBarColor: Colors.white,
      dialogCancelTextStyle: const TextStyle(
        color: Colors.red,
        fontSize: 18,
      ),
      dialogContinueTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.transparent,
      mainTextStyle:
          const TextStyle(color: Colors.indigo, fontSize: 19, letterSpacing: 2),
      dialogBackgroundColor: Colors.greenAccent,
      appBarIcon: const Icon(Icons.arrow_back, color: Colors.black),
      buttonText: "Pay $selectedCurrency ${prodcutPrice.toString()}",
      appBarTitleTextStyle: const TextStyle(
        color: Colors.green,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: "$firstName $lastName",
        phoneNumber: phoneController.text,
        email: email!);

    // final subAccounts = [
    //   SubAccount(
    //       id: "RS_1A3278129B808CB588B53A14608169AD",
    //       transactionChargeType: "flat",
    //       transactionPercentage: 25),
    //   SubAccount(
    //       id: "RS_C7C265B8E4B16C2D472475D7F9F4426A",
    //       transactionChargeType: "flat",
    //       transactionPercentage: 50)
    // ];

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: 'FLWPUBK_TEST-3ee3b78f91bf2a579bb64c18d9012dd5-X',
        currency: selectedCurrency,
        txRef: txref,
        amount: prodcutPrice.toString(),
        customer: customer,
        // subAccounts: subAccounts,
        paymentOptions: "card",
        customization: Customization(title: "Test Payment"),
        redirectUrl: "https://www.google.com",
        isTestMode: false);
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      showLoading(response.status!);
      print("${response.toJson()}");
      if (addressController.text.isNotEmpty) {
        if (cityController.text.isNotEmpty) {
          if (stateController.text.isNotEmpty) {
            if (postalCodeController.text.isNotEmpty) {
              if (countryController.text.isNotEmpty) {
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
                              successToast(
                                  "Success", "Course Ordered Successfully"),
                              Get.toNamed(Paths.paymentSuccess),
                            }
                          else
                            {errorToast("Error", "Failed to Order Course")}
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
    } else {
      showLoading("No Response!");
    }
  }

  // String getPublicKey() {
  //   if (isTestMode) return "FLWPUBK-6119f871248dd5fa10b68e1a76660b6d-X";
  //   return "FLWPUBK-X";
  // }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["NGN", "RWF", "UGX", "ZAR", "USD", "GHS", "TZS"];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => _handleCurrencyTap(currency),
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
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
    );
  }
}
