import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/elected_member_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/view/book_screen/widgets/electedmembers_list_tile.dart';

class ElectedMemberScreen extends StatelessWidget {
  ElectedMemberScreen({super.key});
  final List imageList = [
    'assets/images/Group 5 (1).png',
    'assets/images/Group 5 (2).png',
    'assets/images/Group 5.png',
    'assets/images/Group 6 (1).png',
    'assets/images/Group 6 (2).png',
    'assets/images/Group 6.png'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: GetBuilder<ElectedMemberController>(builder: (value) {
            return Column(
              children: [
                appbar(context),
                Container(
                  // height: 700.h,
                  width: 390.w,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 700.h,
                        child: FutureBuilder(
                            future: value.getElectedMembers(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CupertinoActivityIndicator(radius: 20),
                                );
                              }
                              if (snapshot.hasData) {
                                final electedMembers = snapshot.data!;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: electedMembers.length,
                                  padding: EdgeInsets.only(top: 30.h),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return ElectedMemberListTileWidget(
                                      image: imageList[index],
                                      data: electedMembers[index],
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                  )),
              SizedBox(
                width: 50.w,
              ),
              Text(
                'Elected Members',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                width: 30.w,
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRouter.electedMemberRoutes);
                },
                icon: const Icon(
                  Icons.people_alt_rounded,
                ),
                color: whiteColor,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none,
                    color: whiteColor,
                    size: 28,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
