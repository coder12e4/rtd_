import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: baseColor,
            body: SingleChildScrollView(
              child: Column(
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
                              height: 530.h,
                              // width: 100.w,
                              decoration: BoxDecoration(
                                  color: textFormBase,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                        padding: const EdgeInsets.all(68.0),
                                        child: AnimatedCircularChart(
                                          holeRadius: 70.r,
                                          key: _chartKey,
                                          size: Size(350.w, 100.h),
                                          initialChartData: const <CircularStackEntry>[
                                            CircularStackEntry(
                                              <CircularSegmentEntry>[
                                                CircularSegmentEntry(
                                                  66.67,
                                                  Color.fromARGB(
                                                    255,
                                                    139,
                                                    63,
                                                    111,
                                                  ),
                                                  rankKey: 'completed',
                                                ),
                                                CircularSegmentEntry(
                                                  33.33,
                                                  Color.fromARGB(
                                                      255, 221, 217, 217),
                                                  rankKey: 'remaining',
                                                ),
                                              ],
                                              rankKey: 'progress',
                                            ),
                                          ],
                                          chartType: CircularChartType.Radial,
                                          percentageValues: true,
                                          holeLabel: '1/3',
                                          labelStyle: TextStyle(
                                            color: Colors.blueGrey[600],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0,
                                          ),
                                          edgeStyle: SegmentEdgeStyle.round,
                                          startAngle:
                                              BorderSide.strokeAlignInside,
                                        )),
                                  ),
                                  incomBreakdown(),
                                ],
                              ),
                            ),
                          ),
                          activeLoan(),
                        ]),
                  ),
                ],
              ),
            )));
  }

  Container activeLoan() {
    return Container(
      // height: 200.h,
      child: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
              child: Text(
                'Active Loan',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => activeLoanData(),
            )
          ],
        ),
      ),
    );
  }

  Padding activeLoanData() {
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
              IncomRow(price: '10SR', title: 'Loan Amount'),
              Divider(),
              activeLoanRow(title: 'Start Date', date: '09/09/2023'),
              activeLoanRow(title: 'End Date', date: '09/10/2023'),
              activeLoanRow(title: 'Loan Type', date: 'Scheme Name Here')
            ],
          ),
        ),
      ),
    );
  }

  Expanded incomBreakdown() {
    return Expanded(
        child: Container(
      height: 450.h,
      child: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income Breakdown',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            IncomRow(title: 'Truck', price: '700SR'),
            Divider(),
            IncomRow(title: 'Membership', price: '300SR'),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Total Loan',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            IncomRow(title: 'Active', price: '10'),
            Divider(),
            IncomRow(title: 'Closed', price: '50'),
          ],
        ),
      ),
    ));
  }

  Container Divider() {
    return Container(
      width: 270.w,
      child: Text(
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
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        Text(
          price!,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
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
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          Text(
            date!,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
              onPressed: () {},
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
