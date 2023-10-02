import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/searh_screen_controller.dart';
import 'package:rtd_project/util/theme.dart';

import '../../core/color/colors.dart';
import '../book_screen/widgets/membrlisttile_widgetr.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 90.h),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(40),
                  topStart: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 35.h, left: 25.w, right: 25.w),
                child: GetBuilder<SearchScreenController>(builder: (value) {
                  return value.loading == false
                      ? Column(children: [
                          SearchBar(
                            controller: value.serchController,
                            backgroundColor:
                                const MaterialStatePropertyAll(textFormBase),
                            surfaceTintColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            elevation: const MaterialStatePropertyAll(0),
                            trailing: const [Icon(Icons.search)],
                            hintText: 'Search',
                            onChanged: value.searchSurties,
                          ),
                          value.searchResult!.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        value.addSurties(
                                            value.searchResult![index]);
                                      },
                                      child: MemberistTileWidget(
                                          name: value.searchResult![index].name,
                                          image: value.searchResult![index]
                                              .profileImage,
                                          memberid: value
                                              .searchResult![index].memberId),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      color: Color.fromARGB(255, 227, 224, 224),
                                    ),
                                    itemCount: value.searchResult?.length ?? 0,
                                  ),
                                )
                              : SizedBox(
                                  height: 500.h,
                                  child: const Center(
                                    child: Text('No result Found'),
                                  ),
                                ),
                        ])
                      : const Center(
                          child: CircularProgressIndicator(
                            color: ThemeProvider.blackColor,
                            strokeWidth: 6,
                          ),
                        );
                }),
              ),
            ),
          ),
        ));
  }
}
