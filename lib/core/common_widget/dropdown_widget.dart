import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

class DropedownWidget extends StatefulWidget {
  const DropedownWidget({super.key, required this.hintText, required this.dropDownlist});
  final String hintText;
 final List<String> dropDownlist;
  @override
  State<DropedownWidget> createState() => _DropedownWidgetState();
}

class _DropedownWidgetState extends State<DropedownWidget> {
  String _selectedBloodGroup = 'Select a blood group'; // Initial hint text
  //  List<String> _bloodGroups = [
  //   'A+',
  //   'A-',
  //   'B+',
  //   'B-',
  //   'AB+',
  //   'AB-',
  //   'O+',
  //   'O-',
  // ];
 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 290.w,
      decoration: BoxDecoration(
        color: textFormBase,
        borderRadius: BorderRadius.circular(20),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: DropdownButton<String>(
      //     onChanged: (String? newValue) {
      //       setState(() {
      //         _selectedBloodGroup = newValue!;
      //       });
      //     },
      //     items: _bloodGroups.map<DropdownMenuItem<String>>((String value) {
      //       return DropdownMenuItem<String>(
      //         value: value,
      //         child: Text(value),
      //       );
      //     }).toList(),
      //   ),
      child: Center(
        child: DropdownButton<String>(
          value: _selectedBloodGroup, // Set the initial value (hint text)
          onChanged: (String? newValue) {
            setState(() {
              _selectedBloodGroup = newValue!;
            });
          },
          items: [
            // Add a dummy item with hint text as the first option
            DropdownMenuItem<String>(
              value:
                  'Select a blood group', // This value doesn't have to match any real value
              alignment: Alignment.center,
              child: Text(widget.hintText),
            ),
            // Generate other blood group options
            ...widget.dropDownlist.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                alignment: Alignment.center,
                value: value,
                child: Text(value),
              );
            }
            )
          ],
        ),
      ),
    );
  }
}
