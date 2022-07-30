import 'package:flutter/material.dart';
import 'package:mytopgrade/routes/appPages.dart';
import 'package:get/get.dart';

class SignUpResultScreen extends StatelessWidget {
  const SignUpResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 100, color: Colors.green),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Kindly Check your Email and Verify your Account \n Then Go to Login Screen and Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Paths.authView);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Go to Login Screen',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
