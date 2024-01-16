import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
      body: Column(
        children: [
          appbar(context),
          Expanded(
            child: Container(
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
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        children: [
                          imageContainer(controller),
                          kSizedBoxH,
                          nameText(controller.memberDetails!.data.name,
                              controller.memberDetails!.data.service),
                          kSizedBoxH,
                          dividerWidget(),
                          kSizedBoxH,
                          textButton(controller, context),
                          kSizedBoxH,
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Highlights",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 97, 95, 95),
                                    fontWeight: FontWeight.bold),
                              ),
                              Html(
                                data: controller.memberDetails?.data.highlights,
                                style: {
                                  "body": Style(
                                    padding: HtmlPaddings.zero,
                                    margin: Margins.zero,
                                  ),
                                  "p": Style(
                                      padding: HtmlPaddings.zero,
                                      margin: Margins.zero),
                                },
                              ),
                            ],
                          ),
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
            ),
          )
        ],
      ),
    ));
  }

  Column detailsText(title, subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Color.fromARGB(255, 97, 95, 95),
              fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: const TextStyle(
              // color: Color.fromARGB(255, 97, 95, 95),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ],
    );
  }

  textButton(ServiceMemberDetailsController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(60, 50)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.green)),
            onPressed: () =>
                launch("tel:${controller.memberDetails!.data.ksaMobileNumber}"),
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
            onPressed: controller.launchURL,
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

  // Container callDetailsBottomSheet(ServiceMemberDetailsController controller) {
  //   return Container(
  //     height: 210.h,
  //     width: 390.w,
  //     decoration: const BoxDecoration(
  //       color: whiteColor,
  //       borderRadius: BorderRadiusDirectional.only(
  //         topEnd: Radius.circular(50),
  //         topStart: Radius.circular(50),
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         kSizedBoxH20,
  //         SizedBox(
  //             width: 290.w,
  //             child: Text(
  //               'You can reach ${controller.memberDetails!.data.name} from the below numbers.',
  //               textAlign: TextAlign.center,
  //               style:
  //                   const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  //             )),
  //         kSizedBoxH20,
  //         // Padding(
  //         //   padding: EdgeInsets.only(right: 20.w),
  //         //   child: Row(
  //         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         //     children: [
  //         //       detailsText('Indian Number',
  //         //           controller.memberDetails!.data.indiaMobileNumber),
  //         //       IconButton(
  //         //         onPressed: () => launch(
  //         //             "tel:${controller.memberDetails!.data.indiaMobileNumber}"),
  //         //         icon: const Icon(Icons.call),
  //         //       ),
  //         //     ],
  //         //   ),
  //         // ),
  //         kSizedBoxH,
  //         dividerWidget(),
  //         kSizedBoxH,
  //         Padding(
  //           padding: EdgeInsets.only(right: 20.w),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               detailsText('Ksa Number',
  //                   controller.memberDetails!.data.ksaMobileNumber),
  //               IconButton(
  //                 onPressed: () => launch(
  //                     "tel:${controller.memberDetails!.data.ksaMobileNumber}"),
  //                 icon: const Icon(Icons.call),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Divider dividerWidget() {
    return Divider(
      color: Colors.grey.shade300,
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
              Text(
                'Member Book',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                width: 30.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
