import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              height: 1200.h,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(50),
                    topEnd: Radius.circular(50),
                  )),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  imageContainer(),
                  kSizedBoxH,
                  nameText(),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  textButton(),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  detailsText('India', '+91 9745123456'),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  detailsText('Saudi Arabia', '+91 9745123456'),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  detailsText('Mail Address', 'example@gmail.com'),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  detailsText('Mail Address', 'example@gmail.com'),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  detailsText('Blood Group', 'B+'),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  detailsText('Indian Address',
                      'Address Line 1, Line 2 and Line 3 will be shown here. Pin code and state etc. will follow.'),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  detailsText('Saudi Arabia Address',
                      'Address Line 1, Line 2 and Line 3 will be shown here. Pin code and state etc. will follow.'),
                  dividerWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 45.0.w, right: 8.0.w),
                        child: const Text(
                          'Documents',
                          style: TextStyle(
                              color: Color.fromARGB(255, 97, 95, 95),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      documentContainer(),
                      const SizedBox(
                        height: 15,
                      ),
                      documentContainer(),
                      kSizedBoxH,
                      dividerWidget(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Container documentContainer() {
    return Container(
      margin: EdgeInsets.only(left: 36.w),
      height: 130.h,
      width: 280.w,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 220, 220),
          borderRadius: BorderRadius.circular(20)),
    );
  }

  Padding detailsText(title, subtitle) {
    return Padding(
      padding: EdgeInsets.only(left: 38.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
            child: Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 97, 95, 95),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
            child: Text(
              subtitle,
              style: const TextStyle(
                  // color: Color.fromARGB(255, 97, 95, 95),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  textButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(60, 50)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => baseColor)),
            onPressed: () {},
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, color: whiteColor),
                  Text(
                    'Edit Profile',
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ],
              ),
            )),
        const SizedBox(
          width: 20,
        ),
        TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(60, 50)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => baseColor)),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 18, top: 5, bottom: 5),
              child: Row(
                children: [
                  SvgPicture.asset(
                      'assets/fonts/icons/database-data-base-svgrepo-com.svg'),
                  const Text(
                    'Loan',
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Divider dividerWidget() {
    return Divider(
      color: Colors.grey.shade300,
      indent: 30.w,
      endIndent: 30.w,
    );
  }

  Column nameText() {
    return const Column(
      children: [
        Text(
          'Shanavas Kolangattil',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text('(M.109)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  Container imageContainer() {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      height: 100.h,
      width: 100.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage('assets/images/pexels-pixabay-220453 1.png'),
        ),
      ),
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 30,
                  )),
              SizedBox(
                width: 90.w,
              ),
              Text(
                'Profile',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
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
          Padding(
            padding: const EdgeInsets.only(right: 38.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => whiteColor)),
              onPressed: () {},
              child: const Text(
                'Log Out',
                style: TextStyle(color: baseColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
/////// profile Page set