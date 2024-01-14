import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/loan_request_detail_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

import '../../../core/common_widget/dotted_text.dart';
// import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
// import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class LoanRequestDetailsScreen extends StatelessWidget {
  const LoanRequestDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: GetBuilder<LoanRequestDetailsController>(builder: (value) {
          return Column(
            children: [
              appbar(context),
              kSizedBoxH,
              value.error != true
                  ? Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(40),
                            topStart: Radius.circular(40),
                          ),
                        ),
                        child: value.loading != true
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    kSizedBoxH20,
                                    filenumAndActiveloan(
                                        value.loanRequestDetails?.data
                                                .createdDate ??
                                            "NA",
                                        value.loanRequestDetails?.data
                                                .statusText ??
                                            'NA'),
                                    kSizedBoxH,
                                    const DashText(),
                                    kSizedBoxH,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Loan Type :',
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                            Text(
                                              value.loanRequestDetails?.data
                                                      .loanType.title ??
                                                  "Not available",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Purpose :',
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                            Text(
                                              value.loanRequestDetails?.data
                                                      .loanPurpose?.purpose ??
                                                  "Not available",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    kSizedBoxH,
                                    const DashText(),
                                    kSizedBoxH,
                                    imageContainer(value),
                                    kSizedBoxH,
                                    const DashText(),
                                    kSizedBoxH,
                                    malayalamTextWidget(
                                        'ആവശ്യപ്പെട്ടത് :',
                                        Icons.money,
                                        value.loanRequestDetails?.data
                                            .loanAmount),
                                    kSizedBoxH20,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Attached Document',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        kSizedBoxH,
                                        SizedBox(
                                          height: 140.h,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                documentContainer(value, index),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              width: 2.w,
                                            ),
                                            itemCount: value
                                                    .loanRequestDetails
                                                    ?.data
                                                    .loanDocument
                                                    .length ??
                                                0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 6,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(40),
                            topStart: Radius.circular(40),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.warning_amber,
                                size: 40,
                              ),
                              kSizedBoxH,
                              const Text(
                                "Unknown error ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }

  Container documentContainer(
      LoanRequestDetailsController controller, int index) {
    return Container(
      margin: EdgeInsets.only(right: 15.w),
      height: 130.h,
      width: 105.w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(controller
                      .loanRequestDetails?.data.loanDocument[index].file ??
                  "")),
          color: const Color.fromARGB(255, 223, 220, 220),
          borderRadius: BorderRadius.circular(20)),
    );
  }

  Column malayalamTextWidget(title, icon, subtitle) {
    return Column(
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
    );
  }

  Column imageContainer(LoanRequestDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan Sureties :',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey.shade500),
        ),
        kSizedBoxH,
        SizedBox(
          height: 60,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  chechmarkimage(true, true, controller, index),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
              itemCount:
                  controller.loanRequestDetails?.data.sureties.length ?? 0),
        ),
      ],
    );
  }

  Stack chechmarkimage(bool checkmark, bool markAvalable,
      LoanRequestDetailsController controller, int index) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            minRadius: 30.r,
            backgroundImage: CachedNetworkImageProvider(
              controller
                      .loanRequestDetails?.data.sureties[index].profileImage ??
                  "",
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
                : const Offstage())
      ],
    );
  }

  Row filenumAndActiveloan(String createdDate, String statusText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 242, 233, 233),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          height: 40.h,
          width: 180.w,
          child: Center(
            child: Text(
              'Applied Date: $createdDate',
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
          child: Center(
            child: Text(
              statusText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: baseColor, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Row appbar(BuildContext context) {
    return Row(
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
          ),
        ),
        Text(
          'Loan Details',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(
          width: 30.w,
        ),
      ],
    );
  }
}
