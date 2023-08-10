import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hitText,
  });
  final TextEditingController controller;
  final String hitText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 330.w,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 209, 209).withOpacity(0.4),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none, // Removes the underline
              hintText: hitText,
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 112, 111, 111),
                  fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center, // Centers the text inside the field
        ),
      ),
    );
  }
}
