import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/util/toast.dart';

import '../../../backend/model/bloodgroup_model.dart';
import '../../../backend/model/profile_model.dart';
import '../../../backend/model/states_model.dart';
import '../../../backend/model/vehicle_type_model.dart';
import '../../../controller/profile/profile_edit_controller.dart';
import '../../../core/common_widget/imagepicker.dart';
import '../../../util/validators.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

Data? userData;
bool selectProfileImage = false;
XFile? _profileImage;
XFile? _docProf1;
XFile? _docProf2;

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
                value.loading == true
                    ? Container(
                        height: 600.h,
                        // width: 100,
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(40),
                            topStart: Radius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 6,
                          ),
                        ),
                      )
                    : Container(
                        height: 1550.h,
                        width: 390.w,
                        decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(50),
                              topEnd: Radius.circular(50),
                            )),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              imageContainer(value),
                              kSizedBoxH,
                              // nameText(value),
                              // kSizedBoxH,
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.nameController,
                                  hinttext: value.userData!.data.name,
                                  labelText: "Name"),

                              kSizedBoxH,

                              ProfileEditScreenTextField(
                                  validator:
                                      Rtd_Validators.mobileNumberValidator,
                                  controller: value.indianMobNumContoller,
                                  hinttext:
                                      value.userData!.data.indiaMobileNumber,
                                  labelText: "India"),
                              kSizedBoxH20,

                              ProfileEditScreenTextField(
                                  validator:
                                      Rtd_Validators.mobileNumberValidator,
                                  controller: value.saudiMobNumContoller,
                                  hinttext:
                                      value.userData!.data.ksaMobileNumber,
                                  labelText: "KSA"),
                              kSizedBoxH,

                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.mailContoller,
                                  hinttext: 'example@gmail.com',
                                  labelText: "Mail Address"),
                              kSizedBoxH,
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.vehicleNumberContoller,
                                  hinttext: 'Eg: KL-04-AB-2214',
                                  labelText: "Vehicle Number"),
                              kSizedBoxH,

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 45, right: 45),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<VehicleData>(
                                      isExpanded: true,
                                      hint: const Text(
                                        "Select Your Vehicle Model ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            letterSpacing: .1,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      value: value.vehicleType,
                                      items:
                                          value.dropdownMenuItemsVehicleModel,
                                      onChanged: (newValue) {
                                        setState(() {
                                          value.vehicleType = newValue;

                                          value.vehicleTypeName =
                                              newValue!.name.toString();

                                          //   newStateList.clear();
                                          //  newStateList=[];
                                          //_dropdownMenuItemsStates.clear();
                                        });
                                      }),
                                ),
                              ),
                              dividerWidget(),
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
                                  hinttext: value.userData!.data.indiaPin,
                                  labelText: "Address 1"),
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.noneEmptyValidator,
                                  controller: value.indianAddressContoller2,
                                  hinttext: value.userData!.data.indiaPin,
                                  labelText: "Address 2"),
                              ProfileEditScreenTextField(
                                  validator: Rtd_Validators.pincodeValidator,
                                  controller: value.indiaAddPinContoller,
                                  hinttext: value.userData!.data.indiaPin,
                                  labelText: "Pin"),
                              kSizedBoxH20,
                              documentContainer(
                                  value.userData!.data.documentProofIndia,
                                  _docProf1,
                                  true),
                              dividerWidget(),
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
                                    value: value.selectedKsaItem,
                                    items: value.dropdownKsaItems,
                                    onChanged: (valuee) {
                                      setState(() {
                                        value.selectedKsaItem = valuee;
                                        value.statesName =
                                            value.selectedKsaItem!.stateName;
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
                              kSizedBoxH20,
                              documentContainer(
                                  value.userData!.data.documentProofKsa,
                                  _docProf2,
                                  false),

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
                                        if (value.vehicleTypeName == null) {
                                          showToast('Select Vehicle Model');
                                          return;
                                        }
                                        if (value.bloodGroupName == null) {
                                          showToast('Select blood group');
                                          return;
                                        }
                                        if (value.selectedKsaItem == null ||
                                            value.selectedItem == null) {
                                          showToast('Select States');
                                          return;
                                        }
                                        value
                                            .upload(_profileImage, _docProf1,
                                                _docProf2)
                                            .then((value) {
                                          _profileImage == null;
                                          _docProf1 = null;
                                          _docProf2 = null;
                                        });
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

  Align nameText(EditProfileController value) {
    return Align(
      child: Text(
        value.userData!.data.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Stack documentContainer(documentProof, XFile? image, bool select) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 130.h,
          width: 280.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: image == null
                    ? NetworkImage(documentProof) as ImageProvider
                    : FileImage(File(image.path)),
              ),
              color: const Color.fromARGB(255, 223, 220, 220),
              borderRadius: BorderRadius.circular(20)),
        ),
        Positioned(
          top: 0,
          right: 55.w,
          child: IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => Imagepiker(
                onImageSelected: select == true
                    ? _updateSelectedImage1
                    : _updateSelectedImage2,
                press: () => Get.back(),
              ),
            ),
            icon: const Icon(Icons.edit_outlined),
          ),
        )
      ],
    );
  }

  imageContainer(EditProfileController value) {
    return Padding(
      padding: const EdgeInsets.only(top: 20).r,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
              border: Border.all(width: .3),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: selectProfileImage == false
                    ? NetworkImage(value.userData!.data.profileImage)
                        as ImageProvider
                    : FileImage(File(_profileImage!.path)),
              ),
            ),
          ),
          Positioned(
              right: 145.w,
              bottom: 10.h,
              // top: 80.h,
              child: CircleAvatar(
                maxRadius: 15.r,
                backgroundColor: ThemeProvider.blackColor,
                child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Imagepiker(
                            onImageSelected: _updateProfileImage,
                            press: () => Get.back()),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: whiteColor,
                      size: 15,
                    )),
              ))
        ],
      ),
    );
  }

  void _updateProfileImage(XFile? profileImage) {
    setState(() {
      _profileImage = profileImage;
      selectProfileImage = true;
    });
  }

  void _updateSelectedImage1(XFile? newImage) {
    setState(() {
      _docProf1 = newImage;
      // image1 = true;
    });
  }

  void _updateSelectedImage2(XFile? newImage) {
    setState(() {
      _docProf2 = newImage;
      // image1 = true;
    });
  }

  Container appbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: Get.back,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 30,
                  )),
              SizedBox(
                width: 95.w,
              ),
              Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),

              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.notifications_none,
              //       color: whiteColor,
              //       size: 35,
              //     ))
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
