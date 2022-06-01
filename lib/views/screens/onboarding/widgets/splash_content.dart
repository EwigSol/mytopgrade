

import 'package:flutter/material.dart';
import '../../../../helpers/helper.dart';
import '../../../../helpers/text_helper.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/strings_manager.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key, this.text, this.image}) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildSpaceVertical(MediaQuery.of(context).size.height * 0.08),
        textStyle5(color: ColorManager.primaryColor, text: StringsManager.appName),
        buildSpaceVertical(MediaQuery.of(context).size.height * 0.04),
        Center(child: textStyle1(text: text!, textAlign: TextAlign.center)),
        buildSpaceVertical(MediaQuery.of(context).size.height * 0.10),
        Image.asset(image!, height: MediaQuery.of(context).size.height * 0.32, width: MediaQuery.of(context).size.width * 0.70),
      ],
    );
  }
}