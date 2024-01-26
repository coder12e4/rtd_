import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/wall_screen_controller.dart';
import '../../../core/constraints/conatrints.dart';
import 'date_widget.dart';
import 'vote_data_widget.dart';

class VoteView extends StatelessWidget {
  const VoteView({super.key, required this.controller});
  final WallScreenController controller;
  @override
  Widget build(BuildContext context) {
    return controller.votesData.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.only(bottom: 10.h),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.votesData.length,
            itemBuilder: (context, index) => Column(
              children: [
                kSizedBoxH,
                DateWidget(
                  date: controller.votesData[index].createdAt.toString(),
                ),
                VoteDataWidget(index: index, controller: controller)
              ],
            ),
          )
        : const Center(
            child: Text(
            "Votes is empty",
            style: TextStyle(fontWeight: FontWeight.w600),
          ));
  }
}
