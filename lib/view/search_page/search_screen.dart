import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/searh_screen_controller.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';

import '../../core/color/colors.dart';
import '../book_screen/widgets/membrlisttile_widgetr.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put<LoanScreenController>(LoanScreenController(parser: Get.find()));
    return Scaffold(
      backgroundColor: baseColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align items to the start (left)
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                  ),
                ),
                SizedBox(
                  width: 105.w,
                ),
                Text(
                  'Sureties',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(40),
                  topStart: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, left: 25.w, right: 25.w),
                child: GetBuilder<SearchScreenController>(builder: (value) {
                  return value.loading == false
                      ? Column(
                          children: [
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
                            kSizedBoxH,
                            value.searchResult!.isNotEmpty
                                ? Flexible(
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          value.addSurties(
                                              value.searchResult![index]);
                                        },
                                        child: MemberistTileWidget(
                                            name:
                                                value.searchResult![index].name,
                                            image: value.searchResult![index]
                                                .profileImage,
                                            memberid: value.searchResult![index]
                                                    .memberId ??
                                                "Not Available"),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                        color:
                                            Color.fromARGB(255, 227, 224, 224),
                                      ),
                                      itemCount:
                                          value.searchResult?.length ?? 0,
                                    ),
                                  )
                                : const Expanded(
                                    child: Center(
                                      child: Text('No result Found'),
                                    ),
                                  ),
                          ],
                        )
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
        ],
      ),
    );
  }
}
