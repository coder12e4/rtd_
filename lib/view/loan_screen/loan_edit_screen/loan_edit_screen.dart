import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/model/loan/loan_type_model.dart';
import 'package:rtd_project/controller/loan/loan_edit_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';

import '../../../core/common_widget/commen_botten.dart';
import '../../../core/common_widget/imagepicker.dart';
import '../../../core/common_widget/textformfield_widget.dart';
import '../../../helper/router.dart';
import '../../../util/toast.dart';
import '../../../util/validators.dart';

class LoanEditScreen extends StatefulWidget {
  const LoanEditScreen({super.key});

  @override
  State<LoanEditScreen> createState() => _LoanEditScreenState();
}

XFile? _selectedImage;

class _LoanEditScreenState extends State<LoanEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: WillPopScope(
        onWillPop: () async {
          _selectedImage == null;
          return true;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                appBarWidget(context),
                GetBuilder<LoanEditController>(builder: (value) {
                  return value.loading == true
                      ? Container(
                          height: 590.h,
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(40),
                              topStart: Radius.circular(40),
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: ThemeProvider.blackColor,
                            ),
                          ),
                        )
                      : Container(
                          height: 590.h,
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(40),
                              topStart: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      padding: const EdgeInsets.only(
                                              right: 20, left: 20)
                                          .r,
                                      child: DropdownButton<Data>(
                                        isExpanded: true,
                                        underline: Container(),
                                        hint: Center(
                                          child: Text(
                                            "Select Loan Type",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.55),
                                                fontSize: 17,
                                                letterSpacing: .1,
                                                fontWeight: FontWeight.w600),
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
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Sureties')),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 80.h,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) => value
                                                .isSelected[index] ==
                                            false
                                        ? GestureDetector(
                                            onTap: () => Get.toNamed(
                                                AppRouter
                                                    .getSearchScreenRoute(),
                                                arguments: [index, true]),
                                            child: CircleAvatar(
                                              minRadius: 35.r,
                                              backgroundColor: textFormBase,
                                              child: const Icon(Icons.add),
                                            ),
                                          )
                                        : Stack(
                                            children: [
                                              CircleAvatar(
                                                minRadius: 35.r,
                                                backgroundColor: textFormBase,
                                                backgroundImage: NetworkImage(
                                                    value.surties[index]!
                                                        .profileImage),
                                              ),
                                              Positioned(
                                                bottom: 9.h,
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      value.deleteSurety(index),
                                                  child: CircleAvatar(
                                                    minRadius: 15.r,
                                                    backgroundColor:
                                                        ThemeProvider
                                                            .blackColor,
                                                    child: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      width: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormFieldWidget(
                                    validator:
                                        Rtd_Validators.noneEmptyValidator,
                                    controller: value.loanAmountController,
                                    textInputType: TextInputType.number,
                                    hitText: 'Loan Amount'),
                                kSizedBoxH,

                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Document')),
                                kSizedBoxH,
                                documentContainer(
                                    value.loanData!.data.loanDocument),

                                SizedBox(
                                  height: 20.h,
                                ),
                                // ButtonWidget(
                                //     buttonBackgroundColor: whiteColor,
                                //     buttonForegroundColor: buttenBlue,
                                //     buttonText: 'Attach Docements',
                                //     borderAvalable: true,
                                //     press: () {
                                //       showModalBottomSheet(
                                //         context: context,
                                //         builder: (context) => Imagepiker(
                                //           onImageSelected: _updateSelectedImage,
                                //         ),
                                //       );
                                //     }),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                                ButtonWidget(
                                  buttonBackgroundColor: buttenBlue,
                                  buttonForegroundColor: whiteColor,
                                  buttonText: 'Update',
                                  borderAvalable: false,
                                  press: () {
                                    if (value.loanAmountController.text
                                            .isEmpty ||
                                        value.loanAmountController.text == '') {
                                      showToast('Enter Amount');
                                      return;
                                    }
                                    if (value.purpose == null) {
                                      showToast('Select Loan Type and Purpose');
                                      return;
                                    }
                                    // if (_selectedImage == null) {
                                    //   showToast('Select Document');
                                    //   return;
                                    // }
                                    value
                                        .upload(_selectedImage)
                                        .then((value) => _selectedImage = null);
                                    // value.getLoanRequestData();
                                    // _selectedImage = null;
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack documentContainer(documentProof) {
    return Stack(
      children: [
        Container(
          height: 130.h,
          width: 280.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: _selectedImage == null
                    ? NetworkImage(documentProof) as ImageProvider
                    : FileImage(File(_selectedImage!.path)),
              ),
              color: const Color.fromARGB(255, 223, 220, 220),
              borderRadius: BorderRadius.circular(20)),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => Imagepiker(
                onImageSelected: _updateSelectedImage,
              ),
            ),
            icon: const Icon(Icons.edit_outlined),
          ),
        )
      ],
    );
  }

  Container appBarWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: Get.back,
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
                size: 30,
              )),
          SizedBox(
            width: 50.w,
          ),
          Text(
            'Edit Loan Request',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.r),
          ),
          SizedBox(
            width: 80.w,
          ),
        ],
      ),
    );
  }

  void _updateSelectedImage(XFile? newImage) {
    setState(() {
      _selectedImage = newImage;
      // image1 = true;
    });
  }
}
