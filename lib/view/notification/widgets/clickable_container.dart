import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/view/notification/widgets/notification_widget.dart';

import '../../../controller/loan/loan_request_detail_controller.dart';
import '../../../controller/notification/notification_controller.dart';
import '../../../helper/router.dart';
import '../../../util/toast.dart';

class ContainerWithClickable extends StatelessWidget {
  const ContainerWithClickable({
    super.key,
    this.title,
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.clikable,
    required this.controller,
    required this.index,
    this.onTap,
  });
  final String? title;
  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? clikable;
  final NotificationController controller;
  final int index;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    if (controller.notification!.data?[index].details?.loanRequestStatus == 0) {
      if (controller.notification!.data?[index].details?.suretyStatus == 0) {
        return NotificationContainer(
          onTap: onTap,
          controller: controller,
          index: index,
          title: title,
          clickable: clikable,
        );
      } else {
        return NotificationContainer(
          onTap: () {
            controller.markNotificationSeen(
              controller.notification!.data![index].id!,
            );

            Get.delete<LoanRequestDetailsController>(force: true);
            Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(), arguments: [
              controller.notification!.data![index].details!.id,
              false,
              2
            ]);
          },
          controller: controller,
          index: index,
          title: title,
          text1:
              'Loan Amount: ${controller.notification!.data?[index].details!.amount}',
          text2:
              'Purpose: ${controller.notification!.data?[index].details!.purpose}',
        );
      }
    } else if (controller
            .notification!.data?[index].details?.loanRequestStatus ==
        2) {
      return NotificationContainer(
        onTap: () {
          controller.markNotificationSeen(
            controller.notification!.data![index].id!,
          );
          Get.delete<LoanRequestDetailsController>(force: true);
          Get.toNamed(
            AppRouter.getLoanRequestDetailsRoutes(),
            arguments: [
              controller.notification!.data![index].details!.id,
              false,
              2
            ],
          );
        },
        controller: controller,
        index: index,
        title: title,
        text1:
            'Loan Amount: ${controller.notification!.data?[index].details!.amount}',
        text2:
            'Purpose: ${controller.notification!.data?[index].details!.purpose}',
        text3:
            "Reason for rejection: ${controller.notification!.data?[index].details?.adminRejectReason.toString() ?? "Not Available"}",
      );
    } else if (controller
            .notification!.data?[index].details?.loanRequestStatus ==
        1) {
      return NotificationContainer(
        onTap: () {
          if (controller.notification?.data?[index].type == 4) {
            controller.markNotificationSeen(
              controller.notification!.data![index].id!,
            );

            Get.delete<LoanRequestDetailsController>(force: true);
            Get.toNamed(
              AppRouter.getLoanRequestDetailsRoutes(),
              arguments: [
                controller.notification!.data![index].details!.id,
                false,
                2
              ],
            );
          }
        },
        controller: controller,
        index: index,
        title: title,
        text1:
            'Loan Amount: ${controller.notification!.data?[index].details!.amount}',
        text2:
            'Purpose: ${controller.notification!.data?[index].details!.purpose}',
      );
    } else if (controller
            .notification!.data?[index].details?.loanRequestStatus ==
        3) {
      return NotificationContainer(
        onTap: () {
          controller.markNotificationSeen(
            controller.notification!.data![index].id!,
          );

          Get.delete<LoanRequestDetailsController>(force: true);
          Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(), arguments: [
            controller.notification!.data![index].details!.id,
            false,
            2
          ]);
        },
        controller: controller,
        index: index,
        title: title,
        text1:
            'Loan Amount: ${controller.notification!.data?[index].details!.amount}',
        text2:
            'Purpose: ${controller.notification!.data?[index].details!.purpose}',
      );
    }
    return NotificationContainer(
      onTap: () {
        if (controller.notification!.data![index].details == null) {
          showToast('Loan details not available from the server');
          return;
        } else {
          controller.markNotificationSeen(
            controller.notification!.data![index].id!,
          );

          Get.delete<LoanRequestDetailsController>(force: true);
          Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(), arguments: [
            controller.notification!.data![index].details!.id,
            false,
            2
          ]);
        }
      },
      controller: controller,
      index: index,
      title: title,
      text1:
          'Loan Amount: ${controller.notification!.data?[index].details?.amount ?? "Not Available"}',
      text2:
          'Purpose: ${controller.notification!.data?[index].details?.purpose ?? "Not Available"}',
    );
  }
}
