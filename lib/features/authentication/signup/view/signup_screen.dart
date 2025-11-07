import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/utils/icons_path.dart' show IconsPath;
import 'package:pet_mamma/core/common/styles/global_text_style.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupController(),
      child: Consumer<SignupController>(
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
                      "Create Account",
                      style: getTextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// Name
                    CustomTextField(
                      controller: controller.nameController,
                      hintText: "Full Name",
                    ),
                    const SizedBox(height: 16),

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
                    const SizedBox(height: 16),

                    /// Confirm Password
                    CustomTextField(
                      controller: controller.confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: !controller.isConfirmPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// Sign Up Button
                    controller.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: "Sign Up",
                            onTap: () => controller.signupUser(context),
                          ),

                    const SizedBox(height: 28),

                    /// Divider
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

                    /// Google SignUp Button
                    CustomButton(
                      text: "Continue with Google",
                      isOutlined: true,
                      icon: Image.asset(
                        IconsPath.google,
                        height: 24,
                        width: 24,
                      ),
                      onTap: () => controller.signUpWithGoogle(context),
                    ),

                    const SizedBox(height: 30),

                    /// Bottom text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: getTextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () => controller.navigateToLogin(context),
                          child: Text(
                            "Log in Now",
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
