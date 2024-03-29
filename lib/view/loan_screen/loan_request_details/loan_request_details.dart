import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/loan_request_detail_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

import '../../../core/common_widget/appbar.dart';
import '../../../core/common_widget/dotted_text.dart';
import '../../../core/common_widget/surety_widget.dart';
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
              CustomAppBar(
                  leading: IconButton(
                    onPressed: value.backRout,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                      size: 30,
                    ),
                  ),
                  title: "Loan Details"),
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
                                  shrinkWrap: true,
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
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 150.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Purpose :',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              Text(
                                                value.loanRequestDetails?.data
                                                        .loanPurpose?.purpose ??
                                                    "Not available",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ],
                                          ),
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
                                    kSizedBoxH,
                                    value.loanRequestDetails?.data
                                                .rejectReason !=
                                            null
                                        ? const Text(
                                            'Reason For Rejection :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Offstage(),
                                    kSizedBoxH,
                                    value.loanRequestDetails?.data
                                                .rejectReason !=
                                            null
                                        ? Text(value.loanRequestDetails!.data
                                            .rejectReason
                                            .toString())
                                        : const Offstage(),
                                    kSizedBoxH,
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
                                          child: value.loanRequestDetails?.data
                                                      .loanDocument.length !=
                                                  0
                                              ? ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          documentContainer(
                                                              value, index),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  itemCount: value
                                                          .loanRequestDetails
                                                          ?.data
                                                          .loanDocument
                                                          .length ??
                                                      0,
                                                )
                                              : const Center(
                                                  child: Text(
                                                    "Documents not attached with this loan",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
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
          height: 85,
          child: controller.loanRequestDetails?.data.sureties.length != 0
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SuretyWidget(
                        url: controller.loanRequestDetails!.data.sureties[index]
                            .profileImage,
                        name: controller
                            .loanRequestDetails!.data.sureties[index].name,
                        suretyStatus: controller
                            .loanRequestDetails!.data.sureties[index].status,
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                  itemCount:
                      controller.loanRequestDetails?.data.sureties.length ?? 0)
              : const Center(
                  child: Text(
                    "Sureties not added",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
        ),
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
}
