import 'package:flutter/material.dart';
import 'package:mytopgrade/helpers/helper.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:mytopgrade/utils/assets_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import '../../../helpers/text_helper.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import 'widgets/payment_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Color> colorList = [
    ColorManager.lightBlueColor,
    ColorManager.lightGreenColor,
    ColorManager.lightPurpleColor
  ];
  List<PaymentMethodsModel> paymentMethodsList = [];
  int selectedPaymentMethod = -1;
  int selectedCard = -1;

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    paymentMethodsList.add(
        PaymentMethodsModel(image: AssetsManager.debit, name: 'Debit Card'));
    paymentMethodsList
        .add(PaymentMethodsModel(image: AssetsManager.stripe, name: 'Stripe'));
    paymentMethodsList
        .add(PaymentMethodsModel(image: AssetsManager.paypal, name: 'Paypal'));
    paymentMethodsList
        .add(PaymentMethodsModel(image: AssetsManager.cod, name: 'COD'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p12),
            child: textStyle1(text: "Select Payment Method"),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 140,
                    childAspectRatio: 5 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15),
                itemCount: paymentMethodsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () => setState(() => selectedPaymentMethod = index),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          color: (selectedPaymentMethod == index)
                              ? ColorManager.primaryColor
                              : ColorManager.halfWhiteColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(paymentMethodsList[index].image,
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.08),
                          buildSpaceHorizontal(
                              MediaQuery.of(context).size.width * 0.02),
                          textStyle0_5(text: paymentMethodsList[index].name),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          selectedPaymentMethod == 0
              ? Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p12),
                  child: textStyle1(text: "Select Your Card"),
                )
              : const SizedBox.shrink(),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          selectedPaymentMethod == 0
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: colorList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p10),
                          child: InkWell(
                            onTap: () => setState(() => selectedCard = index),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: MediaQuery.of(context).size.width * 0.60,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s10),
                                  color: colorList[index],
                                  border: selectedCard == index
                                      ? Border.all(
                                          color: ColorManager.blackColor,
                                          width: 2)
                                      : null),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: AppPadding.p12,
                                        top: AppPadding.p12),
                                    child: Icon(
                                        Icons.account_balance_wallet_rounded,
                                        color: ColorManager.whiteColor),
                                  ),
                                  buildSpaceVertical(
                                      MediaQuery.of(context).size.height *
                                          0.03),
                                  Center(
                                      child: textStyle0_5(
                                          text: "2346 **** **** 9834",
                                          color: ColorManager.whiteColor)),
                                  buildSpaceVertical(
                                      MediaQuery.of(context).size.height *
                                          0.02),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textStyle00(
                                                text: "Card Holder",
                                                color: ColorManager.whiteColor),
                                            textStyle0(
                                                text: "Zain Ullah",
                                                color: ColorManager.whiteColor)
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textStyle00(
                                                text: "Expires",
                                                color: ColorManager.whiteColor),
                                            textStyle0(
                                                text: "15/26",
                                                color: ColorManager.whiteColor)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              : const SizedBox.shrink(),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.10),
          Center(
            child: InkWell(
              onTap: () {
                Get.toNamed(Paths.addNC);
              },
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s16),
                      color: ColorManager.redColor),
                  child: Center(
                      child: textStyle1(
                          text: "Add New Card",
                          color: ColorManager.whiteColor))),
            ),
          ),
        ],
      ),
      bottomSheet: buildBottomCard(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.checkout),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }

  Container buildBottomCard() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      color: ColorManager.whiteColor,
      child: InkWell(
        onTap: () {
          showDialog(
            barrierColor: Colors.black26,
            context: context,
            builder: (context) {
              return const PaymentDialog();
            },
          );
        },
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.53,
            decoration: BoxDecoration(
              color: ColorManager.redColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primaryColor.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentMethodsModel {
  String name;
  String image;
  PaymentMethodsModel({required this.name, required this.image});
}
