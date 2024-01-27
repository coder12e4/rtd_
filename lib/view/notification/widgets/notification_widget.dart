import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/notification/notification_controller.dart';
import '../../../core/constraints/conatrints.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer(
      {super.key,
      this.height,
      this.title,
      this.text1,
      this.text2,
      this.text3,
      this.text4,
      this.clickable,
      this.endDate,
      this.onTap,
      required this.controller,
      required this.index});
  final double? height;
  final String? title;
  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? clickable;
  final String? endDate;
  final Function()? onTap;
  final NotificationController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height! + 12.h,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 223, 220, 220),
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0.w, right: 15.w, top: 10.h),
                    child: Text(
                      title ?? "Not Available",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.w),
                  height: 7.h,
                  width: 7.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.notification?.data?[index].seen == 1
                        ? Colors.grey
                        : Colors.red,
                  ),
                )
              ],
            ),
            kSizedBoxH,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  endDate != null
                      ? Text("End Date: $endDate")
                      : const Offstage(),
                  clickable != null ? kSizedBoxH : const Offstage(),
                  clickable != null
                      ? Text(
                          clickable!,
                          style: const TextStyle(color: Colors.blue),
                        )
                      : const Offstage(),
                  text1 != null
                      ? Text(
                          text1!,
                        )
                      : const Offstage(),
                  text2 != null
                      ? Text(
                          text2!,
                        )
                      : const Offstage(),
                  text3 != null
                      ? Text(
                          text3!,
                        )
                      : const Offstage(),
                  text4 != null
                      ? Text(
                          text4!,
                        )
                      : const Offstage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
