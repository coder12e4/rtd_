import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rtd_project/controller/loan/loan_request_detail_controller.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/appbar.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/notification/widgets/clickable_container.dart';
import 'package:rtd_project/view/notification/widgets/notification_widget.dart';

import '../../backend/model/notification_model/notification_model.dart';
import '../../controller/loan/profile_loan_data_controller.dart';
import '../../controller/notification/surety_view_controller.dart';
import '../../core/common_widget/notification_icon.dart';
import '../../helper/router.dart';
import 'notification_details_screen/notification_details.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        log('hii$didPop');
        Get.offAllNamed(AppRouter.getBottomNavRoute(), arguments: [0]);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: baseColor,
          body: GetBuilder<NotificationController>(
            builder: (controller) {
              List<notificationDetails> notificationList =
                  controller.notification?.data ?? [];
              return controller.loading != true
                  ? Column(
                      children: [
                        CustomAppBar(
                            leading: IconButton(
                              onPressed: () {
                                Get.offAllNamed(AppRouter.getBottomNavRoute(),
                                    arguments: [0]);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: whiteColor,
                                size: 30,
                              ),
                            ),
                            title: 'Notification',
                            trailing: const NotificationIcon()
                            // trailing: Stack(
                            //   alignment: AlignmentDirectional.center,
                            //   children: [
                            //     IconButton(
                            //       onPressed: () {
                            //         // Get.toNamed(AppRouter.getSuretyRequestDetailsRoute());
                            //       },
                            //       icon: const Icon(
                            //         Icons.notifications_none,
                            //         color: whiteColor,
                            //         size: 35,
                            //       ),
                            //     ),
                            //     controller.notificationCount != 0
                            //         ? Positioned(
                            //             top: 3.h,
                            //             right: 4.w,
                            //             child: Container(
                            //               height: 20.h,
                            //               width: 20.w,
                            //               decoration: const BoxDecoration(
                            //                   color: Colors.red,
                            //                   shape: BoxShape.circle),
                            //               child: Center(
                            //                   child: Text(
                            //                 '${controller.notificationCount ?? 0}',
                            //                 style: const TextStyle(
                            //                     color: whiteColor,
                            //                     fontWeight: FontWeight.bold),
                            //               )),
                            //             ),
                            //           )
                            //         : const Offstage(),
                            //   ],
                            // ),
                            ),
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
                            child: notificationList.isNotEmpty
                                ? ListView.separated(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    shrinkWrap: true,
                                    itemCount: notificationList!.length,
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        kSizedBoxH,
                                    itemBuilder: (context, index) {
                                      final type = notificationList[index].type;
                                      if (type == 4) {
                                        return ContainerWithClickable(
                                          onTap: () {
                                            controller.markNotificationSeen(
                                              notificationList[index].id!,
                                            );

                                            Get.delete<SuretyViewController>(
                                                force: true);
                                            Get.toNamed(
                                                AppRouter
                                                    .getSuretyRequestDetailsRoute(),
                                                arguments: [
                                                  notificationList[index]
                                                      .details
                                                      ?.id,
                                                  notificationList[index],
                                                  false,
                                                  2
                                                ]);
                                          },
                                          controller: controller,
                                          index: index,
                                          title:
                                              notificationList[index].message,
                                          clikable: 'View Details',
                                        );
                                      } else if (type == 2) {
                                        return NotificationContainer(
                                          onTap: () {
                                            controller.markNotificationSeen(
                                              notificationList[index].id!,
                                            );
                                            Get.delete<
                                                    ProfileLoanDataController>(
                                                force: true);
                                            Get.toNamed(
                                                AppRouter
                                                    .getProfileLoanDetailsRoute(),
                                                arguments: [
                                                  notificationList[index]
                                                      .details!
                                                      .id!
                                                ]);
                                          },
                                          height: 110.h,
                                          title:
                                              notificationList[index].message,
                                          controller: controller,
                                          index: index,
                                          text2:
                                              'Loan Amount :  ${notificationList[index].details!.amount}',
                                          text3:
                                              'Purpose : ${notificationList[index].details!.purpose}',
                                          text4:
                                              'Repayment Date :${notificationList[index].details!.dueDate}',
                                        );
                                      } else if (type == 1) {
                                        return NotificationContainer(
                                          onTap: () {
                                            controller.markNotificationSeen(
                                              notificationList[index].id!,
                                            );
                                            Get.delete<
                                                    LoanRequestDetailsController>(
                                                force: true);
                                            Get.toNamed(
                                                AppRouter
                                                    .getLoanRequestDetailsRoutes(),
                                                arguments: [
                                                  notificationList[index]
                                                      .details!
                                                      .id,
                                                  true,
                                                  2
                                                ]);
                                          },
                                          height: 110.h,
                                          title:
                                              notificationList[index].message,
                                          controller: controller,
                                          index: index,
                                          text2:
                                              'Loan Amount : ${notificationList[index].details?.amount ?? "NA"}',
                                          text3:
                                              'Purpose :  ${notificationList[index].details?.purpose ?? "NA"}',
                                        );
                                      } else if (type == 3) {
                                        final inputFormat =
                                            notificationList[index]
                                                .date
                                                .toString();
                                        return NotificationContainer(
                                          onTap: () {
                                            controller.markNotificationSeen(
                                                notificationList[index].id!);
                                            Get.delete<SuretyViewController>(
                                                force: true);
                                            Get.toNamed(
                                                AppRouter
                                                    .getNotificationPollRoute(),
                                                arguments: [
                                                  notificationList[index]
                                                      .details!
                                                      .id,
                                                  null,
                                                  true,
                                                  2,
                                                ]);
                                          },
                                          height: 110.h,
                                          index: index,
                                          controller: controller,
                                          title:
                                              notificationList[index].message,
                                          endDate: inputFormat,
                                          clickable: 'View Details',
                                        );
                                      } else if (type == 6) {
                                        return NotificationContainer(
                                          onTap: () {
                                            controller.markNotificationSeen(
                                                notificationList[index].id!);
                                            Get.delete<
                                                    ProfileLoanDataController>(
                                                force: true);
                                            Get.toNamed(
                                                AppRouter
                                                    .getProfileLoanDetailsRoute(),
                                                arguments: [
                                                  notificationList[index]
                                                      .details!
                                                      .id!
                                                ]);
                                          },
                                          height: 70.h,
                                          title:
                                              notificationList[index].message,
                                          text1:
                                              "Date : ${notificationList[index].date}",
                                          controller: controller,
                                          index: index,
                                        );
                                      }
                                      return ContainerWithClickable(
                                        onTap: () {
                                          controller.markNotificationSeen(
                                            notificationList[index].id!,
                                          );
                                          Get.to(
                                              const NotificationDetailsScreen(),
                                              arguments: [
                                                notificationList[index]
                                              ]);
                                        },
                                        title: notificationList[index].message,
                                        controller: controller,
                                        index: index,
                                      );
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
      ),
    );
  }
}
