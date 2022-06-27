// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, unused_catch_clause, unused_local_variable
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topgrade/controllers/social_login_controller.dart';
import 'package:topgrade/routes/appPages.dart';

class FirebaseAuthController extends GetxController {
  var isDataSubmitting = false.obs;
  final SocialLoginController socialLoginController =
      Get.put(SocialLoginController());
  var isDataReadingCompleted = false.obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var verId = '';
  var authStatus = ''.obs;

  var auth = FirebaseAuth.instance;

  Rxn<User> firebaseUser = Rxn<User>();

  User? get userGetter => firebaseUser.value;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  Future<void> googleLogin() async {
    try {
      var googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential authResult =
          await auth.signInWithCredential(authCredential);
      await SocialLoginController().login(authResult.user!.email!);
      Get.snackbar(
        "SignedIn",
        "Signedin Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      print(error);
      Get.snackbar(
        'Failed',
        error.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final UserCredential authResult =
        await auth.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signOut() async {
    try {
      final googleSignin = GoogleSignIn();
      await googleSignin.signOut();
      await auth.signOut();
      await Get.offAllNamed(Paths.authView);
    } catch (e) {
      Get.snackbar("Error in Signing Out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
