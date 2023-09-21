import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/controller/loan_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:rtd_project/view/loan_screen/widgets/cancel_popup.dart';

import '../../backend/model/loan/loan_type_model.dart';
import '../../core/common_widget/imagepicker.dart';
import '../../util/theme.dart';
import '../../util/validators.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

XFile? _selectedImage;
bool image1 = false;

class _LoanPageState extends State<LoanPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoanScreenController>(builder: (value) {
        return Scaffold(
            backgroundColor: baseColor,
            body: SingleChildScrollView(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    wallTextWidget(context),
                    SizedBox(
                      height: 70.h,
                    ),
                    tabBar(),
                    tabBarView(context, value),
                  ],
                ),
              ),
            ));
      }),
    );
  }

  Container requestDate(String date) {
    return Container(
      height: 30.h,
      width: 120.w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: textFormBase),
      child: Center(
        child: Text(date, textAlign: TextAlign.center),
      ),
    );
  }

  Widget tabBarView(BuildContext context, LoanScreenController value) {
    return value.loading == true
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 200.h),
            child: Container(
                height: 100,
                width: 100,
                color: Colors.white,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ))),
          )
        : Container(
            height: 462.h,
            //hallo
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(40),
                topStart: Radius.circular(40),
              ),
            ),
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  NewRequestView(context, value),
                  requestView(context, value),
                ]),
          );
  }

  ListView requestView(BuildContext context, LoanScreenController value) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) => Column(children: [
        SizedBox(
          height: 10.h,
        ),
        requestDate('19/10/2023'),
        SizedBox(
          height: 10.h,
        ),
        requestData(index == 0 ? true : false, context, value)
      ]),
    );
  }

  Padding requestData(
      bool prossesing, BuildContext context, LoanScreenController value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: prossesing == true ? 300.h : 360.h,
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
                  Container(
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 40.h,
                    width: 140.w,
                    child: Center(
                      child: Text(
                        prossesing == true
                            ? 'Status:Prossesing'
                            : 'Status:Rejected',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 110.w,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Center(
                      child: Text(
                        'Edit Request',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              loanAmount(price: '200SR', title: 'ആവശ്യപ്പെട്ടത്:'),
              Divider(),
              imageRow(prossesing),
              SizedBox(
                height: 8.h,
              ),
              prossesing == true
                  ? ButtonWidget(
                      buttonBackgroundColor: whiteColor,
                      buttonForegroundColor: buttenBlue,
                      buttonText: 'Cancel Request',
                      borderAvalable: true,
                      controller: value,
                      press: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => CancelPopup(
                            controller: value,
                          ),
                        );
                      })
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reasons for rejection:',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const Text(
                          'Here reasons for the rejection can be shown',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          ' \ . First reason for rejection',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          ' \. Second reason for rejection',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          ' \. Third reason for rejection',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Row imageRow(bool prossesing) {
    return Row(
      children: [
        Chechmarkimage(true, true),
        Chechmarkimage(true, true),
        Chechmarkimage(false, prossesing == false ? true : false),
        Chechmarkimage(false, prossesing == false ? true : false)
      ],
    );
  }

  Stack Chechmarkimage(bool checkmark, bool markAvalable) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            minRadius: 30.r,
            backgroundImage:
                const AssetImage('assets/images/pexels-pixabay-220453 1.png'),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: markAvalable == true
                ? Container(
                    width: 20.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                        color: checkmark == true ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(50.r))),
                    child: Icon(
                      checkmark == true ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                : Container())
      ],
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
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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

  SizedBox optionButton(
      {bool? borderAvalable,
      Color? buttonForegroundColor,
      Color? buttonbackgroundColor,
      Function()? press,
      String? buttonText}) {
    return SizedBox(
        height: 40.h,
        // width: 260.w,
        child: ElevatedButton(
            style: ButtonStyle(
                side: borderAvalable == false
                    ? const MaterialStatePropertyAll(
                        BorderSide(color: Colors.black))
                    : null,
                foregroundColor: MaterialStatePropertyAll(borderAvalable == true
                    ? buttonForegroundColor
                    : buttonbackgroundColor),
                backgroundColor: MaterialStatePropertyAll(borderAvalable == true
                    ? buttonbackgroundColor
                    : buttonForegroundColor)),
            onPressed: press,
            child: Text(
              buttonText!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            )));
  }

  Padding NewRequestView(BuildContext context, LoanScreenController value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 50.h,
            width: 290.w,
            decoration: BoxDecoration(
              color: textFormBase,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20).r,
                child: DropdownButton<Data>(
                  isExpanded: true,
                  underline: Container(),
                  hint: const Center(
                    child: Text(
                      "Select Loan Type",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ThemeProvider.blackColor,
                          fontSize: 16,
                          letterSpacing: .1,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  value: value.loan,
                  // Set the initial value (hint text)
                  onChanged: (newValue) {
                    setState(() {});
                    value.loan = newValue;
                    value.purpose = newValue!.title;

                    log(value.loan!.id.toString());
                  },
                  items: value.dropdownMenuLoanType,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text('Choose Sureties', textAlign: TextAlign.start),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 80.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: value.surties!.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  log(value.surties![index].id.toString());
                  value.addSurties(value.surties![index].id);
                  log(value.addedSurties.toString());
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      minRadius: 35.r,
                      backgroundColor: textFormBase,
                      backgroundImage: NetworkImage(value
                              .surties![index].profileImage ??
                          'http://rtd.canisostudio.com/assets/images/dummy-user.jpg'),
                    ),
                    Positioned(
                      bottom: 10.h,
                      right: 0,
                      child: Container(
                        width: 20.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                            color: value.addedSurties
                                    .contains(value.surties![index].id)
                                ? Colors.green
                                : Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.r))),
                        child: value.addedSurties
                                .contains(value.surties![index].id)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                      ),
                    )
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextFormFieldWidget(
              validator: Rtd_Validators.noneEmptyValidator,
              controller: value.loanAmountController,
              textInputType: TextInputType.number,
              hitText: 'Loan Amount'),
          // SizedBox(
          //   height: 20.h,
          // ),
          // GestureDetector(
          //   onTap: () => showModalBottomSheet(
          //     context: context,
          //     builder: (context) => const PorposeWidget(),
          //   ),
          //   child: Container(
          //     height: 50.h,
          //     width: 290.w,
          //     decoration: BoxDecoration(
          //       color: textFormBase,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Center(child: Text(value.purpose ?? 'purpose')),
          //   ),
          // ),
          SizedBox(
            height: 20.h,
          ),
          ButtonWidget(
              buttonBackgroundColor: whiteColor,
              buttonForegroundColor: buttenBlue,
              buttonText: 'Attach Docements',
              borderAvalable: true,
              press: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Imagepiker(
                    onImageSelected: _updateSelectedImage,
                  ),
                );
              }),
          SizedBox(
            height: 30.h,
          ),
          ButtonWidget(
            buttonBackgroundColor: buttenBlue,
            buttonForegroundColor: whiteColor,
            buttonText: 'submit',
            borderAvalable: false,
            press: () {
              if (value.loanAmountController.text.isEmpty ||
                  value.loanAmountController.text == '') {
                showToast('Enter Amount');
                return;
              }
              if (value.purpose == null) {
                showToast('Select Loan Type and Purpose');
                return;
              }
              if (_selectedImage == null) {
                showToast('Select Document');
                return;
              }
              value.upload(_selectedImage!, value.loan!.id, value.loan!.id,
                  value.addedSurties);
            },
          )
        ],
      ),
    );
  }

  // Container feedDate(String date) {
  //   return Container(
  //     height: 30.h,
  //     width: 120.w,
  //     decoration: const BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(30)),
  //         color: textFormBase),
  //     child: Center(
  //       child: Text(date, textAlign: TextAlign.center),
  //     ),
  //   );
  // }

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
              text: 'New Request',
            ),
            Tab(
              height: 20.h,
              text: 'Request',
            )
          ]),
    );
  }

  Container wallTextWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
              )),
          Text(
            'Loan Request',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: whiteColor,
              ))
        ],
      ),
    );
  }

  void _updateSelectedImage(XFile? newImage) {
    setState(() {
      _selectedImage = newImage;
      image1 = true;
    });
  }
}
