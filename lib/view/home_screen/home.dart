import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';
import 'package:rtd_project/controller/home_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/home_screen/widgets/chart_items.dart';

import '../../controller/notification/notification_controller.dart';
import '../../core/constraints/conatrints.dart';
import '../../helper/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController contoller = Get.find();
  final NotificationController notiController =
      Get.put(NotificationController(parser: Get.find()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<HomeController>(builder: (value) {
      return Scaffold(
          backgroundColor: baseColor,
          body: SingleChildScrollView(
              physics: value.homeData?.activeLoan != null
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  homeTextWidget(context, value),
                  Container(
                    height: MediaQuery.sizeOf(context).height,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(40),
                        topStart: Radius.circular(40),
                      ),
                    ),
                    child: value.loading != true
                        ? Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                height: 470.h,
                                // width: 100.w,
                                decoration: BoxDecoration(
                                  color: textFormBase,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    kSizedBoxH20,
                                    CarouselSlider(
                                      items: value.homeData?.collectionSummary
                                          .map(
                                            (item) => ChartItems(item: item),
                                          )
                                          .toList(),
                                      options: CarouselOptions(
                                        pauseAutoPlayOnTouch: true,
                                        height: 240.h,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        aspectRatio: 16 / 17,
                                        autoPlay: true,

                                        // enlargeCenterPage: true,
                                      ),
                                    ),
                                    incomBreakdown(value.homeData),
                                  ],
                                ),
                              ),
                            ),
                            value.homeData?.activeLoan != null
                                ? activeLoan(value.homeData!)
                                : const SizedBox(),
                          ])
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: ThemeProvider.blackColor,
                            ),
                          ),
                  ),
                ],
              )));
    }));
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
      height: 120.h,
      decoration: BoxDecoration(
          color: textFormBase,
          borderRadius: BorderRadius.all(Radius.circular(30.r))),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
        child: Column(
          children: [
            IncomRow(
                price: '${data.activeLoan?.loanAmount} INR',
                title: 'Loan Amount'),
            const Divider(),
            activeLoanRow(
                title: 'Start Date', date: data.activeLoan?.startDate),
            // activeLoanRow(title: 'End Date', date: '${data.activeLoan.}'),
            activeLoanRow(title: 'Loan Type', date: data.activeLoan?.loanType)
          ],
        ),
      ),
    );
  }

  Expanded incomBreakdown(HomeData? homeData) {
    return Expanded(
        child: SizedBox(
      height: 400.h,
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income Breakdown',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            IncomRow(title: 'Rent', price: '${homeData?.income.rent} INR'),
            const Divider(),
            IncomRow(
                title: 'Membership',
                price: '${homeData?.income.membership} INR'),
            SizedBox(
              height: 30.h,
            ),
            const Text(
              'Total Loan',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            IncomRow(title: 'Active', price: '${homeData?.loans.active}'),
            const Divider(),
            IncomRow(title: 'Closed', price: '${homeData?.loans.closed}'),
          ],
        ),
      ),
    ));
  }

  // Container divider() {
  //   return Container(
  //     width: 270.w,
  //     child: const Text(
  //       '-------------------',
  //       style: TextStyle(fontSize: 30),
  //     ),
  //   );
  // }

  Row IncomRow({String? title, String? price}) {
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

  Container homeTextWidget(BuildContext context, HomeController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 146.w,
          ),
          Text(
            'Home',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            width: 90.w,
          ),
          GestureDetector(
            onTap: () {
              Get.delete<NotificationController>(force: true);
              Get.toNamed(AppRouter.getNotificationPageRoute());
            },
            child: GetBuilder<NotificationController>(builder: (notController) {
              return Stack(
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
                  notiController.notificationCount != 0
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
                              '${notiController.notificationCount ?? 0}',
                              style: const TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
