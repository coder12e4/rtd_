import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../backend/model/home_data_model.dart';
import '../../../core/color/colors.dart';

class HomeChart extends StatelessWidget {
  const HomeChart({
    super.key,
    required this.item,
  });
  final CollectionSummary item;
  @override
  Widget build(BuildContext context) {
    return AnimatedCircularChart(
      holeRadius: 65.r,

      size: Size(350.w, 100.h),
      initialChartData: <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
              // 30.2,
              (item.amountSummary[1].amount).toDouble(),
              const Color.fromARGB(255, 147, 8, 96),
              rankKey: 'remaining',
            ),
            CircularSegmentEntry(
              (item.amountSummary[0].amount).toDouble(),
              const Color.fromARGB(255, 207, 200, 200),
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
      startAngle: BorderSide.strokeAlignOutside,
    );
  }
}
