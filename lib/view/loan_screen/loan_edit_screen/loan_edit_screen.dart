import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/model/loan/loan_purpose.dart';
import 'package:rtd_project/backend/model/loan/loan_type_model.dart';
import 'package:rtd_project/controller/loan/loan_edit_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';

import '../../../core/common_widget/commen_botten.dart';
import '../../../core/common_widget/imagepicker.dart';
import '../../../helper/router.dart';

class LoanEditScreen extends StatefulWidget {
  const LoanEditScreen({super.key});

  @override
  State<LoanEditScreen> createState() => _LoanEditScreenState();
}

// XFile? _selectedImage;

class _LoanEditScreenState extends State<LoanEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
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
                                              color:
                                                  Colors.black.withOpacity(.55),
                                              fontSize: 17,
                                              letterSpacing: .1,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: value.loan,

                                      // Set the initial value (hint text)
                                      onChanged: (newValue) {
                                        value.getLoanPurpose(newValue!.id, 2);
                                        setState(() {});
                                        value.surties.clear();
                                        value.addedSurties.clear();
                                        value.isSelected.clear();
                                        value.noOfSurties.clear();
                                        value.loanSuretyCount = 0;
                                        value.loan = newValue;
                                      },
                                      items: value.dropdownMenuLoanType,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              kSizedBoxH,
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
                                    child: DropdownButton<PurposeData>(
                                      isExpanded: true,
                                      underline: Container(),
                                      hint: Center(
                                        child: Text(
                                          "Select Purpose",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.55),
                                              fontSize: 17,
                                              letterSpacing: .1,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      value: Get.find<LoanEditController>()
                                          .purposeData,
                                      onChanged: (newValue) {
                                        setState(() {});
                                        value.purposeData = newValue;
                                        value.purpose = newValue!.purpose;
                                        value.loanSuretyCount = 0;
                                        value.loanAmount = newValue.maxLimit;
                                        value.updateLoanSuretyCount(newValue);
                                        log('loan amount ${newValue.maxLimit}');

                                        log(value.purposeData!.id.toString());
                                      },
                                      items: value.dropdownMenuPurpose,
                                    ),
                                  ),
                                ),
                              ),
                              kSizedBoxH,
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Sureties')),
                              kSizedBoxH,
                              SizedBox(
                                height: 80.h,
                                child: value.surties.isNotEmpty
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: value.surties.length,
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
                                            : Container(
                                                height: 80.h,
                                                width: 80.h,
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        CircleAvatar(
                                                          minRadius: 35.r,
                                                          backgroundColor:
                                                              textFormBase,
                                                          backgroundImage:
                                                              NetworkImage(value
                                                                  .surties[
                                                                      index]!
                                                                  .profileImage),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () => value
                                                                .deleteSurety(
                                                                    index,
                                                                    value.surties[
                                                                        index]),
                                                            child: CircleAvatar(
                                                              minRadius: 15.r,
                                                              backgroundColor:
                                                                  ThemeProvider
                                                                      .blackColor,
                                                              child: const Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        "${value.surties[index]!.name}")
                                                  ],
                                                ),
                                              ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: 15,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                        "Sureties not added for this loan",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )),
                              ),
                              kSizedBoxH,
                              Container(
                                height: 50.h,
                                width: 290.w,
                                decoration: BoxDecoration(
                                  color: textFormBase,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    value.loanAmount ?? 'Loan Amount',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              kSizedBoxH,
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Documents')),
                              kSizedBoxH,
                              documentsRow(value),
                              SizedBox(
                                height: 20.h,
                              ),
                              ButtonWidget(
                                buttonBackgroundColor: buttenBlue,
                                buttonForegroundColor: whiteColor,
                                buttonText: 'Update',
                                borderAvalable: false,
                                press: () {
                                  value.upload();
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
    );
  }

  Widget documentsRow(LoanEditController value) {
    if (value.loanEditDocument!.data.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          value.loanDocument1 == null
              ? selectionContainer(
                  onImageSelected: value.updateSelectedImage1,
                  onPress: () {
                    // Get.back();
                    log('selected document : ${value.loanDocument1!.path}');
                    value
                        .uploadLoanDocument(
                          value.loanDocument1!,
                        )
                        .then((valuee) => value.loanDocument1 = null);
                  },
                )
              : documentContainer(
                  value: value,
                  selectedDocument: value.loanDocument1,
                ),
          SizedBox(
            width: 10.w,
          ),
          value.loanDocument2 == null
              ? selectionContainer(
                  onPress: () {
                    value
                        .uploadLoanDocument(
                          value.loanDocument2!,
                        )
                        .then((valuee) => value.loanDocument2 = null);
                    // Get.back();
                  },
                  onImageSelected: value.updateSelectedImage2,
                )
              : documentContainer(
                  value: value,
                  selectedDocument: value.loanDocument2,
                ),
          SizedBox(
            width: 10.w,
          ),
          value.loanDocument3 == null
              ? selectionContainer(
                  onPress: () {
                    value
                        .uploadLoanDocument(
                          value.loanDocument3!,
                        )
                        .then((valuee) => value.loanDocument3 = null);
                    // Get.back();
                  },
                  onImageSelected: value.updateSelectedImage3,
                )
              : documentContainer(
                  value: value,
                  selectedDocument: value.loanDocument3,
                ),
        ],
      );
    }
    if (value.loanEditDocument!.data.length == 1) {
      value.loanDocumentCount = 1;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          documentContainer(
            documentProof: value.loanEditDocument!.data[0].file,
            documentId: value.loanEditDocument!.data[0].id,
            value: value,
          ),
          SizedBox(
            width: 10.w,
          ),
          value.loanDocument2 == null
              ? selectionContainer(
                  onPress: () {
                    value
                        .uploadLoanDocument(
                          value.loanDocument2!,
                        )
                        .then((valuee) => value.loanDocument2 = null);
                    // Get.back();
                  },
                  onImageSelected: value.updateSelectedImage2,
                )
              : documentContainer(
                  value: value,
                  selectedDocument: value.loanDocument2,
                ),
          SizedBox(
            width: 10.w,
          ),
          value.loanDocument3 == null
              ? selectionContainer(
                  onPress: () {
                    value
                        .uploadLoanDocument(
                          value.loanDocument3!,
                        )
                        .then((valuee) => value.loanDocument3 = null);
                    // Get.back();
                  },
                  onImageSelected: value.updateSelectedImage3,
                )
              : documentContainer(
                  value: value,
                  selectedDocument: value.loanDocument3,
                ),
        ],
      );
    }
    if (value.loanEditDocument!.data.length == 2) {
      value.loanDocumentCount = 2;
      return Row(
        children: [
          documentContainer(
            documentProof: value.loanEditDocument!.data[0].file,
            documentId: value.loanEditDocument!.data[0].id,
            value: value,
          ),
          SizedBox(
            width: 10.w,
          ),
          documentContainer(
            documentProof: value.loanEditDocument!.data[1].file,
            documentId: value.loanEditDocument!.data[1].id,
            value: value,
          ),
          SizedBox(
            width: 10.w,
          ),
          value.loanDocument3 == null
              ? selectionContainer(
                  onPress: () {
                    value
                        .uploadLoanDocument(
                          value.loanDocument3!,
                        )
                        .then((valuee) => value.loanDocument3 = null);

                    // Get.back();
                  },
                  onImageSelected: value.updateSelectedImage3,
                )
              : documentContainer(
                  value: value,
                  selectedDocument: value.loanDocument3,
                )
        ],
      );
    }
    value.loanDocumentCount = 3;
    return Row(
      children: [
        documentContainer(
          documentProof: value.loanEditDocument!.data[0].file,
          documentId: value.loanEditDocument!.data[0].id,
          value: value,
        ),
        SizedBox(
          width: 10.w,
        ),
        documentContainer(
          documentProof: value.loanEditDocument!.data[1].file,
          documentId: value.loanEditDocument!.data[1].id,
          value: value,
        ),
        SizedBox(
          width: 10.w,
        ),
        documentContainer(
          documentProof: value.loanEditDocument!.data[2].file,
          documentId: value.loanEditDocument!.data[2].id,
          value: value,
        ),
      ],
    );
  }

  Stack documentContainer(
      {String? documentProof,
      XFile? selectedDocument,
      int? documentId,
      required LoanEditController value}) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          height: 100.h,
          width: 90.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: selectedDocument == null
                    ? NetworkImage(documentProof ?? '') as ImageProvider
                    : FileImage(File(selectedDocument.path)),
              ),
              color: const Color.fromARGB(255, 223, 220, 220),
              borderRadius: BorderRadius.circular(20)),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: InkWell(
            onTap: () {
              value.removeLoanDocument(documentId, selectedDocument);
            },
            child: const Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 25,
            ),
          ),
        )
      ],
    );
  }

  Container appBarWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
              size: 30,
            ),
          ),
          Text(
            'Edit Loan Request',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.r),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
      ),
    );
  }

  GestureDetector selectionContainer(
      {required Function() onPress,
      required Function(XFile?) onImageSelected}) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => Imagepiker(
          press: onPress,
          onImageSelected: onImageSelected,
        ),
      ),
      child: Container(
        height: 100.h,
        width: 90.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 223, 220, 220),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
