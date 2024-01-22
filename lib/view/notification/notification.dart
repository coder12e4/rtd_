import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rtd_project/controller/loan/loan_request_detail_controller.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/notification/widgets/notification_widget.dart';

import '../../controller/notification/surety_view_controller.dart';
import '../../helper/router.dart';
import 'notification_details_screen/notification_details.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool clikable = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: GetBuilder<NotificationController>(
          builder: (controller) {
            return controller.loading != true
                ? Column(
                    children: [
                      appbar(context, controller),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 7.h, left: 20.w, right: 20.w),
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(50),
                              topEnd: Radius.circular(50),
                            ),
                          ),
                          child: controller.notification?.data?.length != 0
                              ? ListView.separated(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.notification!.data!.length,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      kSizedBoxH,
                                  itemBuilder: (context, index) {
                                    final type = controller
                                        .notification?.data?[index].type;
                                    if (type == 4) {
                                      return containerWithClickable(
                                        onTap: () {
                                          controller.markNotificationSeen(
                                            controller
                                                .notification!.data![index].id!,
                                          );

                                          Get.delete<SuretyViewController>(
                                              force: true);
                                          Get.toNamed(
                                              AppRouter
                                                  .getSuretyRequestDetailsRoute(),
                                              arguments: [
                                                controller.notification!
                                                    .data![index].details?.id,
                                                controller
                                                    .notification!.data![index],
                                                false
                                              ]);
                                        },
                                        90.h,
                                        controller
                                            .notification?.data?[index].message,
                                        clikable: 'View Details',
                                        index: index,
                                        controller: controller,
                                      );
                                    } else if (type == 2) {
                                      return NotificationContainer(
                                        onTap: () {
                                          controller.markNotificationSeen(
                                            controller
                                                .notification!.data![index].id!,
                                          );
                                          Get.toNamed(
                                              AppRouter
                                                  .getProfileLoanDetailsRoute(),
                                              arguments: [
                                                controller.notification!
                                                    .data![index].details!.id!
                                              ]);
                                        },
                                        height: 110.h,
                                        title: controller
                                            .notification?.data?[index].message,
                                        controller: controller,
                                        index: index,
                                        text2:
                                            'Loan Amount :  ${controller.notification?.data?[index].details!.amount}',
                                        text3:
                                            'Purpose : ${controller.notification?.data?[index].details!.purpose}',
                                        text4:
                                            'Repayment Date :${controller.notification?.data?[index].details!.dueDate}',
                                      );
                                    } else if (type == 1) {
                                      return NotificationContainer(
                                        onTap: () {
                                          controller.markNotificationSeen(
                                            controller
                                                .notification!.data![index].id!,
                                          );
                                          Get.delete<
                                                  LoanRequestDetailsController>(
                                              force: true);
                                          Get.toNamed(
                                              AppRouter
                                                  .getLoanRequestDetailsRoutes(),
                                              arguments: [
                                                controller.notification!
                                                    .data![index].details!.id,
                                                true
                                              ]);
                                        },
                                        height: 110.h,
                                        title: controller
                                            .notification?.data?[index].message,
                                        controller: controller,
                                        index: index,
                                        text2:
                                            'Loan Amount : ${controller.notification?.data?[index].details?.amount ?? "NA"}',
                                        text3:
                                            'Purpose :  ${controller.notification?.data?[index].details?.purpose ?? "NA"}',
                                      );
                                    } else if (type == 3) {
                                      final inputFormat = controller
                                          .notification!.data?[index].date
                                          .toString();
                                      return NotificationContainer(
                                        onTap: () {
                                          controller.markNotificationSeen(
                                              controller.notification!
                                                  .data![index].id!);
                                          Get.delete<SuretyViewController>(
                                              force: true);
                                          Get.toNamed(
                                              AppRouter
                                                  .getNotificationPollRoute(),
                                              arguments: [
                                                controller.notification!
                                                    .data?[index].details!.id,
                                                null,
                                                true
                                              ]);
                                        },
                                        height: 110.h,
                                        index: index,
                                        controller: controller,
                                        title: controller
                                            .notification?.data?[index].message,
                                        endDate: inputFormat,
                                        clickable: 'View Details',
                                      );
                                    } else if (type == 6) {
                                      return NotificationContainer(
                                        onTap: () => controller
                                            .markNotificationSeen(controller
                                                .notification!
                                                .data![index]
                                                .id!),
                                        height: 70.h,
                                        title: controller
                                            .notification?.data?[index].message,
                                        text1:
                                            "Date : ${controller.notification?.data?[index].date}",
                                        controller: controller,
                                        index: index,
                                      );
                                    }
                                    return containerWithClickable(onTap: () {
                                      controller.markNotificationSeen(
                                        controller
                                            .notification!.data![index].id!,
                                      );
                                      Get.to(const NotificationDetailsScreen(),
                                          arguments: [
                                            controller
                                                .notification!.data![index]
                                          ]);
                                    },
                                        110.h,
                                        controller
                                            .notification?.data?[index].message,
                                        controller: controller,
                                        index: index);
                                  },
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 180.h,
                                      width: double.infinity,
                                    ),
                                    Lottie.asset(
                                        'assets/images/no_notification.json',
                                        height: 200.h),
                                    const Text(
                                      'Notifications is empty',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    color: ThemeProvider.whiteColor,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        color: ThemeProvider.blackColor,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  containerWithClickable(
    height,
    title, {
    text1,
    text2,
    text3,
    text4,
    clikable,
    required NotificationController controller,
    required int index,
    Function()? onTap,
  }) {
    if (controller.notification!.data?[index].details?.loanRequestStatus == 0) {
      return Container(
        height: height,
        width: 300.w,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 223, 220, 220),
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      EdgeInsets.only(left: 28.0.w, right: 15.w, top: 10.h),
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
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
                  InkWell(
                    onTap: onTap,
                    child: Text(
                      clikable ?? '',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if (controller
            .notification!.data?[index].details?.loanRequestStatus ==
        2) {
      return Container(
        height: height + 50,
        width: 300.w,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 223, 220, 220),
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0.w, right: 15.w, top: 10.h),
                    child: Text(
                      title,
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
                  Text(
                      'Loan Amount: ${controller.notification!.data?[index].details!.amount}'),
                  Text(
                      'Purpose: ${controller.notification!.data?[index].details!.purpose}'),
                  kSizedBoxH,
                  const Text(
                    'Reason for rejection',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(controller
                          .notification!.data?[index].details?.adminRejectReason
                          .toString() ??
                      "Not Available"),
                ],
              ),
            )
          ],
        ),
      );
    } else if (controller
            .notification!.data?[index].details?.loanRequestStatus ==
        1) {
      return GestureDetector(
        onTap: () {
          if (controller.notification?.data?[index].type == 4) {
            Get.delete<LoanRequestDetailsController>(force: true);
            Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(), arguments: [
              controller.notification!.data![index].details!.id,
              false
            ]);
          }
        },
        child: Container(
          height: height,
          width: 300.w,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 220, 220),
              borderRadius: BorderRadiusDirectional.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0.w, right: 15.w, top: 10.h),
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
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
                    Text(
                        'Loan Amount: ${controller.notification!.data?[index].details!.amount}'),
                    Text(
                        'Purpose: ${controller.notification!.data?[index].details!.purpose}')
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        Get.delete<LoanRequestDetailsController>(force: true);
        Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(), arguments: [
          controller.notification!.data![index].details!.id,
          false
        ]);
      },
      child: Container(
        height: height,
        width: 300.w,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 223, 220, 220),
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      EdgeInsets.only(left: 28.0.w, right: 15.w, top: 10.h),
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
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
                  Text(
                      'Loan Amount: ${controller.notification!.data?[index].details?.amount ?? "Not Available"}'),
                  Text(
                      'Purpose: ${controller.notification!.data?[index].details?.purpose ?? "Not Available"}')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container appbar(BuildContext context, NotificationController controller) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
                size: 30,
              )),
          Text(
            'Notification',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              IconButton(
                onPressed: () {
                  // Get.toNamed(AppRouter.getSuretyRequestDetailsRoute());
                },
                icon: const Icon(
                  Icons.notifications_none,
                  color: whiteColor,
                  size: 35,
                ),
              ),
              controller.notificationCount != 0
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
                          '${controller.notificationCount ?? 0}',
                          style: const TextStyle(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  : const Offstage(),
            ],
          ),
        ],
      ),
    );
  }
}
