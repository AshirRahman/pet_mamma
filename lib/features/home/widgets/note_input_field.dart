import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/common/styles/global_text_style.dart';

class NoteInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const NoteInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: getTextStyle(),
      decoration: InputDecoration(
        hintText: 'Write a new note...',
        hintStyle: getTextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        suffixIcon: IconButton(
          icon: Icon(Icons.send, color: Colors.blueAccent, size: 20.sp),
          onPressed: onSend,
        ),
      ),
    );
  }
}
