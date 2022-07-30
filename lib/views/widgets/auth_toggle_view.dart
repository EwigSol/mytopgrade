import 'package:flutter/material.dart';
import 'package:mytopgrade/views/screens/auth/register_screen.dart';

import '../screens/auth/login_screen.dart';

class AuthToggleView extends StatefulWidget {
  const AuthToggleView({Key? key}) : super(key: key);

  @override
  _AuthToggleViewState createState() => _AuthToggleViewState();
}

class _AuthToggleViewState extends State<AuthToggleView> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(
        toggleView: toggleView,
      );
    } else {
      return RegisterScreen(toggleView: toggleView);
    }
  }
}
