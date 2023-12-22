import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtd_project/controller/loan/profile_loan_data_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
// import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
// import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class ActiveLoanDetailsScreen extends StatelessWidget {
  const ActiveLoanDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: GetBuilder<ProfileLoanDataController>(builder: (value) {
            return Column(
              children: [
                appbar(context),
                kSizedBoxH20,
                value.error != true
                    ? Container(
                        height: 820.h,
                        //hallo
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(40),
                            topStart: Radius.circular(40),
                          ),
                        ),
                        child: value.loading != true
                            ? Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 18.0.h, right: 18, top: 28),
                                    child: filenumAndActiveloan(
                                        value.loanData?.data?.fileNumber,
                                        value.loanData?.data?.statusText
                                                .toString() ??
                                            ''),
                                  ),
                                  dashText(),
                                  kSizedBoxH,
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w),
                                    child: Row(
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
                                              value.loanData?.data?.loanType ??
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
                                              value.loanData?.data?.purpose ??
                                                  "Not available",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  kSizedBoxH,
                                  dashText(),
                                  imageContainer(value),
                                  kSizedBoxH,
                                  dashText(),
                                  kSizedBoxH,
                                  malayalamTextWidget('തുക :', Icons.money,
                                      value.loanData?.data?.loanAmount),
                                  kSizedBoxH20,
                                  malayalamTextWidget(
                                    'തുടങ്ങിയത് :',
                                    Icons.calendar_month,
                                    value.loanData!.data?.startDate.toString(),
                                  ),
                                  kSizedBoxH20,
                                  malayalamTextWidget(
                                    'തിരിച്ചടവ്  :',
                                    Icons.calendar_month,
                                    DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                        value.loanData!.data?.dueDate
                                                .toString() ??
                                            "",
                                      ),
                                    ),
                                  ),
                                  kSizedBoxH,
                                  // String formattedDate =;
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  //   child: RoundedProgressBar(
                                  //       childCenter: const Text(
                                  //         'Due in 31 days',
                                  //         style: TextStyle(fontWeight: FontWeight.bold),
                                  //       ),
                                  //       milliseconds: 1000,
                                  //       percent: 50,
                                  //       height: 25,
                                  //       theme: RoundedProgressBarTheme.purple,
                                  //       style: RoundedProgressBarStyle(
                                  //           colorBackgroundIcon:
                                  //               const Color.fromARGB(255, 190, 185, 185),
                                  //           widthShadow: 1,
                                  //           backgroundProgress:
                                  //               const Color.fromARGB(255, 190, 185, 185),
                                  //           colorProgress:
                                  //               const Color.fromARGB(255, 190, 185, 185),
                                  //           colorBorder: whiteColor,
                                  //           borderWidth: 2,
                                  //           colorProgressDark:
                                  //               const Color.fromARGB(255, 186, 39, 110)),
                                  //       borderRadius: BorderRadius.circular(24)),
                                  // ),
                                  kSizedBoxH20,
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Column(
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
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                documentContainer(value, index),
                                            separatorBuilder:
                                                (context, index) => kSizedBoxH,
                                            itemCount: value.loanData!.data
                                                    ?.loanDocument.length ??
                                                0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 300.h,
                                    ),
                                    const CircularProgressIndicator(
                                      strokeWidth: 6,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                      )
                    : Container(
                        height: MediaQuery.sizeOf(context).height,
                        //hallo
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
              ],
            );
          }),
        ),
      ),
    );
  }

  Container documentContainer(ProfileLoanDataController controller, int index) {
    return Container(
      margin: EdgeInsets.only(right: 15.w),
      height: 130.h,
      width: 105.w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  controller.loanData!.data?.loanDocument[index].file ?? "")),
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

  Column imageContainer(ProfileLoanDataController controller) {
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
          child: SizedBox(
            height: 60,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    chechmarkimage(true, true, controller, index),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: controller.loanData?.data?.sureties.length ?? 0),
          ),
        ),
      ],
    );
  }

  Stack chechmarkimage(bool checkmark, bool markAvalable,
      ProfileLoanDataController controller, int index) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            minRadius: 30.r,
            backgroundImage: NetworkImage(
              controller.loanData!.data?.sureties[index].profileImage ?? "",
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

  Row filenumAndActiveloan(filenumber, String statusText) {
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
                'Loan Details',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
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
