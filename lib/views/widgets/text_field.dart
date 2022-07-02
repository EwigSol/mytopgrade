// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mytopgrade/utils/color_manager.dart';
import 'package:mytopgrade/utils/values_manager.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintName;
  final TextInputType inputType;
  final bool isEnable;
  final int inputLines;
  final Color color;
  final bool isPass;
  late bool passwordVisibility;

  CustomTextField({
    Key? key,
    this.controller,
    this.hintName,
    this.isPass = false,
    this.passwordVisibility = false,
    this.inputType = TextInputType.text,
    this.isEnable = true,
    this.inputLines = 1,
    this.color = ColorManager.whiteColor,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPass ? !widget.passwordVisibility : false,
        enabled: widget.isEnable,
        keyboardType: widget.inputType,
        maxLines: widget.inputLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.hintName}';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.grayColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.grayColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.grayColor),
          ),
          suffixIcon: widget.isPass
              ? IconButton(
                  icon: Icon(
                    widget.passwordVisibility
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: ColorManager.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.passwordVisibility = !widget.passwordVisibility;
                    });
                  },
                )
              : const SizedBox.shrink(),
          hintText: widget.hintName,
          hintStyle: const TextStyle(fontSize: AppSize.s12),
          fillColor: widget.color,
          filled: true,
        ),
      ),
    );
  }
}
