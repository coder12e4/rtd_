import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtd_project/controller/loan/loan_details_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/appbar.dart';
import 'package:rtd_project/core/common_widget/dotted_text.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

import '../../../backend/model/loan/active_loan_model.dart';
import '../../../helper/router.dart';

class ProfileLoanScreen extends StatelessWidget {
  const ProfileLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: baseColor,
            body: DefaultTabController(
              length: 2,
              child: GetBuilder<LoanDetailsController>(builder: (value) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomAppBar(
                        leading: IconButton(
                          onPressed: Get.back,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: whiteColor,
                          ),
                        ),
                        title: 'Loans'),
                    tabBar(),
                    tabBarView(value),
                  ],
                );
              }),
            )));
  }

  Expanded tabBarView(LoanDetailsController controller) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(40),
            topStart: Radius.circular(40),
          ),
        ),
        child: TabBarView(
          children: [
            activeLoan(controller),
            closedLoan(controller),
          ],
        ),
      ),
    );
  }

  Column closedLoan(LoanDetailsController controller) {
    return Column(
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 10.h,
        ),
        // feedDate('19/10/2023'),
        controller.closedLoans?.data.data.length != 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.closedLoans?.data.data.length ?? 0,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Get.toNamed(
                    AppRouter.getProfileLoanDetailsRoute(),
                    arguments: [controller.closedLoans?.data.data[index].id],
                  ),
                  child: activeAndClosedLoans(
                      false, '418', controller, index, controller.closedLoans!),
                ),
              )
            : const Expanded(
                child: Center(
                  child: Text('Closed loans is Empty'),
                ),
              ),
        kSizedBoxH,
      ],
    );
  }

  // Padding VoteData(bool isActive, String filenumber) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 10.h, left: 18.w, right: 18.w),
  //     child: Container(
  //       height: 300.h,
  //       width: 500.w,
  //       decoration: BoxDecoration(
  //           color: textFormBase,
  //           borderRadius: BorderRadius.all(Radius.circular(30.r))),
  //       child: Padding(
  //         padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                       color: whiteColor,
  //                       borderRadius: BorderRadius.all(Radius.circular(30))),
  //                   height: 40.h,
  //                   width: 160.w,
  //                   child: Center(
  //                     child: Text(
  //                       'Pole Number:$filenumber',
  //                       textAlign: TextAlign.center,
  //                       style: const TextStyle(
  //                           color: Colors.black, fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   height: 40.h,
  //                   width: 100.w,
  //                   decoration: const BoxDecoration(
  //                       color: whiteColor,
  //                       borderRadius: BorderRadius.all(Radius.circular(30))),
  //                   child: Center(
  //                     child: Text(
  //                       isActive == true ? 'Active' : 'Closed',
  //                       textAlign: TextAlign.center,
  //                       style: const TextStyle(
  //                           color: Colors.black, fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             SizedBox(
  //               height: 10.h,
  //             ),
  //             const Text("വോട്ടിന്റെ വിഷയം ഇവിടെ എഴുതുക",
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w500,
  //                     fontSize: 16)),
  //             Divider(),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 optionButton(
  //                     borderAvalable: false,
  //                     buttonForegroundColor: Colors.white,
  //                     buttonbackgroundColor: Colors.black,
  //                     buttonText: 'Option one'),
  //                 optionButton(
  //                     borderAvalable: false,
  //                     buttonForegroundColor: Colors.white,
  //                     buttonbackgroundColor: Colors.black,
  //                     buttonText: 'Option Two')
  //               ],
  //             ),
  //             SizedBox(
  //               height: 8.h,
  //             ),
  //             optionButton(
  //                 borderAvalable: true,
  //                 buttonForegroundColor: Colors.white,
  //                 buttonbackgroundColor: Colors.black,
  //                 buttonText: 'Option Three Hire'),
  //             SizedBox(
  //               height: 10.h,
  //             ),
  //             submitedButton(
  //                 borderAvalable: true,
  //                 buttonForegroundColor: whiteColor,
  //                 buttonbackgroundColor: Colors.blue)
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Column activeLoan(LoanDetailsController controller) {
    final data = controller.activeLoans?.data.data;
    return Column(
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        kSizedBoxH,
        // feedDate('19/10/2023'),
        data?.length != 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: data?.length ?? 0,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouter.getProfileLoanDetailsRoute(),
                        arguments: [data![index].id]);
                  },
                  child: activeAndClosedLoans(
                      true, '418', controller, index, controller.activeLoans!),
                ),
              )
            : const Expanded(
                child: Center(
                  child: Text('Active loans is Empty'),
                ),
              ),
        kSizedBoxH,
      ],
    );
  }

  Padding activeAndClosedLoans(bool isActive, String filenumber,
      LoanDetailsController controller, int index, ActiveLoans loanData) {
    final data = loanData.data.data[index];
    String formattedDate = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(data.dueDate.toString()));
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 18.w, right: 18.w),
      child: Container(
        height: 230.h,
        width: 500.w,
        decoration: BoxDecoration(
            color: textFormBase,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 40.h,
                    width: 160.w,
                    child: Center(
                      child: Text(
                        'File Number: ${data.fileNumber}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: isActive == true
                            ? const Color.fromARGB(255, 91, 207, 95)
                            : Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        isActive == true ? 'FB:Active' : 'FB:Closed',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              kSizedBoxH,
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      data.user.profileImage,
                      height: 40.h,
                      width: 40.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text('${data.user.name} (${data.user.memberId})',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16))
                ],
              ),
              kSizedBoxH,
              const DashText(),
              kSizedBoxH,
              loanAmount(title: 'കിട്ടിയത്:', price: data.loanAmount),
              loanAmount(title: 'കൊടുത്തത്:', price: data.paidAmount),
              // SizedBox(
              //   height: 10.h,
              // ),
              reternDate(title: 'തിരിച്ചടവ്:', date: formattedDate)
            ],
          ),
        ),
      ),
    );
  }

  Padding loanAmount({String? title, String? price}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.money),
              Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
          Text(
            price!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }

  Padding reternDate({String? title, String? date}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.date_range),
              Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
          Text(
            date!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }

  Padding tabBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 80),
      child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 5.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              height: 20,
              text: 'Active',
            ),
            Tab(
              height: 20,
              text: 'Closed',
            )
          ]),
    );
  }
}
