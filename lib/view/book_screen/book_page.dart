import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/dropdown_widget.dart';
import 'package:rtd_project/view/book_screen/book_edit_screen/book_edit_screen.dart';
import 'package:rtd_project/view/book_screen/widgets/membrlisttile_widgetr.dart';

class BookPage extends StatelessWidget {
  BookPage({super.key});

  final List<String> locationlist = [
    'Location 1',
    'Location 2',
    'Location 3',
    'Location 4',
    'Location 5',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appbar(context),
            Container(
              // height: 1200.h,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 18.0.h),
                    child: Center(
                      child: DropedownWidget(
                          hintText: 'Location', dropDownlist: locationlist),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 28.0.h, left: 40.w),
                    child: const Text(
                      '08 Members',
                      style: TextStyle(
                          color: Color.fromARGB(255, 123, 120, 120),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.all(30),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BookEditPage(),
                            ));
                          },
                          child: const MemberistTileWidget(),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Color.fromARGB(255, 227, 224, 224),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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
                onPressed: () {},
                icon: Icon(
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
