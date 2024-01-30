import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

import '../../../backend/model/notification_model/notification_model.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    notificationDetails data = Get.arguments[0];
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: Column(
          children: [
            appbar(context),
            Container(
              padding: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
              height: 920.h,
              width: 390.w,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(50),
                    topEnd: Radius.circular(50),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.message ?? "Not Available",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  kSizedBoxH,
                  detailsWidget(
                    title: "Date",
                    content: data.date,
                  ),
                  kSizedBoxH,
                  detailsWidget(
                    title: "From",
                    content: data.sender,
                  ),
                  kSizedBoxH20,
                  const Text(
                    "Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  kSizedBoxH,
                  detailsWidget(
                    title: "Amount",
                    content: data.details?.amount,
                  ),
                  detailsWidget(
                    title: "Purpose",
                    content: data.details?.purpose,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row detailsWidget({String? title, String? content}) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black.withOpacity(.7)),
        ),
        Text(
          content ?? "Not available",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ],
    );
  }

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
                size: 30,
              )),
          SizedBox(
            width: 60.w,
          ),
          Text(
            'Notification Details',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
