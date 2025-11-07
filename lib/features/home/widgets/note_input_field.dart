import 'package:flutter/material.dart';
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send, color: Colors.blueAccent),
          onPressed: onSend,
        ),
      ),
    );
  }
}
