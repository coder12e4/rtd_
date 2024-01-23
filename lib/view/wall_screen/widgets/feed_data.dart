import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rtd_project/core/common_widget/dotted_text.dart';

import '../../../controller/wall_screen_controller.dart';
import '../../../core/color/colors.dart';
import '../../../core/constraints/conatrints.dart';

class FeedDataWidget extends StatelessWidget {
  const FeedDataWidget(
      {super.key, required this.controller, required this.index});
  final WallScreenController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 18.w, right: 18.w),
      child: Container(
        decoration: BoxDecoration(
            color: textFormBase,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 40.h,
                    width: 160.w,
                    child: Center(
                      child: Text(
                        'File Number: ${controller.data!.data[index].fileNumber}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: controller.data!.data[index].status == 1
                            ? const Color.fromARGB(255, 91, 207, 95)
                            : Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        'FB: ${controller.data!.data[index].statusText}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              kSizedBoxH,
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: CachedNetworkImageProvider(
                      controller.data!.data[index].user.profileImage,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(controller.data!.data[index].user.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18))
                ],
              ),
              kSizedBoxH,
              const DashText(),
              kSizedBoxH,
              loanAmount(
                  title: 'കൊടുത്തത്:',
                  price: '${controller.data!.data[index].loanAmount} INR'),
              SizedBox(
                height: 10.h,
              ),
              reternDate(
                title: 'തിരിച്ചടവ്:',
                date: controller.data!.data[index].dueDate.toString(),
              ),
              kSizedBoxH20,
            ],
          ),
        ),
      ),
    );
  }
}

Padding loanAmount({String? title, String? price}) {
  return Padding(
    padding: EdgeInsets.only(top: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.money),
            Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
        Text(
          price!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    ),
  );
}

Padding reternDate({String? title, String? date}) {
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(date!));
  return Padding(
    padding: EdgeInsets.only(top: 5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.date_range),
            Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
        Text(
          formattedDate,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    ),
  );
}
