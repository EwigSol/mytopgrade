import 'package:flutter/material.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/payment_gateway_controller.dart';
import '../../../helpers/text_helper.dart';
import '../../../models/payment_gateway_model.dart';
import '../../../routes/appPages.dart';
import '../../../utils/color_manager.dart';
import '../../../utils/strings_manager.dart';
import '../details/widgets/payment_sheet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var cartController = Get.put(CartController());
  var paymentGatewayController = Get.put(PaymentGatewayController());
  List<PaymentGatewayModel> paymentGatewayModel = [];

  @override
  void initState() {
    cartController.getCartItems();
    cartController.getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (cartController.totalItem < 1) {
          return Center(child: textStyle2(text: "Cart is Empty"));
        } else {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: cartController.totalItem.value,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p6,
                              horizontal: AppPadding.p12),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.88,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s16),
                                color: ColorManager.halfWhiteColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.11,
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s10),
                                      child: Image.network(
                                          cartController.products[index]
                                              ['productImage'],
                                          fit: BoxFit.fill)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textStyle0(
                                        text: cartController.products[index]
                                            ['productName']),
                                    textStyle0(
                                        text: "By Talent Tamer",
                                        color: ColorManager.grayColor),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        textStyle0(text: "3.5"),
                                        buildSpaceHorizontal(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        textStyle0(text: "⭐"),
                                        buildSpaceHorizontal(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        textStyle0(text: "1250 Ratings"),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppPadding.p16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textStyle0_5(
                                          text:
                                              "\$ ${cartController.products[index]['productPrice']}"),
                                      InkWell(
                                        onTap: () {
                                          cartController.delete(
                                              id: int.parse(
                                                  cartController.products[index]
                                                      ['productId']));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.delete,
                                                color: ColorManager.redColor,
                                                size: 16),
                                            buildSpaceHorizontal(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            textStyle0(
                                                text: "Remove",
                                                color: ColorManager.redColor),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    color: ColorManager.halfWhiteColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: textStyle2(text: "Summary")),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textStyle1(text: "Courses:"),
                          textStyle1(
                              text: cartController.totalItem.value.toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textStyle1(text: "SubTotal:"),
                          textStyle1(
                              text:
                                  "\$ ${cartController.totalPrice.toString()}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textStyle1(
                              text: "Total:", color: ColorManager.redColor),
                          textStyle1(
                              text:
                                  "\$ ${cartController.totalPrice.toString()}",
                              color: ColorManager.redColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildSpaceVertical(MediaQuery.of(context).size.height * 0.10),
            ],
          );
        }
      }),
      bottomSheet: buildBottomCard(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.cart),
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
      child: Obx(() {
        if (paymentGatewayController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          paymentGatewayModel.clear();
          for (int i = 0;
              i < paymentGatewayController.gatewayList.length;
              i++) {
            if (paymentGatewayController.gatewayList[i].enabled == true) {
              paymentGatewayModel.add(paymentGatewayController.gatewayList[i]);
            }
          }
          return InkWell(
            onTap: () {
              List<String> productIdList = [];
              for (int i = 0; i < cartController.totalItem.value; i++) {
                productIdList.add(cartController.products[i]['productId']);
              }
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, StateSetter customSetState) {
                      return PaymentSheet(
                          productPrice: cartController.totalPrice.toString(),
                          paymentGatewayModel: paymentGatewayModel,
                          productIdList: productIdList,
                          isCart: true);
                    });
                  });
            },
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    color: ColorManager.primaryColor),
                child: Center(
                    child: textStyle2(
                        text: "Buy Now", color: ColorManager.whiteColor)),
              ),
            ),
          );
        }
      }),
      // InkWell(
      //   onTap: (){
      //     Get.toNamed(Paths.checkout);
      //   },
      //   child: Center(
      //     child: Container(
      //       height: MediaQuery.of(context).size.height * 0.06,
      //       width: MediaQuery.of(context).size.width * 0.53,
      //       decoration: BoxDecoration(
      //         color: ColorManager.redColor,
      //         borderRadius: const BorderRadius.all(
      //           Radius.circular(10),
      //         ),
      //         boxShadow: [
      //           BoxShadow(
      //             color: ColorManager.primaryColor.withOpacity(0.2),
      //             spreadRadius: 4,
      //             blurRadius: 7,
      //             offset: const Offset(0, 3),
      //           ),
      //         ],
      //       ),
      //       child: const Center(
      //         child: Text(
      //           "Checkout",
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
