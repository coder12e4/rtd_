import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/view/home_screen/widgets/home_chart.dart';

import '../../../backend/model/home_data_model.dart';

class ChartItems extends StatelessWidget {
  const ChartItems({super.key, required this.item});
  final CollectionSummary item;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: 0,
          child: HomeChart(item: item),
        ),
        Positioned(
          top: 90.h,
          child: graphCenterText(context, item),
        ),
      ],
    );
  }

  graphCenterText(context, CollectionSummary item) {
    return Column(
      children: [
        Text(
          item.amountSummary[0].title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          '${item.amountSummary[0].amount} INR',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        kSizedBoxH,
        Text(
          item.amountSummary[1].title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          '${item.amountSummary[1].amount} INR',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ],
    );
  }
}
