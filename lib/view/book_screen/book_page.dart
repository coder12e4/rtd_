import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/book/book_screen_controller.dart';
import 'package:rtd_project/controller/elected_member_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/helper/router.dart';
import 'package:rtd_project/view/book_screen/widgets/membrlisttile_widgetr.dart';

import '../../backend/model/books/services_model.dart';
import '../../backend/model/states_model.dart';
import '../../controller/book/board_member_details_controller.dart';

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
        child: GetBuilder<BookScreenController>(builder: (value) {
          return DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                appbar(context),
                tabBar(),
                tabBarView(context, value),
              ],
            ),
          );
        }),
      ),
    ));
  }

  Padding tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
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
              text: 'Members',
            ),
            Tab(
              height: 20.h,
              text: 'Services',
            )
          ]),
    );
  }

  Widget tabBarView(BuildContext context, BookScreenController value) {
    return Container(
      height: 562.h,
      //hallo
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(40),
          topStart: Radius.circular(40),
        ),
      ),
      child: TabBarView(children: [
        memberBook(context, value),
        serviceBook(context, value),
      ]),
    );
  }

  Padding serviceBook(BuildContext context, BookScreenController value) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          kSizedBoxH20,
          Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 145.w,
                padding: const EdgeInsets.only(left: 5, right: 5).r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: textFormBase),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<AllStatesModel>(
                      // padding: EdgeInsets.only(left: 95.w),
                      isExpanded: true,
                      hint: Text(
                        "Choose State",
                        style: TextStyle(
                            color: Colors.black.withOpacity(.55),
                            fontSize: 15,
                            letterSpacing: .1,
                            fontWeight: FontWeight.w600),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      value: value.selectedState,
                      items: value.dropdownServiceItems,
                      onChanged: (valuee) {
                        setState(() {
                          value.selectedState = valuee;
                          value.serviceStateName =
                              value.selectedState!.stateName;
                          value.searchServiceList('');
                        });
                      }),
                ),
              ),
              Container(
                width: 175.w,
                padding: const EdgeInsets.only(left: 5, right: 5).r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: textFormBase),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ServiceData>(
                      padding: const EdgeInsets.all(0.0),
                      isExpanded: true,
                      hint: Text(
                        "Choose Service ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.55),
                            fontSize: 15,
                            letterSpacing: .1,
                            fontWeight: FontWeight.w600),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      value: value.selectedService,
                      items: value.serviceMenuItems,
                      onChanged: (valuee) {
                        setState(() {
                          value.selectedService = valuee;
                          value.serviceName = value.selectedService!.title;
                          value.searchServiceList('');
                        });
                      }),
                ),
              ),
            ],
          ),
          kSizedBoxH,
          searchField(
            value: value,
            controller: value.serviceSearchController,
            onChanged: (query) {
              value.searchServiceList(query);
            },
          ),
          kSizedBoxH,
          value.servicesMemberList?.data.length != 0
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.servicesMemberList?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(
                            AppRouter.getServiceMemberProfileRoutesRoute(),
                            arguments: [
                              value.servicesMemberList!.data[index].id
                            ]),
                        child: MemberistTileWidget(
                          name: value.servicesMemberList!.data[index].name,
                          image: value
                              .servicesMemberList!.data[index].profileImage,
                          memberid:
                              value.servicesMemberList!.data[index].service,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Color.fromARGB(255, 227, 224, 224),
                  ),
                )
              : const Expanded(
                  child: Center(
                    child: Text('Not Available'),
                  ),
                ),
        ],
      ),
    );
  }

  Padding memberBook(BuildContext context, BookScreenController value) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          kSizedBoxH20,
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: textFormBase),
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
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    value: value.selectedItem,
                    items: value.dropdownMenuItems,
                    onChanged: (valuee) {
                      setState(() {
                        value.selectedItem = valuee;
                        value.statesName = value.selectedItem!.stateName;
                        value.searchBookMember("");
                      });
                    }),
              ),
            ),
          ),
          kSizedBoxH,
          searchField(
            value: value,
            controller: value.memberSearchController,
            onChanged: (p0) => value.searchBookMember(p0),
          ),
          kSizedBoxH,
          value.memberList.isNotEmpty
              ? Text(
                  '${value.memberList.length} Members',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 123, 120, 120),
                      fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
          value.loading != true
              ? Container(
                  child: value.memberList.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.memberList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.delete<BoardMemberDetailsController>(
                                      force: true);
                                  Get.toNamed(
                                      AppRouter
                                          .getBoardMemberDetailsRoutesRoute(),
                                      arguments: [value.memberList[index].id]);
                                },
                                child: MemberistTileWidget(
                                  name: value.memberList[index].name,
                                  image: value.memberList[index].image,
                                  memberid: value.memberList[index].position,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(
                            color: Color.fromARGB(255, 227, 224, 224),
                          ),
                        )
                      : value.initial == false
                          ? SizedBox(
                              height: 400.h,
                              child: const Center(
                                child: Text('Member is not available'),
                              ),
                            )
                          : const Offstage(),
                )
              : SizedBox(
                  height: 400.h,
                  child: const Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  SizedBox searchField({
    BookScreenController? value,
    TextEditingController? controller,
    Function(String)? onChanged,
  }) {
    return SizedBox(
      height: 40.h,
      child: SearchBar(
        controller: controller,
        backgroundColor: const MaterialStatePropertyAll(textFormBase),
        surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
        elevation: const MaterialStatePropertyAll(0),
        trailing: const [Icon(Icons.search)],
        hintText: 'Search',
        onChanged: onChanged,
      ),
    );
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
                width: 100.w,
              ),
              Text(
                'Member & Service Book',
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
                  Get.delete<ElectedMemberController>(force: true);
                  Get.toNamed(AppRouter.getElectedMemberRoute(),
                      arguments: [false]);
                },
                icon: const Icon(
                  Icons.people_alt_rounded,
                ),
                color: whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
