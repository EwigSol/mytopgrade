import 'package:flutter/material.dart';
import '../../../../helpers/text_helper.dart';
import 'package:get/get.dart';

class SimpleAppBar extends StatelessWidget {
  final String title;
  const SimpleAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: textStyle3(text: title),
      elevation: 6,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}
