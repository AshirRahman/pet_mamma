import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/utils/icons_path.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Create Account",
                      style: getTextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    /// Name
                    CustomTextField(
                      controller: controller.nameController,
                      hintText: "Full Name",
                    ),
                    SizedBox(height: 16.h),

                    /// Email
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),

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
                    SizedBox(height: 16.h),

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

                    SizedBox(height: 28.h),

                    /// Sign Up Button
                    CustomButton(
                      text: "Sign Up",
                      onTap: () => controller.signupUser(context),
                    ),

                    const SizedBox(height: 28),

                    /// Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "or",
                            style: getTextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    SizedBox(height: 28.h),

                    /// Google SignUp Button
                    CustomButton(
                      text: "Continue with Google",
                      isOutlined: true,
                      icon: Image.asset(
                        IconsPath.google,
                        height: 16.h,
                        width: 16.w,
                      ),
                      onTap: () => controller.signUpWithGoogle(context),
                    ),

                    SizedBox(height: 30.h),

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
