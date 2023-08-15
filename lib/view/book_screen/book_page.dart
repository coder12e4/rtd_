import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/common_widget/dropdown_widget.dart';
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
      body: SingleChildScrollView(
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
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){},
                    child: MemberistTileWidget(),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            )
          ],
        ),
      ),
    ));
  }
}
