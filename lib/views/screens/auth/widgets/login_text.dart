import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytopgrade/utils/color_manager.dart';

class LoginText extends StatelessWidget {
  final Function toggleView;
  const LoginText({Key? key, required this.toggleView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Already have an account?  ',
            style: GoogleFonts.poppins(
              color: ColorManager.blackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'Sign in',
                  style: GoogleFonts.poppins(
                      color: ColorManager.primaryColor,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      toggleView();
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
