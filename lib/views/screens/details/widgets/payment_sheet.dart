

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topgrade/helpers/helper.dart';
import 'package:topgrade/helpers/text_helper.dart';
import 'package:topgrade/models/payment_gateway_model.dart';
import 'package:topgrade/utils/assets_manager.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/utils/values_manager.dart';

class PaymentSheet extends StatelessWidget {
  final List<PaymentGatewayModel>? paymentGatewayModel;
  const PaymentSheet({Key? key, this.paymentGatewayModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 100.w,
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
              child: Container(
                height: 10.h,
                width: 100.w,
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
                    buildSpaceHorizontal(3.w),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: ColorManager.halfWhiteColor,
                      child: Image.asset(AssetsManager.logo),
                    ),
                    buildSpaceHorizontal(5.w),
                    textStyle0_5(text: paymentGatewayModel![index].methodTitle!)
                  ],
                ),
              ),
            );
          }
      )
    );
  }
}
