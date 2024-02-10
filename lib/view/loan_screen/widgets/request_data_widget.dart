import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/loan/loan_edit_controller.dart';
import '../../../controller/loan/loan_request_detail_controller.dart';
import '../../../controller/loan/loan_screen_controller.dart';
import '../../../core/color/colors.dart';
import '../../../core/common_widget/commen_botten.dart';
import '../../../core/common_widget/dotted_text.dart';
import '../../../helper/router.dart';
import '../../../util/theme.dart';
import 'cancel_popup.dart';

class RequestData extends StatelessWidget {
  const RequestData({super.key, required this.value, required this.index});
  final LoanScreenController value;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () {
          Get.delete<LoanRequestDetailsController>(force: true);
          Get.toNamed(AppRouter.getLoanRequestDetailsRoutes(),
              arguments: [value.loanData[index].id, true, 2]);
        },
        child: Container(
          // height: prossesing == true ? 300.h : 360.h,
          height: 300.h,
          width: 500.w,
          decoration: BoxDecoration(
              color: textFormBase,
              borderRadius: BorderRadius.all(Radius.circular(30.r))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    loanStatusContainer(value, index),
                    value.loanData[index].status == 0
                        ? GestureDetector(
                            onTap: () {
                              Get.delete<LoanEditController>(force: true);
                              Get.toNamed(AppRouter.getLoanEditRoute(),
                                  arguments: [value.loanData[index].id]);
                            },
                            child: Container(
                              height: 40.h,
                              width: 110.w,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Center(
                                child: Text(
                                  'Edit Request',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 50.w,
                          )
                  ],
                ),
                const DashText(),
                loanAmount(
                    price: value.loanData[index].loanAmount,
                    title: 'ആവശ്യപ്പെട്ടത്:'),
                const DashText(),

                imageRow(value, index),

                SizedBox(
                  height: 8.h,
                ),
                value.loanData[index].status != 1 &&
                        value.loanData[index].status != 2
                    ? ButtonWidget(
                        buttonBackgroundColor: value.loanData[index].status != 3
                            ? whiteColor
                            : Colors.grey,
                        buttonForegroundColor: value.loanData[index].status != 3
                            ? buttenBlue
                            : whiteColor,
                        buttonText: value.loanData[index].status != 3
                            ? 'Cancel Request'
                            : 'cancelled',
                        borderAvalable:
                            value.loanData[index].status == 0 ? true : false,
                        controller: value,
                        press: () {
                          value.loanData[index].status != 3
                              ? showModalBottomSheet(
                                  context: context,
                                  builder: (context) => CancelPopup(
                                    controller: value,
                                    index: index,
                                  ),
                                )
                              : null;
                        })
                    : const Offstage(),
                // : Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Reasons for rejection:',
                //         style: TextStyle(
                //             color: Colors.black54,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       SizedBox(
                //         height: 8.h,
                //       ),
                //       const Text(
                //         'Here reasons for the rejection can be shown',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       ),
                //       const Text(
                //         ' \ . First reason for rejection',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       ),
                //       const Text(
                //         ' \. Second reason for rejection',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       ),
                //       const Text(
                //         ' \. Third reason for rejection',
                //         style: TextStyle(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       )
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Container loanStatusContainer(LoanScreenController value, int index) {
  if (value.loanData[index].status == 3) {
    return Container(
      decoration: const BoxDecoration(
          color: ThemeProvider.blackColor,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      height: 40.h,
      width: 150.w,
      child: Center(
        child: Text(
          'Status:  ${value.loanData[index].statusText}',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: ThemeProvider.whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  if (value.loanData[index].status == 1) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      height: 40.h,
      width: 150.w,
      child: Center(
        child: Text(
          'Status:  ${value.loanData[index].statusText}',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: ThemeProvider.whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  if (value.loanData[index].status == 2) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      height: 40.h,
      width: 150.w,
      child: Center(
        child: Text(
          'Status:  ${value.loanData[index].statusText}',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: ThemeProvider.whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  return Container(
    decoration: const BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.all(Radius.circular(30))),
    height: 40.h,
    width: 150.w,
    child: Center(
      child: Text(
        'Status:  ${value.loanData[index].statusText}',
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
  );
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
          '$price INR',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    ),
  );
}

Widget imageRow(LoanScreenController controller, int index) {
  return SizedBox(
    height: 80.h,
    child: controller.loanData[index].sureties.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, imageIndex) =>
                checkMarkImage(controller, index, imageIndex),
            separatorBuilder: (context, index) => SizedBox(
                  width: 18.w,
                ),
            itemCount: controller.loanData[index].sureties.length)
        : const Center(
            child: Text(
              'Sureties not added',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
  );
}

Widget checkMarkImage(
    LoanScreenController controller, int index, int imageIndex) {
  return Container(
      height: 60.h,
      width: 60.h,
      child: Column(children: [
        Stack(
          children: [
            CircleAvatar(
              minRadius: 30.r,
              backgroundImage: CachedNetworkImageProvider(
                  controller.loanData[index].sureties[imageIndex].profileImage),
            ),
            Positioned(
              bottom: 0.h,
              right: 0,
              child: surtieStatus(controller, index, imageIndex),
            )
          ],
        ),
        Text(
          "${controller.loanData[index].sureties[imageIndex].name}",
          style: TextStyle(
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ]));
}

Container surtieStatus(
    LoanScreenController controller, int index, int imageIndex) {
  if (controller.loanData[index].sureties[imageIndex].status == 0) {
    return Container(
      width: 20.w,
      height: 18.h,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(50.r))),
      child: const Icon(
        Icons.pending_actions,
        color: Colors.white,
        size: 16,
      ),
    );
  }
  if (controller.loanData[index].sureties[imageIndex].status == 1) {
    return Container(
      width: 20.w,
      height: 18.h,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(50.r))),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  return Container(
    width: 20.w,
    height: 18.h,
    decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(50.r))),
    child: const Icon(
      Icons.close,
      color: Colors.white,
      size: 16,
    ),
  );
}
