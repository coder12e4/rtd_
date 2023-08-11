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
                    height: 610.h,
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
                              height: 300.h,
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
                                          holeRadius: 0.1,
                                          key: _chartKey,
                                          size: Size(200.w, 100.h),
                                          initialChartData: const <CircularStackEntry>[
                                            CircularStackEntry(
                                              <CircularSegmentEntry>[
                                                CircularSegmentEntry(
                                                  33.33,
                                                  Color.fromARGB(
                                                      255, 96, 91, 91),
                                                  rankKey: 'completed',
                                                ),
                                                CircularSegmentEntry(
                                                  66.67,
                                                  Color.fromARGB(
                                                      255, 147, 8, 96),
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
                                            color: baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0,
                                          ),
                                          edgeStyle: SegmentEdgeStyle.round,
                                          startAngle:
                                              BorderSide.strokeAlignOutside,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  )
                ],
              ),
            )));
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
