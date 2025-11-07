import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/utils/icons_path.dart';
import '../controller/login_controller.dart';
import '../../../../core/common/styles/global_text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: Consumer<LoginController>(
        builder: (context, controller, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Log In",
                      style: getTextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Email
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    /// Password
                    CustomTextField(
                      controller: controller.passwordController,
                      hintText: "Password",
                      obscureText: !controller.isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            controller.navigateToForgotPassword(context),
                        child: Text(
                          "Forget Password?",
                          style: getTextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Login Button
                    CustomButton(
                      text: "Log in",
                      onTap: () => controller.loginUser(context),
                    ),

                    const SizedBox(height: 28),

                    /// OR/Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "or",
                            style: getTextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 28),

                    /// Google Button
                    CustomButton(
                      text: "Continue with Google",
                      isOutlined: true,
                      icon: Image.asset(
                        IconsPath.google,
                        height: 24,
                        width: 24,
                      ),
                      onTap: () => controller.loginWithGoogle(context),
                    ),

                    const SizedBox(height: 28),

                    /// Bottom Sign-up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have an account? ",
                          style: getTextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () => controller.navigateToSignup(context),
                          child: Text(
                            "Sign-up Now.",
                            style: getTextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
