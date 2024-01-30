import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/network_controller/network_controller.dart';

import '../../controller/notification/notification_controller.dart';
import '../../helper/router.dart';
import '../color/colors.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.delete<NotificationController>(force: true);
        Get.toNamed(AppRouter.getNotificationPageRoute());
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications_none,
              color: whiteColor,
              size: 35,
            ),
          ),
          GetBuilder<NetworkController>(builder: (value) {
            return value.notificationCount != 0
                ? Positioned(
                    top: 3.h,
                    right: 4.w,
                    child: Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        '${value.notificationCount ?? 0}',
                        style: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                : const Offstage();
          }),
        ],
      ),
    );
  }
}
