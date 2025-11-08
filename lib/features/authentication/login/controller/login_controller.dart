import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../routes/app_routes.dart';

class LoginController with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Email & Password Login
  Future<void> loginUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      EasyLoading.showError("Please fill all fields");
      return;
    }

    _setLoading(true);
    EasyLoading.show(status: "Logging in...");

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      debugPrint("Login successful: $user");

      EasyLoading.showSuccess("Login successful!");
      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showError("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError("Wrong password.");
      } else {
        EasyLoading.showError("Login failed: ${e.message}");
        debugPrint("Login failed: ${e.message}");
      }
    } finally {
      _setLoading(false);
      EasyLoading.dismiss();
    }
  }

  /// Google Login
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      EasyLoading.show(status: 'Signing in...');
      _setLoading(true);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        EasyLoading.dismiss();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      debugPrint("Google sign-in successful");
      debugPrint("Name: ${user?.displayName}");
      debugPrint("Email: ${user?.email}");
      debugPrint("Photo: ${user?.photoURL}");

      EasyLoading.showSuccess("Signed in with Google!");
      await Future.delayed(const Duration(milliseconds: 800));

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError("Firebase error: ${e.message}");
    } catch (e) {
      EasyLoading.showError("Google sign-in failed: $e");
      log("Google sign-in failed: $e");
    } finally {
      _setLoading(false);
      EasyLoading.dismiss();
    }
  }

  void navigateToSignup(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  void navigateToForgotPassword(BuildContext context) {
    EasyLoading.showInfo("Forgot Password tapped");
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
