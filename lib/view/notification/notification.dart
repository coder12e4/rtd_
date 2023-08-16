import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
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
          child: Column(
            children: [
              appbar(context),
              Container(
                height: 920.h,
                decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(50),
                      topEnd: Radius.circular(50),
                    )),
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      dateContainer(),
                      SizedBox(
                        height: 20.h,
                      ),
                      textContainer(150.h,
                          'The loan you have applied have been approved .',
                          text1: 'Loan Number : 0123',
                          text2: 'Loan Amount : 200SR',
                          text3: 'Purpose : Loan Purpose',
                          text4: 'Repayment Date : 20/12/2023'),
                      kSizedBoxH20,
                      textContainer(
                        140.h,
                        'We are sorry to inform that your application for loan has been rejected.',
                        text1: 'Loan Number : 0123',
                        text2: 'Loan Amount : 200SR',
                        text3: 'Purpose : Loan Purpose',
                      ),
                      kSizedBoxH20,
                      containerWithClickable(100.h,
                          "Your are choosen as Jacob Surety .Respond as soon as posible .",
                          clikable: 'View Details'),
                      kSizedBoxH20,
                      textContainer(
                        140.h,
                        'We are sorry to inform that your application for loan has been rejected.',
                        text1: 'Loan Number : 0123',
                        text2: 'Loan Amount : 200SR',
                        text3: 'Purpose : Loan Purpose',
                      ),
                      kSizedBoxH20,
                      textContainerWithDots(
                        240.h,
                        "Jacob rejected your surety request .",
                        "Here is the reason for the recjection can be shown .",
                        text1: 'Loan Number : 0123',
                        text2: 'Loan Amount : 200SR',
                        text3: 'Purpose : Loan Purpose',
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding textContainer(height, title, {text1, text2, text3, text4}) {
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
                ],
              ),
            )
          ],
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
      {text1, text2, text3, text4, clikable}) {
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationViewScreen(),
                      ));
                    },
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

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: whiteColor,
                size: 35,
              ))
        ],
      ),
    );
  }
}
