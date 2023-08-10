import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

class DropedownWidget extends StatefulWidget {
  const DropedownWidget({
    super.key,

    // required this.dropDownList,
  });

  // final List dropDownList;

  @override
  State<DropedownWidget> createState() => _DropedownWidgetState();
}

class _DropedownWidgetState extends State<DropedownWidget> {
  String _selectedBloodGroup = 'A+';
  List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 290.w,
      decoration: BoxDecoration(
          color: textFormBase, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          value: _selectedBloodGroup,
          onChanged: (String? newValue) {
            setState(() {
              _selectedBloodGroup = newValue!;
            });
          },
          items: _bloodGroups.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
