import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';

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
        body: GetBuilder<NotificationController>(builder: (controller) {
          return controller.loading != true
              ? Column(
                  children: [
                    appbar(context, controller),
                    Container(
                      padding: EdgeInsets.only(top: 10.h),
                      height: MediaQuery.sizeOf(context).height * 0.877,
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(50),
                          topEnd: Radius.circular(50),
                        ),
                      ),
                      child: controller.notification?.data?.length != 0
                          ? ListView.separated(
                              shrinkWrap: true,

                              itemCount:
                                  controller.notification?.data?.length ?? 0,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => kSizedBoxH,
                              itemBuilder: (context, index) {
                                final type =
                                    controller.notification?.data?[index].type;
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
                                    100.h,
                                    controller
                                        .notification?.data?[index].message,
                                    clikable: 'View Details',
                                    index: index,
                                    controller: controller,
                                  );
                                } else if (type == 2) {
                                  return textContainer(
                                    onTap: () {
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
                                    // text1: 'Loan Number : 0123',
                                    text2:
                                        'Loan Amount :  ${controller.notification?.data?[index].details!.amount}',
                                    text3:
                                        'Purpose : ${controller.notification?.data?[index].details!.purpose}',

                                    // text4: 'Repayment Date : 20/12/2023',
                                    controller: controller,
                                    index: index,
                                  );
                                } else if (type == 1) {
                                  return textContainer(
                                    onTap: () {
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
                                    // text1: 'Loan Number : 0123',
                                    text2:
                                        'Loan Amount : ${controller.notification?.data?[index].details!.amount}',
                                    text3:
                                        'Purpose :  ${controller.notification?.data?[index].details!.purpose}',
                                    controller: controller,
                                    index: index,
                                  );
                                } else if (type == 3) {
                                  final inputFormat = controller
                                      .notification!.data?[index].date
                                      .toString();
                                  // String formattedDate =
                                  //     DateFormat('dd-MM-yyyy').format(
                                  //         DateTime.parse(inputFormat!));
                                  return GestureDetector(
                                    onTap: () {
                                      controller.markNotificationSeen(controller
                                          .notification!.data![index].id!);
                                      Get.toNamed(
                                          AppRouter.getNotificationPollRoute(),
                                          arguments: [
                                            controller.notification!
                                                .data?[index].details!.id,
                                            null,
                                            true
                                          ]);
                                    },
                                    child: textContainer(
                                        100.h,
                                        controller
                                            .notification?.data?[index].message,
                                        controller: controller,
                                        index: index,
                                        endDate: inputFormat,
                                        clickable: 'View Details'),
                                  );
                                }
                                return containerWithClickable(onTap: () {
                                  controller.markNotificationSeen(
                                    controller.notification!.data![index].id!,
                                  );
                                  Get.to(const NotificationDetailsScreen(),
                                      arguments: [
                                        controller.notification!.data![index]
                                      ]);
                                },
                                    40.h,
                                    controller
                                        .notification?.data?[index].message,
                                    controller: controller,
                                    index: index);
                                // return textContainer(
                                //   40.h,
                                //   controller.notification?.data?[index].message,
                                //   // text1: 'Loan Number : 0123',
                                //
                                //   controller: controller,
                                //   index: index,
                                // );
                              },
                              // children: [
                              //   SizedBox(
                              //     height: 20.h,
                              //   ),
                              //   dateContainer(),
                              //   kSizedBoxH20,
                              //   textContainerWithDots(
                              //     240.h,
                              //     "Jacob rejected your surety request .",
                              //     "Here is the reason for the recjection can be shown .",
                              //     text1: 'Loan Number : 0123',
                              //     text2: 'Loan Amount : 200SR',
                              //     text3: 'Purpose : Loan Purpose',
                              //   )
                              // ]
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
                                  'Notificatoin is empty',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                    ),
                  ],
                )
              : Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).height,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: ThemeProvider.blackColor,
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Padding textContainer(
    height,
    title, {
    String? text1,
    String? text2,
    String? text3,
    String? text4,
    String? clickable,
    String? endDate,
    Function()? onTap,
    required NotificationController controller,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 22.0.w, right: 22.0),
      child: GestureDetector(
        onTap: onTap,
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
                    endDate != null
                        ? Text("End Date: $endDate")
                        : const SizedBox(),
                    clickable != null
                        ? const SizedBox(
                            height: 20,
                          )
                        : const SizedBox(),
                    clickable != null
                        ? Text(
                            clickable,
                            style: const TextStyle(color: Colors.blue),
                          )
                        : const SizedBox(),
                    text1 != null
                        ? Text(
                            text1,
                          )
                        : const SizedBox(),
                    text2 != null
                        ? Text(
                            text2,
                          )
                        : const SizedBox(),
                    text3 != null
                        ? Text(
                            text3,
                          )
                        : const SizedBox(),
                    text4 != null
                        ? Text(
                            text4,
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
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
    if (controller.notification!.data?[index].details?.status == 0) {
      return Padding(
        padding: EdgeInsets.only(left: 22.0.w, right: 22.0),
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
        ),
      );
    } else if (controller.notification!.data?[index].details?.status == 2) {
      return Padding(
        padding: EdgeInsets.only(left: 22.0.w, right: 22.0),
        child: Container(
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
                        'Purpose: ${controller.notification!.data?[index].details!.purpose}'),
                    kSizedBoxH,
                    const Text(
                      'Reason for rejection',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('NA'),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else if (controller.notification!.data?[index].details?.status == 1) {
      return Padding(
        padding: EdgeInsets.only(left: 22.0.w, right: 22.0),
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
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
