import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';
import 'package:rtd_project/controller/home_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/view/notification/notification.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController contoller = Get.find();
// @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }
  // @override
  // void dispose() {
  //   Get.delete<HomeController>(force: true);
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: baseColor,
            body: SingleChildScrollView(
              child: FutureBuilder<HomeData>(
                  future: contoller.getHomeDatas(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: 690.h,
                        width: 390.w,
                        color: Colors.white,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 6,
                        )),
                      );
                    }

                    final HomeData homeData = snapshot.data!;
                    return Column(
                      children: [
                        homeTextWidget(context),
                        Container(
                          // height: 1050.h,
                          //hallo
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(40),
                              topStart: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                              // physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Container(
                                    height: 500.h,
                                    // width: 100.w,
                                    decoration: BoxDecoration(
                                        color: textFormBase,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 68.h,
                                                vertical: 68.w),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    child:
                                                        AnimatedCircularChart(
                                                      holeRadius: 70.r,
                                                      key: _chartKey,
                                                      size: Size(350.w, 100.h),
                                                      initialChartData: <CircularStackEntry>[
                                                        CircularStackEntry(
                                                          <CircularSegmentEntry>[
                                                            CircularSegmentEntry(
                                                              homeData
                                                                      .data
                                                                      .graphData
                                                                      .graphCount
                                                                      .toDouble() ??
                                                                  0.0,
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  147,
                                                                  8,
                                                                  96),
                                                              rankKey:
                                                                  'remaining',
                                                            ),
                                                            CircularSegmentEntry(
                                                              100 -
                                                                  homeData
                                                                      .data
                                                                      .graphData
                                                                      .graphCount
                                                                      .toDouble(),
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  207,
                                                                  200,
                                                                  200),
                                                              rankKey:
                                                                  'completed',
                                                            ),
                                                          ],
                                                          rankKey: 'progress',
                                                        ),
                                                      ],
                                                      chartType:
                                                          CircularChartType
                                                              .Radial,
                                                      percentageValues: true,
                                                      // holeLabel: 'Total Collection',
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: baseColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24.0,
                                                      ),
                                                      edgeStyle:
                                                          SegmentEdgeStyle
                                                              .round,
                                                      startAngle: BorderSide
                                                          .strokeAlignOutside,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 30.w,
                                                  child: graphCenterText(
                                                      context, homeData),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        incomBreakdown(homeData),
                                      ],
                                    ),
                                  ),
                                ),
                                activeLoan(homeData),
                              ]),
                        ),
                      ],
                    );
                  }),
            )));
  }

  graphCenterText(context, homeData) {
    return Column(
      children: [
        const Text(
          'Total Collection',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          homeData.data.graphData.totalCollection.toString(),
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox(
          height: 10.h,
        ),
        const Text(
          'Balance',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          '${homeData.data.graphData.balance}SR',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ],
    );
  }

  Container activeLoan(homeData) {
    return Container(
      // height: 200.h,
      child: Padding(
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
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeData.data.activeLoan.length,
                itemBuilder: (context, index) {
                  return activeLoanData(homeData.data.activeLoan![index]);
                })
          ],
        ),
      ),
    );
  }

  Padding activeLoanData(data) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        height: 170.h,
        decoration: BoxDecoration(
            color: textFormBase,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
          child: Column(
            children: [
              IncomRow(price: '${data.loanAmount}SR', title: 'Loan Amount'),
              const Divider(),
              activeLoanRow(title: 'Start Date', date: '${data.startDate}'),
              activeLoanRow(title: 'End Date', date: '${data.endDate}'),
              activeLoanRow(title: 'Loan Type', date: '${data.loanType}')
            ],
          ),
        ),
      ),
    );
  }

  Expanded incomBreakdown(homeData) {
    return Expanded(
        child: Container(
      height: 450.h,
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
            IncomRow(
                title: homeData.data.incomeBreakdown.typeOfJob,
                price: '${homeData.data.incomeBreakdown.memebershipAmound}SR'),
            const Divider(),
            IncomRow(
                title: 'Membership',
                price: '${homeData.data.incomeBreakdown.memebershipAmound}SR'),
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
            IncomRow(
                title: 'Active',
                price: '${homeData.data.incomeBreakdown.activeLoans}'),
            const Divider(),
            IncomRow(
                title: 'Closed',
                price: '${homeData.data.incomeBreakdown.closedLoans}'),
          ],
        ),
      ),
    ));
  }

  Container divider() {
    return Container(
      width: 270.w,
      child: const Text(
        '-------------------',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

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

  Container homeTextWidget(BuildContext context) {
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
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ));
              },
              icon: const Icon(
                Icons.notifications_none,
                color: whiteColor,
              ))
        ],
      ),
    );
  }
}

final GlobalKey<AnimatedCircularChartState> _chartKey =
    GlobalKey<AnimatedCircularChartState>();
