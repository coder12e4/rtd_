import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/elected_member_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/appbar.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
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
              const CustomAppBar(title: 'Elected Members'),
              kSizedBoxH,
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
}
