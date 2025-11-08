import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Log In",
                      style: getTextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 40.h),

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

                    SizedBox(height: 8.h),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            controller.navigateToForgotPassword(context),
                        child: Text(
                          "Forget Password?",
                          style: getTextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    /// Login Button
                    CustomButton(
                      text: "Log in",
                      onTap: () => controller.loginUser(context),
                    ),

                    SizedBox(height: 28.h),

                    /// OR/Divider
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

                    /// Google Button
                    CustomButton(
                      text: "Continue with Google",
                      isOutlined: true,
                      icon: Image.asset(
                        IconsPath.google,
                        height: 16.h,
                        width: 16.w,
                      ),
                      onTap: () => controller.loginWithGoogle(context),
                    ),

                    SizedBox(height: 28.h),

                    /// Bottom Sign-up Text Button
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
