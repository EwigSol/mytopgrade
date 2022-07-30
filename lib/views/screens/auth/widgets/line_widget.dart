



import 'package:flutter/material.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../utils/values_manager.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textStyle0(text: "--------------------"),
          Container(),
          textStyle0(text: "--------------------"),
        ],
      ),
    );
  }
}
