import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';
import 'package:rtd_project/controller/home_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/appbar.dart';
import 'package:rtd_project/core/common_widget/dotted_text.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/home_screen/widgets/chart_items.dart';

import '../../controller/notification/notification_controller.dart';
import '../../core/common_widget/notification_icon.dart';
import '../../core/constraints/conatrints.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationController notiController =
      Get.put(NotificationController(parser: Get.find()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        builder: (value) {
          return Scaffold(
            backgroundColor: baseColor,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomAppBar(
                  title: "Home",
                  trailing: NotificationIcon(),
                ),

                // homeTextWidget(context, value),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5.h),
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(40),
                        topStart: Radius.circular(40),
                      ),
                    ),
                    child: value.loading != true
                        ? ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 10.h),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  height: 520.h,
                                  decoration: BoxDecoration(
                                    color: textFormBase,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      kSizedBoxH,
                                      CarouselSlider(
                                        items: value.homeData?.collectionSummary
                                            .map(
                                              (item) => ChartItems(item: item),
                                            )
                                            .toList(),
                                        options: CarouselOptions(
                                          pauseAutoPlayOnTouch: true,
                                          height: 280.h,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          aspectRatio: 16 / 17,
                                          autoPlay: true,

                                          // enlargeCenterPage: true,
                                        ),
                                      ),
                                      incomeBreakdown(value.homeData),
                                    ],
                                  ),
                                ),
                              ),
                              value.homeData?.activeLoan != null
                                  ? activeLoan(value.homeData!)
                                  : const Offstage(),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: ThemeProvider.blackColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding activeLoan(HomeData homeData) {
    return Padding(
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
            child: const Text(
              'Active Loan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          activeLoanData(homeData),
        ],
      ),
    );
  }

  Container activeLoanData(HomeData data) {
    return Container(
      decoration: BoxDecoration(
          color: textFormBase,
          borderRadius: BorderRadius.all(Radius.circular(30.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          children: [
            incomeRow(
                price: '${data.activeLoan?.loanAmount ?? "0.00"} INR',
                title: 'Loan Amount'),
            kSizedBoxH,
            const DashText(),
            kSizedBoxH,
            activeLoanRow(
                title: 'Loan Type',
                date: data.activeLoan?.loanType ?? 'Not Available'),
            activeLoanRow(
                title: 'Start Date',
                date: data.activeLoan?.startDate.toString() ?? 'Not Available'),
            activeLoanRow(
                title: 'Due Date',
                date: data.activeLoan?.dueDate.toString() ?? 'Not Available'),
          ],
        ),
      ),
    );
  }

  Expanded incomeBreakdown(HomeData? homeData) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Income Breakdown',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          kSizedBoxH,
          incomeRow(title: 'Rent', price: '${homeData?.income.rent} INR'),
          kSizedBoxH,
          const DashText(),
          kSizedBoxH,
          incomeRow(
              title: 'Membership', price: '${homeData?.income.membership} INR'),
          kSizedBoxH20,
          const Text(
            'Total Loan',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          kSizedBoxH,
          incomeRow(title: 'Active', price: '${homeData?.loans.active}'),
          kSizedBoxH,
          const DashText(),
          kSizedBoxH,
          incomeRow(title: 'Closed', price: '${homeData?.loans.closed}'),
        ],
      ),
    ));
  }

  Row incomeRow({String? title, String? price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        Text(
          price!,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        )
      ],
    );
  }

  Padding activeLoanRow({String? title, String? date}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            date!,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          )
        ],
      ),
    );
  }

  // Row homeTextWidget(BuildContext context, HomeController controller) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       SizedBox(
  //         width: 60.w,
  //       ),
  //       Text(
  //         'Home',
  //         style: Theme.of(context).textTheme.displaySmall!.copyWith(
  //             color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
  //       ),
  //       const NotificationIcon(),
  //     ],
  //   );
  // }
}
