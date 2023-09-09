import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hitText,
    required this.validator,
  });
  final TextEditingController controller;
  final String hitText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    FocusNode node = FocusNode();
    return Container(
      width: 290.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          validator: validator,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              border: InputBorder.none, // Removes the underline
              hintText: hitText,
              fillColor: textFormBase,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textFormBase),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: textFormBase),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: textFormBase),
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: textFormBase),
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 112, 111, 111),
                  fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center, // Centers the text inside the field
        ),
      ),
    );
  }
}
