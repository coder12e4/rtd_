import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/book/service_member_details_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceMemberProfile extends StatelessWidget {
  const ServiceMemberProfile({super.key});

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
              height: 620.h,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(50),
                    topEnd: Radius.circular(50),
                  )),
              child: GetBuilder<ServiceMemberDetailsController>(
                  builder: (controller) {
                return controller.loading != true
                    ? ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          imageContainer(controller),
                          kSizedBoxH,
                          nameText(controller.memberDetails!.data.name,
                              controller.memberDetails!.data.service),
                          kSizedBoxH,
                          dividerWidget(),
                          kSizedBoxH,
                          textButton(controller),
                          kSizedBoxH,
                          dividerWidget(),
                          kSizedBoxH,
                          detailsText('Indian Number',
                              controller.memberDetails!.data.indiaMobileNumber),
                          kSizedBoxH,
                          dividerWidget(),
                          kSizedBoxH,
                          detailsText('KSA Number',
                              controller.memberDetails!.data.ksaMobileNumber),
                          kSizedBoxH,
                          dividerWidget(),
                          kSizedBoxH,
                          detailsText('Mail Address',
                              controller.memberDetails!.data.email),
                          kSizedBoxH,
                          dividerWidget(),
                          // kSizedBoxH,
                          // detailsText('Mail Address', 'example@gmail.com'),
                          // kSizedBoxH,
                          // dividerWidget(),
                          kSizedBoxH,
                          detailsText('Blood Group',
                              controller.memberDetails!.data.bloodGroupName),
                          kSizedBoxH,
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          color: Colors.black,
                        ),
                      );
              }),
            )
          ],
        ),
      ),
    ));
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

  textButton(ServiceMemberDetailsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(60, 50)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.green)),
            onPressed: () {
              launch("tel:${controller.memberDetails!.data.ksaMobileNumber}");
            },
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.call, color: whiteColor),
                  Text(
                    'Call',
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
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 18.0, right: 18, top: 5, bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: whiteColor,
                  ),
                  Text(
                    'Location',
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

  Column nameText(String? name, String? id) {
    return Column(
      children: [
        Text(
          name!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text('($id)',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  Container imageContainer(ServiceMemberDetailsController controller) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(controller.memberDetails!.data.profileImage),
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
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 30,
                  )),
              // SizedBox(
              //   width: 90.w,
              // ),
              Text(
                'Member Book',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              // SizedBox(
              //   width: 30.w,
              // ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.people_alt),
                color: whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
