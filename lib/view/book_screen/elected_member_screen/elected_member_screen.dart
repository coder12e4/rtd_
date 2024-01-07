import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/elected_member_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/view/book_screen/widgets/electedmembers_list_tile.dart';

import '../../../controller/book/board_member_details_controller.dart';
import '../../../helper/router.dart';

class ElectedMemberScreen extends StatelessWidget {
  const ElectedMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: GetBuilder<ElectedMemberController>(builder: (value) {
          return Column(
            children: [
              appbar(context),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
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
                            itemCount: electedMembers.length,
                            padding: EdgeInsets.only(top: 30.h),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (value.isStart != null ||
                                      value.isStart == false) {
                                    Get.delete<BoardMemberDetailsController>(
                                        force: true);
                                    Get.toNamed(
                                        AppRouter
                                            .getBoardMemberDetailsRoutesRoute(),
                                        arguments: [electedMembers[index].id]);
                                  }
                                },
                                child: ElectedMemberListTileWidget(
                                  data: electedMembers[index],
                                ),
                              );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     icon: const Icon(
              //       Icons.arrow_back,
              //       color: whiteColor,
              //     )),
              // SizedBox(
              //   width: 90.w,
              // ),
              Text(
                'Elected Members',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),

              // IconButton(
              //   onPressed: () {
              //     Get.toNamed(AppRouter.getElectedMemberRoute());
              //   },
              //   icon: const Icon(
              //     Icons.people_alt_rounded,
              //   ),
              //   color: whiteColor,
              // ),
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.notifications_none,
              //       color: whiteColor,
              //       size: 28,
              //     ))
            ],
          ),
        ],
      ),
    );
  }
}
