import 'package:flutter/material.dart';

import '../../../controller/wall_screen_controller.dart';
import '../../../core/constraints/conatrints.dart';
import '../../../util/theme.dart';
import 'date_widget.dart';
import 'feed_data.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key, required this.controller});
  final WallScreenController controller;
  @override
  Widget build(BuildContext context) {
    return controller.loading == true
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: ThemeProvider.blackColor,
            ),
          )
        : Column(
            children: [
              Expanded(
                child: controller.data?.data.length != 0 ||
                        controller.data?.data == null
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.data?.data.length ?? 0,
                        itemBuilder: (context, index) => Column(
                          children: [
                            DateWidget(
                                date: controller
                                    .data!.data[index].user.createdAt
                                    .toString()),
                            FeedDataWidget(
                                controller: controller, index: index),
                            kSizedBoxH,
                          ],
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Feed is empty",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
              ),
            ],
          );
  }
}
