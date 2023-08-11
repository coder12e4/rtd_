import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                            height: 400.h,
                            // width: 100.w,
                            decoration: BoxDecoration(
                                color: textFormBase,
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(98.0),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: Container(
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
                                                        255, 147, 8, 96),
                                                    rankKey: 'remaining',
                                                  ),
                                                  CircularSegmentEntry(
                                                    33.33,
                                                    Color.fromARGB(
                                                        255, 207, 200, 200),
                                                    rankKey: 'completed',
                                                  ),
                                                ],
                                                rankKey: 'progress',
                                              ),
                                            ],
                                            chartType: CircularChartType.Radial,
                                            percentageValues: true,
                                            // holeLabel: 'Total Collection',
                                            labelStyle: const TextStyle(
                                              color: baseColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                            ),
                                            edgeStyle: SegmentEdgeStyle.round,
                                            startAngle:
                                                BorderSide.strokeAlignOutside,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 30.w,
                                        child: graphCenterText(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));

  }

  graphCenterText(context) {
    return Column(
      children: [
        const Text(
          'Total Collection',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          '1000SR',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          height: 10.h,
        ),
        const Text(
          'Balance',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          '800SR',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
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
