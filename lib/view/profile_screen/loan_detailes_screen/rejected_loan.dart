import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

class RejectedLoanScreen extends StatelessWidget {
  const RejectedLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              appbar(context),
              kSizedBoxH20,
              Container(
                height: 960.h,
                //hallo
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(40),
                    topStart: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 18.0.h, right: 18, top: 28),
                        child: filenumAndActiveloan('418', true),
                      ),
                      dashText(),
                      kSizedBoxH,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Loan Type :',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0.w),
                                  child: const Text(
                                    'Lorem Ipsum',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Purpose :',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 18.0.w),
                                  child: const Text(
                                    'Lorem Ipsum',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      kSizedBoxH,
                      dashText(),
                      imageContainer(),
                      kSizedBoxH,
                      dashText(),
                      kSizedBoxH,
                      malayalamTextWidget('തുക :', Icons.money, '2000SR'),
                      kSizedBoxH20,
                      malayalamTextWidget(
                          'തുടങ്ങിയത് :', Icons.calendar_month, '26.05.2023'),
                      kSizedBoxH,
                      dashText(),
                      kSizedBoxH,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 218.0),
                            child: Text('Reason for rejection :'),
                          ),
                          textContainerWithDots(
                              130.h,
                              'Here Reasons for the rejection can be shown',
                              'Here Reasons for the rejection can be shown',
                              text1: 'fg',
                              text2: 'sdf',
                              text3: 'dsdf')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Attached Document',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          kSizedBoxH,
                          documentContainer(),
                          kSizedBoxH,
                          documentContainer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  textContainerWithDots(height, title, title2, {text1, text2, text3, text4}) {
    return Container(
      margin: EdgeInsets.only(right: 80.w),
      height: height,
      width: 300.w,
      // decoration: BoxDecoration(
      //     color: const Color.fromARGB(255, 223, 220, 220),
      //     borderRadius: BorderRadiusDirectional.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kSizedBoxH,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0.w, right: 15.w, top: 10.h),
                  child: Text(
                    title2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                kSizedBoxH,
                dottedText('First reason for rejection'),
                dottedText('Second reason for rejection'),
                dottedText('Third reason for rejection'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding dottedText(text) {
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

  Container documentContainer() {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      height: 130.h,
      width: 320.w,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 220, 220),
          borderRadius: BorderRadius.circular(20)),
    );
  }

  Padding malayalamTextWidget(title, icon, subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              Text(title),
            ],
          ),
          Text(
            subtitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Column imageContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0.h, left: 22.0.w, bottom: 8.h),
          child: Text(
            'Loan Sureties :',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey.shade500),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              chechmarkimage(true, true),
              chechmarkimage(true, true),
              chechmarkimage(true, true),
              chechmarkimage(true, true),
            ],
          ),
        ),
      ],
    );
  }

  Stack chechmarkimage(bool checkmark, bool markAvalable) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            minRadius: 30.r,
            backgroundImage: const AssetImage(
              'assets/images/pexels-pixabay-220453 1.png',
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: markAvalable == true
                ? Container(
                    width: 20.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                        color: checkmark == true ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(50.r))),
                    child: Icon(
                      checkmark == true ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                : Container())
      ],
    );
  }

  Text dashText() {
    return const Text(
      '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Row filenumAndActiveloan(filenumber, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 242, 233, 233),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          height: 40.h,
          width: 160.w,
          child: Center(
            child: Text(
              'File Number:$filenumber',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          height: 40.h,
          width: 100.w,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 242, 233, 233),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Center(
            child: Text(
              'Rejected',
              textAlign: TextAlign.center,
              style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 30,
                  )),
              // SizedBox(
              //   width: 90.w,
              // ),
              Text(
                'Profile',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
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
        ],
      ),
    );
  }
}
