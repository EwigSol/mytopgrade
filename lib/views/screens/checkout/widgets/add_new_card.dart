import 'package:flutter/material.dart';
import 'package:mytopgrade/helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/strings_manager.dart';
import '../../../../utils/values_manager.dart';
import '../../../widgets/text_field.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final cardNoController = TextEditingController();
  final cardNameController = TextEditingController();
  final expireController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  color: ColorManager.redColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p12, top: AppPadding.p12),
                    child: Icon(Icons.account_balance_wallet_rounded,
                        color: ColorManager.whiteColor),
                  ),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.03),
                  Center(
                      child: textStyle11(
                          text: "2346 **** **** 9834",
                          color: ColorManager.whiteColor)),
                  buildSpaceVertical(MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textStyle0(
                                text: "Card Holder",
                                color: ColorManager.whiteColor),
                            textStyle0_5(
                                text: "Zain Ullah",
                                color: ColorManager.whiteColor)
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textStyle0(
                                text: "Expires",
                                color: ColorManager.whiteColor),
                            textStyle0_5(
                                text: "15/26", color: ColorManager.whiteColor)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildSpaceVertical(MediaQuery.of(context).size.height * 0.05),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: ColorManager.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                child: Column(
                  children: [
                    buildSpaceVertical(
                        MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      controller: cardNoController,
                      hintName: StringsManager.cardNo,
                    ),
                    buildSpaceVertical(
                        MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      controller: cardNameController,
                      hintName: StringsManager.cardNa,
                    ),
                    buildSpaceVertical(
                        MediaQuery.of(context).size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: CustomTextField(
                            controller: expireController,
                            hintName: StringsManager.expire,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: CustomTextField(
                            controller: cvvController,
                            hintName: StringsManager.cvv,
                          ),
                        ),
                      ],
                    ),
                    buildSpaceVertical(
                        MediaQuery.of(context).size.height * 0.03),
                    Center(
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle2(text: StringsManager.addNew),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: ColorManager.blackColor),
    );
  }
}
