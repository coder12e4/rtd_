import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

class RadioButtonWidgetNotification extends StatefulWidget {
  const RadioButtonWidgetNotification({Key? key, required this.text});
  final String text;
  @override
  State<RadioButtonWidgetNotification> createState() =>
      RadioButtonWidgetNotificationState();
}

class RadioButtonWidgetNotificationState
    extends State<RadioButtonWidgetNotification> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected; // Toggle the selection state
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 18.0.w,
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<String>(
              // The actual Radio widget
              value: 'accepted',
              groupValue: _isSelected
                  ? 'accepted'
                  : '', // Use groupValue based on _isSelected
              onChanged: (String? newValue) {
                setState(() {
                  _isSelected = !_isSelected; // Toggle the selection state
                });
              },
            ),
            const SizedBox(width: 5),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  // Adjust the text styling as needed
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
