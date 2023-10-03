import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/book_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/view/book_screen/book_edit_screen/book_edit_screen.dart';
import 'package:rtd_project/view/book_screen/widgets/membrlisttile_widgetr.dart';

import '../../backend/model/states_model.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child:
            SizedBox(child: GetBuilder<BookScreenController>(builder: (value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appbar(context),
              Container(
                // height: 1200.h,

                height: MediaQuery.sizeOf(context).height,
                decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      kSizedBoxH20,
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: textFormBase),
                        child: DropdownButtonHideUnderline(
                          child: Center(
                            child: DropdownButton<AllStatesModel>(
                                // padding: EdgeInsets.only(left: 95.w),
                                // isExpanded: true,
                                hint: Text(
                                  "Choose Location",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.55),
                                      fontSize: 17,
                                      letterSpacing: .1,
                                      fontWeight: FontWeight.w600),
                                ),
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                value: value.selectedItem,
                                items: value.dropdownMenuItems,
                                onChanged: (valuee) {
                                  setState(() {
                                    value.selectedItem = valuee;
                                    value.statesName =
                                        value.selectedItem!.stateName;
                                    value.searchBookMember();
                                  });
                                }),
                          ),
                        ),
                      ),
                      kSizedBoxH20,
                      value.memberEmpty == true
                          ? Text(
                              '${value.memberList.length} Members',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 123, 120, 120),
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(),
                      value.memberEmpty != true
                          ? Container(
                              child: value.loading != true
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: value.memberList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const BookProfilePage(),
                                              ));
                                            },
                                            child: MemberistTileWidget(
                                              name:
                                                  value.memberList[index].name,
                                              image: value.memberList[index]
                                                  .profileImage,
                                              memberid: value
                                                  .memberList[index].memberId,
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                        color:
                                            Color.fromARGB(255, 227, 224, 224),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 500.h,
                                      child: const Center(
                                        child: SizedBox(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 6,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                            )
                          : SizedBox(
                              height: 500.h,
                              child: const Center(
                                child: Text('Member is not available'),
                              ),
                            ),
                      value.memberEmpty != true
                          ? SizedBox(
                              height: 500.h,
                              child:
                                  const Center(child: Text('search member ')))
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          );
        })),
      ),
    ));
  }

  Container appbar(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 110.w,
              ),
              Text(
                'Member Book',
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
                  Get.toNamed(AppRouter.getElectedMemberRoute());
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => ElectedMemberScreen(),
                  // ));
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
