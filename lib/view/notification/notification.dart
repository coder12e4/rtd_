import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/notification/notificatoin_view/notification_view_screen.dart';

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
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: GetBuilder<NotificationController>(builder: (controller) {
            return controller.loading != true
                ? Column(
                    children: [
                      appbar(context, controller),
                      Container(
                        height: MediaQuery.sizeOf(context).height,
                        decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(50),
                              topEnd: Radius.circular(50),
                            )),
                        child: controller.notification?.data.length != 0
                            ? ListView.separated(
                                padding: EdgeInsets.only(top: 20.h),
                                itemCount:
                                    controller.notification?.data.length ?? 0,
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    kSizedBoxH20,
                                itemBuilder: (context, index) {
                                  if (controller
                                          .notification?.data[index].type ==
                                      4) {
                                    return containerWithClickable(
                                      100.h,
                                      controller
                                          .notification?.data[index].message,
                                      clikable: 'View Details',
                                      index: index,
                                      controller: controller,
                                    );
                                  } else if (controller
                                          .notification?.data[index].type ==
                                      2) {
                                    return textContainer(
                                      150.h,
                                      controller
                                          .notification?.data[index].message,
                                      text1: 'Loan Number : 0123',
                                      text2: 'Loan Amount : 200SR',
                                      text3: 'Purpose : Loan Purpose',
                                      text4: 'Repayment Date : 20/12/2023',
                                      controller: controller,
                                      index: index,
                                    );
                                  } else if (controller
                                          .notification?.data[index].type ==
                                      1) {
                                    return textContainer(
                                      90.h,
                                      controller
                                          .notification?.data[index].message,
                                      // text1: 'Loan Number : 0123',
                                      text2:
                                          'Loan Amount : ${controller.notification?.data[index].details.amount}',
                                      text3:
                                          'Purpose :  ${controller.notification?.data[index].details.purpose}',
                                      controller: controller,
                                      index: index,
                                    );
                                  } else if (controller
                                          .notification?.data[index].type ==
                                      3) {
                                    final inputFormat = controller.notification!
                                        .data[index].details.endDate
                                        .toString();
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy').format(
                                            DateTime.parse(inputFormat));
                                    return textContainer(
                                        100.h,
                                        controller
                                            .notification?.data[index].message,
                                        controller: controller,
                                        index: index,
                                        endDate: formattedDate,
                                        clickable: 'View Details');
                                  }
                                  return const Text('Broadcast');
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                      // borderRadius: BorderRadiusDirectional.only(
                      //   topStart: Radius.circular(50),
                      //   topEnd: Radius.circular(50),
                      // )
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
      ),
    );
  }

  GestureDetector textContainer(
    height,
    title, {
    String? text1,
    String? text2,
    String? text3,
    String? text4,
    String? clickable,
    String? endDate,
    required NotificationController controller,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        controller
            .markNotificationSeen(controller.notification!.data[index].id);
      },
      child: Padding(
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
                      color: controller.notification?.data[index].seen == 1
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
                    Text(
                      text4 ?? '',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding textContainerWithDots(height, title, title2,
      {text1, text2, text3, text4}) {
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
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
                    text1,
                  ),
                  Text(
                    text2,
                  ),
                  Text(
                    text3,
                  ),
                  Text(
                    text4 ?? '',
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 5.0.w, right: 15.w, top: 10.h),
                    child: Text(
                      title2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  kSizedBoxH,
                  DottedText('First reason for rejection'),
                  DottedText('Second reason for rejection'),
                  DottedText('Third reason for rejection'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding DottedText(text) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: Row(
        children: [
          Container(
            height: 5.h,
            width: 5.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: baseColor,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            text ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  containerWithClickable(height, title,
      {text1,
      text2,
      text3,
      text4,
      clikable,
      required NotificationController controller,
      required int index}) {
    if (controller.notification!.data[index].details.status == 0) {
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
                      color: controller.notification?.data[index].seen == 1
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
                      onTap: () => Get.to(const NotificationViewScreen()),
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
    } else if (controller.notification!.data[index].details.status == 2) {
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
                      color: controller.notification?.data[index].seen == 1
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
                        'Loan Amount: ${controller.notification!.data[index].details.amount}'),
                    Text(
                        'Purpose: ${controller.notification!.data[index].details.purpose}'),
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
    } else if (controller.notification!.data[index].details.status == 1) {
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
                      color: controller.notification?.data[index].seen == 1
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
                        'Loan Amount: ${controller.notification!.data[index].details.amount}'),
                    Text(
                        'Purpose: ${controller.notification!.data[index].details.purpose}')
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Column dateContainer() {
    return Column(
      children: [
        Container(
          height: 30.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 220, 220),
              borderRadius: BorderRadius.circular(40)),
          child: const Center(child: Text('19/10/2023')),
        ),
      ],
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
          SizedBox(
            width: 90.w,
          ),
          Text(
            'Notification',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            width: 30.w,
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/fonts/icons/three-dots-svgrepo-com (1).svg',
            ),
            color: whiteColor,
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              IconButton(
                onPressed: () {},
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
