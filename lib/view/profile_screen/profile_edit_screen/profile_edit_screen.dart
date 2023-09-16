import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/toast.dart';

import '../../../backend/model/bloodgroup_model.dart';
import '../../../backend/model/profile_model.dart';
import '../../../backend/model/states_model.dart';
import '../../../controller/profile_edit_controller.dart';
import '../../../util/validators.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

Data? userData;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: GetBuilder<EditProfileController>(builder: (value) {
            return Column(
              children: [
                appbar(context),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 1300.h,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(50),
                        topEnd: Radius.circular(50),
                      )),
                  child: value.loading == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200.h,
                            ),
                            const CircularProgressIndicator(),
                          ],
                        )
                      : Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              imageContainer(value),
                              kSizedBoxH,
                              nameText(value),
                              kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,

                              ProfileEditScreenTextField(
                                  validator:
                                      Rtd_Validators.mobileNumberValidator,
                                  controller: value.indianMobNumContoller,
                                  hinttext:
                                      value.profileData!.indiaMobileNumber,
                                  labelText: "India"),
                              kSizedBoxH20,

                              ProfileEditScreenTextField(
                                  validator:
                                      Rtd_Validators.mobileNumberValidator,
                                  controller: value.saudiMobNumContoller,
                                  hinttext: value.profileData!.ksaMobileNumber,
                                  labelText: "KSA"),
                              kSizedBoxH,

                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.emailValidator,
                                  controller: value.mailContoller,
                                  hinttext: 'example@gmail.com',
                                  labelText: "Mail Address"),
                              kSizedBoxH,
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 45, right: 45),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<BloodGroup>(
                                      isExpanded: true,
                                      hint: const Text(
                                        "Select Blood group",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            letterSpacing: .1,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      value: value.bloodGroup,
                                      items: value.dropdownMenuItemsBloodgroup,
                                      onChanged: (valuee) {
                                        setState(() {
                                          value.bloodGroup = valuee;
                                          value.bloodGroupName =
                                              valuee?.groupName.toString();
                                        });
                                      }),
                                ),
                              ),

                              // kSizedBoxH,
                              dividerWidget(),
                              kSizedBoxH,
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 38.0.w),
                                child: Text(
                                  ' Indian Address Line  :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 45, right: 45),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<AllStatesModel>(
                                      isExpanded: true,
                                      hint: const Text(
                                        "Select States",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            letterSpacing: .1,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      value: value.selectedItem,
                                      items: value.dropdownMenuItems,
                                      onChanged: (valuee) {
                                        setState(() {
                                          value.selectedItem = valuee;
                                          value.statesName =
                                              value.selectedItem!.stateName;
                                        });
                                      }),
                                ),
                              ),
                              dividerWidget(),
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.indianAddressContoller1,
                                  hinttext: value.profileData!.indiaPin,
                                  labelText: "Address 1"),
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.indianAddressContoller2,
                                  hinttext: value.profileData!.indiaPin,
                                  labelText: "Address 2"),
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.pincodeValidator,
                                  controller: value.indiaAddPinContoller,
                                  hinttext: value.profileData!.indiaPin,
                                  labelText: "Pin"),
                              kSizedBoxH20,
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 38.0.w),
                                child: Text(
                                  ' KSA Address Line  :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 45, right: 45),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<AllStatesModel>(
                                    isExpanded: true,
                                    hint: const Text(
                                      "Select States",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          letterSpacing: .1,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    value: value.stateKsa,
                                    items: value.dropdownMenuItems,
                                    onChanged: (valuee) {
                                      setState(() {
                                        value.stateKsa = valuee;
                                        value.statesName =
                                            value.stateKsa!.stateName;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              dividerWidget(),

                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.ksaAddressContoller1,
                                  hinttext: value.ksaAddressContoller1.text,
                                  labelText: "Address 1"),
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.ksaAddressContoller2,
                                  hinttext: value.ksaAddressContoller2.text,
                                  labelText: "Address 2"),
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.pincodeValidator,
                                  controller: value.saudiAddPinContoller,
                                  hinttext: '677743',
                                  labelText: "Pin"),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100.0.w, vertical: 20.h),
                                child: TextButton(
                                    style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.resolveWith(
                                                (states) => const Size(60, 50)),
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => baseColor)),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (value.bloodGroupName == null) {
                                          showToast('Select blood group');
                                          return;
                                        }
                                        if (value.stateKsa == null ||
                                            value.selectedItem == null) {
                                          showToast('Select States');
                                          return;
                                        }
                                        value.updateProfileData();
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0,
                                          right: 18,
                                          top: 8,
                                          bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.save_outlined,
                                              color: whiteColor),
                                          Text(
                                            'Save Edit',
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Container documentContainer() {
    return Container(
      margin: EdgeInsets.only(left: 36.w),
      height: 130.h,
      width: 280.w,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 220, 220),
          borderRadius: BorderRadius.circular(20)),
    );
  }

  Padding detailsText(title, subtitle) {
    return Padding(
      padding: EdgeInsets.only(left: 38.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
            child: Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 97, 95, 95),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
            child: Text(
              subtitle,
              style: const TextStyle(
                  // color: Color.fromARGB(255, 97, 95, 95),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  textButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(60, 50)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => baseColor)),
            onPressed: () {},
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, color: whiteColor),
                  Text(
                    'Edit Profile',
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ],
              ),
            )),
        const SizedBox(
          width: 20,
        ),
        TextButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(60, 50)),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => baseColor)),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 18, top: 5, bottom: 5),
              child: Row(
                children: [
                  SvgPicture.asset(
                      'assets/fonts/icons/database-data-base-svgrepo-com.svg'),
                  const Text(
                    'Loan',
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Divider dividerWidget() {
    return Divider(
      color: Colors.grey.shade400,
      indent: 45.w,
      endIndent: 45.w,
    );
  }

  Column nameText(EditProfileController value) {
    return Column(
      children: [
        Text(
          value.profileData!.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Text('Not Available',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  imageContainer(EditProfileController value) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30.h),
        child: Stack(
          children: [
            SizedBox(
              // color: baseColor,
              height: 110.h,
              width: 110.w,
              child: Center(
                child: Container(
                  // margin: EdgeInsets.only(top: 30.h),
                  height: 100.h,
                  width: 100.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                          'assets/images/pexels-pixabay-220453 1.png'),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 40.w,
                bottom: 0.h,
                // top: 80.h,
                child: Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: baseColor),
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: whiteColor,
                            size: 15,
                          )),
                    )))
          ],
        ),
      ),
    );
  }

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 30,
                  )),
              SizedBox(
                width: 58.w,
              ),
              Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              SizedBox(
                width: 30.w,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none,
                    color: whiteColor,
                    size: 35,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileEditScreenTextField extends StatelessWidget {
  const ProfileEditScreenTextField(
      {super.key,
      required this.hinttext,
      required this.labelText,
      required this.controller,
      required this.validator});
  final String hinttext;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.0.w),
      child: TextFormField(
        cursorColor: baseColor,
        style: const TextStyle(color: baseColor),
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            // prefixText: '+91 9745123456',
            hintText: hinttext,
            labelText: labelText,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: baseColor)),
      ),
    );
  }
}
