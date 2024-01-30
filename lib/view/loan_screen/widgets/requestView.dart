import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/loan/loan_screen_controller.dart';
import '../../../core/constraints/conatrints.dart';
import '../../wall_screen/widgets/date_widget.dart';
import 'request_data_widget.dart';

class RequestView extends StatelessWidget {
  const RequestView({super.key, required this.value});
  final LoanScreenController value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.5.h),
      child: value.loanData.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(bottom: 10.h),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.loanData.length,
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  kSizedBoxH,
                  DateWidget(date: value.loanData[index].createdAt.toString()),
                  kSizedBoxH,
                  RequestData(value: value, index: index),
                ],
              ),
            )
          : const Center(
              child: Text(
                'No request Found',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ),
    );
  }
}
