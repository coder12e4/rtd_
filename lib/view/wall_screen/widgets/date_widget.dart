import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/color/colors.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
    return Container(
      height: 30.h,
      width: 120.w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: textFormBase),
      child: Center(
        child: Text(formattedDate, textAlign: TextAlign.center),
      ),
    );
  }
}
