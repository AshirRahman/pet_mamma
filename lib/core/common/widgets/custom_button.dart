import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/styles/global_text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isOutlined;
  final Color? color;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isOutlined = false,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isOutlined ? Colors.white : (color ?? Colors.blue),
          borderRadius: BorderRadius.circular(12.r),
          border: isOutlined
              ? Border.all(color: Colors.grey.shade400, width: 1.2.w)
              : null,
          boxShadow: isOutlined
              ? []
              : [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.2),
                    spreadRadius: 1.r,
                    blurRadius: 6.r,
                    offset: Offset(0, 3.h),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 8.w)],
            Text(
              text,
              style: getTextStyle(
                color: isOutlined ? Colors.black87 : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
