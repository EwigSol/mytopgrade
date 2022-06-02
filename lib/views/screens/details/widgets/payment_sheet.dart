


import 'package:flutter/material.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/line_item_model.dart';
import 'package:topgrade/models/payment_gateway_model.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';
import 'package:get/get.dart';

import '../../../../routes/appPages.dart';

class PaymentSheet extends StatelessWidget {
  final List<PaymentGatewayModel>? paymentGatewayModel;
  final String? productId;
  final List<String>? productIdList;
  final bool? isCart;
  const PaymentSheet({Key? key, this.paymentGatewayModel, this.productId, this.isCart, this.productIdList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: ListView.builder(
          itemCount: paymentGatewayModel!.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.only(left: AppPadding.p14, right: AppPadding.p14, top: AppPadding.p20),
              child: InkWell(
                onTap: (){
                  List<LineItemModel> lineItems = [];
                  if(isCart == true) {
                    for(int i=0; i<productIdList!.length; i++){
                      lineItems.add(LineItemModel(productId: int.parse(productIdList![i]), quantity: 1 ));
                    }
                    Get.toNamed(Paths.payment, arguments: lineItemModelToJson(lineItems), parameters: {
                      'paymentMethod': paymentGatewayModel![index].id!,
                      'paymentMethodTitle': paymentGatewayModel![index].methodTitle!,
                    });

                  }else{
                    lineItems.add(LineItemModel(productId: int.parse(productId!), quantity: 1 ));
                    Get.toNamed(Paths.payment, arguments: lineItemModelToJson(lineItems), parameters: {
                      'paymentMethod': paymentGatewayModel![index].id!,
                      'paymentMethodTitle': paymentGatewayModel![index].methodTitle!,
                    });
                  }

                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                    color: ColorManager.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 2,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children:  [
                      buildSpaceHorizontal(MediaQuery.of(context).size.width * 0.03),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: ColorManager.halfWhiteColor,
                        child: Image.asset(AssetsManager.logo),
                      ),
                      buildSpaceHorizontal(MediaQuery.of(context).size.width * 0.05),
                      textStyle0_5(text: paymentGatewayModel![index].methodTitle!)
                    ],
                  ),
                ),
              ),
            );
          }
      )
    );
  }
}
