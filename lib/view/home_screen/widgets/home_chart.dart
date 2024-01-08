import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/home_screen_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../backend/model/home_data_model.dart';

class HomeChart extends StatelessWidget {
  const HomeChart({
    super.key,
    required this.item,
  });
  final CollectionSummary item;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (value) {
      return SfCircularChart(
        title: ChartTitle(
          text: item.title,
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        series: <CircularSeries>[
          RadialBarSeries<ChartSampleData, String>(
            dataSource: <ChartSampleData>[
              ChartSampleData(
                x: 'remaining',
                y: item.amountSummary[1].amount.toDouble(),
                color: const Color.fromARGB(255, 147, 8, 96),
              ),
            ],
            xValueMapper: (ChartSampleData data, _) => data.x,
            yValueMapper: (ChartSampleData data, _) => data.y,
            pointColorMapper: (ChartSampleData data, _) => data.color,
            radius: '100%',
            dataLabelSettings: const DataLabelSettings(
              isVisible: false,
            ),
            trackColor: const Color.fromARGB(255, 207, 200, 200),
            enableTooltip: true,
            innerRadius: "90",
            maximumValue: item.amountSummary[0].amount.toDouble(),
          ),
        ],
      );
    });
  }
}

class ChartSampleData {
  final String x;
  final double y;
  final Color color;

  ChartSampleData({required this.x, required this.y, this.color = Colors.blue});
}
