import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/loan/loan_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/appbar.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/view/loan_screen/widgets/new_request_view.dart';
import 'package:rtd_project/view/loan_screen/widgets/requestView.dart';

import '../../core/common_widget/loane_documents.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  void initState() {
    Get.find<LoanScreenController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoanScreenController>(builder: (value) {
        return Scaffold(
          backgroundColor: baseColor,
          body: DefaultTabController(
            length: 2,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kSizedBoxH,
                const CustomAppBar(title: "Loan Request"),
                kSizedBoxH,
                tabBar(),
                tabBarView(context, value),
              ],
            ),
          ),
          bottomSheet: value.isCompleted == true
              ? LoanDocumentsBottomSheet(
                  loanId: value.loanId,
                  press: () => value.loanRequestComplete(),
                )
              : const Offstage(),
        );
      }),
    );
  }

  Widget tabBarView(BuildContext context, LoanScreenController value) {
    return Expanded(
      child: Container(
        //hallo
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(40),
            topStart: Radius.circular(40),
          ),
        ),
        child: value.loading != true
            ? TabBarView(
                children: [
                  NewRequestView(value: value),
                  RequestView(value: value),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 6,
                ),
              ),
      ),
    );
  }

  Padding tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              height: 20.h,
              text: 'New Request',
            ),
            Tab(
              height: 20.h,
              text: 'Request',
            )
          ]),
    );
  }
}
