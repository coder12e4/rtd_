import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/notification/notification_controller.dart';
import 'package:rtd_project/controller/profile/profile_controller.dart';
import 'package:rtd_project/controller/profile/profile_edit_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/helper/router.dart';

import '../../util/alert_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: GetBuilder<ProfileController>(
            builder: (value) {
              return Column(
                children: [
                  appbar(context, value),
                  value.loading || value.userData == null
                      ? Container(
                          height: 550.h,
                          // width: 100,
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(40),
                              topStart: Radius.circular(40),
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 6,
                            ),
                          ),
                        )
                      : Container(
                          height: 1550.h,
                          decoration: const BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(50),
                                topEnd: Radius.circular(50),
                              )),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              imageContainer(value),
                              kSizedBoxH,
                              nameText(value),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              textButton(context),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText('Indian Mobile Number',
                                  " ${value.userData!.data.indiaMobileNumber}"),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText('KSA  Mobile Number',
                                  value.userData!.data.ksaMobileNumber),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText(
                                  'Mail Address', value.userData!.data.email),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText('India State',
                                  value.userData!.data.indiaState.stateName),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText('KSA State',
                                  value.userData!.data.ksaState.stateName),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText(
                                  'India Pin', value.userData!.data.indiaPin),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText(
                                  'KSA Pin', value.userData!.data.ksaPin),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText(
                                  'Vehicle Model',
                                  value.userData!.data.vehicleTypeId
                                      .toString()),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText(
                                  'Vehicle Number',
                                  value.userData!.data.vehicleNumber ??
                                      'Not Available'),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText('Blood Group',
                                  value.userData!.data.bloodGroup.toString()),
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText('Indian Address',
                                  "${value.userData!.data.indianAddress1}\n${value.userData!.data.indianAddress2}"),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              detailsText('Ksa Address',
                                  '${value.userData!.data.ksaAddress1}\n${value.userData!.data.ksaAddress2}'),
                              dividerWidget(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  kSizedBoxH,
                                  headingText('Indian Address Proof'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  documentContainer(
                                      value.userData!.data.documentProofIndia),
                                  // const SizedBox(
                                  //   height: 15,
                                  // ),
                                  kSizedBoxH,
                                  dividerWidget(),
                                  kSizedBoxH,
                                  headingText('Ksa Address Proof'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  documentContainer(
                                      value.userData!.data.documentProofKsa),
                                  kSizedBoxH,
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Padding headingText(String heading) {
    return Padding(
      padding: EdgeInsets.only(left: 45.w),
      child: Text(
        heading,
        style: const TextStyle(
            color: Color.fromARGB(255, 97, 95, 95),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Align documentContainer(documentProof) {
    return Align(
      child: Container(
        // margin: EdgeInsets.only(left: 36.w),
        height: 130.h,
        width: 280.w,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(documentProof),
            ),
            color: const Color.fromARGB(255, 223, 220, 220),
            borderRadius: BorderRadius.circular(20)),
        // child: Image.network(
        //   documentProof,
        //   height: 130.h,
        //   width: 280.w,
        //   errorBuilder: (context, error, stackTrace) => Padding(
        //     padding: const EdgeInsets.all(10.0).r,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const Icon(Icons.error_outline),
        //         kSizedBoxH,
        //         Text(error.toString()),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Padding detailsText(title, subtitle) {
    return Padding(
      padding: EdgeInsets.only(left: 38.0.w, right: 38.0.w),
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

  textButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(60, 50)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => baseColor)),
            onPressed: () {
              Get.delete<ProfileController>(force: true);
              Get.delete<EditProfileController>(force: true);
              Get.toNamed(AppRouter.getEditProfileRoute());
            },
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
            onPressed: () => Get.toNamed(AppRouter.getLoanDetailsRoute()),
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

  Align nameText(ProfileController value) {
    return Align(
      child: Text(
        value.userData!.data.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Container imageContainer(ProfileController value) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(width: .3),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(
            value.userData!.data.profileImage,
          ),
        ),
      ),
    );
  }

  Container appbar(BuildContext context, ProfileController ProController) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 160.w,
          ),
          Text(
            'Profile',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            width: 10.w,
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => whiteColor)),
            onPressed: () => logOutDialog(),
            child: const Text(
              'Log Out',
              style: TextStyle(color: baseColor),
            ),
          ),
          GetBuilder<NotificationController>(
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  // Get.delete<NotificationController>(force: true);
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
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
