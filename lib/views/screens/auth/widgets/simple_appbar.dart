







import 'package:flutter/material.dart';
import '../../../../helpers/text_helper.dart';

class SimpleAppBar extends StatelessWidget {
  final String title;
  const SimpleAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: textStyle3(text: title),
      elevation: 0,
    );
  }
}
