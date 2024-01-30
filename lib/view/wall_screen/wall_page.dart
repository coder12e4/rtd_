import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/wall_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/appbar.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

import 'widgets/feed_view.dart';
import 'widgets/vote_view.dart';

class WallPage extends StatelessWidget {
  const WallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              kSizedBoxH,
              const CustomAppBar(title: "Wall"),
              kSizedBoxH,
              tabBar(),
              tabBarView(context),
            ],
          ),
        ),
      ),
    );
  }

  Expanded tabBarView(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(40),
            topStart: Radius.circular(40),
          ),
        ),
        child: GetBuilder<WallScreenController>(
          builder: (value) {
            return Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: TabBarView(children: [
                FeedView(controller: value),
                VoteView(controller: value),
              ]),
            );
          },
        ),
      ),
    );
  }

  Padding tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.w),
      child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              height: 20.h,
              text: 'feed',
            ),
            Tab(
              height: 20.h,
              text: 'Votes',
            )
          ]),
    );
  }

  Text wallTextWidget(BuildContext context) {
    return Text(
      'Wall',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}
