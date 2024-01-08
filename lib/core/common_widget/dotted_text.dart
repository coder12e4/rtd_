import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DashText extends StatelessWidget {
  const DashText({super.key});

  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 2.0,
      dashLength: 8.0,
    );
  }
}
