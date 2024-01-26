import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/model/bloodgroup_model.dart';
import 'package:rtd_project/backend/model/states_model.dart';
import 'package:rtd_project/backend/model/vehicle_type_model.dart';
import 'package:rtd_project/controller/authentication/regitration.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/imagepicker.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';
import 'package:rtd_project/view/terms_and_conditions/terms_and_conditions.dart';

import '../../util/toast.dart';
import '../../util/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  XFile? _selectedImage1;
  XFile? _selectedImage2;
  XFile? _profileImage;

  bool selectProfileImage = false;
  void _updateProfileImage(XFile? profileImage) {
    setState(() {
      _profileImage = profileImage;
      selectProfileImage = true;
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _updateSelectedImage(XFile? newImage) async {
    _selectedImage1 = newImage;

    // if (newImage != null) {
    //   auth.uploadImage(newImage.path);
    // }
    setState(() {});
  }

  void _updateSelectedImage1(XFile? newImage) {
    setState(() {
      _selectedImage2 = newImage;
    });
  }

  final RegisterController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: GetBuilder<RegisterController>(builder: (value) {
        return SingleChildScrollView(
          child: Column(
            children: [
              memberShipRegWidget(context),
              nochBarAboveLoginContainer(),
              SizedBox(
                height: 5.h,
              ),
              textFieldContainer(context, value),
            ],
          ),
        );
      }),
    );
  }

  Form textFieldContainer(BuildContext context, RegisterController value) {
    return Form(
      key: formKey,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: value.isSubmitted ? 400.h : 1840.h,
        // width: 390.w,
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(50),
            topStart: Radius.circular(50),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 20.h),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // profileImage(context),
            Visibility(
              visible: !value.isSubmitted,
              child: Column(
                children: <Widget>[
                  // registerStepContainer('One'),

                  imageContainer(value),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.noneEmptyValidator,
                      controller: value.nameRegController,
                      textInputType: TextInputType.text,
                      hitText: 'Name'),
                  textFieldHeight,

                  TextFormFieldWidget(
                      validator: Rtd_Validators.emailValidator,
                      controller: value.emailRegController,
                      textInputType: TextInputType.emailAddress,
                      hitText: 'email'),

                  textFieldHeight,
                  SizedBox(
                    width: 290.w,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        focusNode: FocusNode(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: Rtd_Validators.passwordValidator,
                        controller: value.passwordRegController,
                        obscureText: value.passwordVisible,
                        decoration: InputDecoration(
                            border: InputBorder.none, // Removes the underline

                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                value.passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                value.visibityPasswordChange();
                              },
                            ),
                            hintText: " Password",
                            fillColor: textFormBase,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: textFormBase),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: textFormBase),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: textFormBase),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: textFormBase),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 112, 111, 111),
                                fontWeight: FontWeight.bold)),
                        textAlign: TextAlign
                            .center, // Centers the text inside the field
                      ),
                    ),
                  ),

                  textFieldHeight,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: FocusNode(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (valuee) {
                        if (valuee!.isEmpty) {
                          return "Please Re-Enter New Password";
                        } else if (valuee.length < 5) {
                          return "Password must be atleast 5 characters long";
                        } else if (valuee != value.passwordRegController.text) {
                          return "Password must be same as above";
                        } else {
                          return null;
                        }
                      },
                      controller: value.confirmpasswordRegController,
                      obscureText: value.confirmPasswordVisible,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Removes the underline

                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              value.confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              value.visibityConfirmPasswordChange();
                            },
                          ),
                          hintText: "Confirm Password",
                          fillColor: textFormBase,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: textFormBase),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: textFormBase),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: textFormBase),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: textFormBase),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 112, 111, 111),
                              fontWeight: FontWeight.bold)),
                      textAlign:
                          TextAlign.center, // Centers the text inside the field
                    ),
                  ),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.mobileNumberValidator,
                      controller: value.indianMobNumContoller,
                      textInputType: TextInputType.phone,
                      hitText: 'Indian Mobile Number'),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.mobileNumberValidator,
                      controller: value.ksaMobileNumRegController,
                      textInputType: TextInputType.phone,
                      hitText: 'KSA Mobile Number'),

                  textFieldHeight,

                  Container(
                    width: 268.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: textFormBase),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<BloodGroup>(
                            alignment: AlignmentDirectional.center,
                            hint: Center(
                              child: Text(
                                "Select Your blood group",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.55),
                                    fontSize: 17,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            value: value.bloodGroup,
                            items: value.dropdownMenuItemsBloodgroup,
                            onChanged: (value) {
                              setState(() {
                                auth.bloodGroup = value;

                                auth.bloodgroupname =
                                    value!.groupName.toString();

                                //   newStateList.clear();
                                //  newStateList=[];
                                //_dropdownMenuItemsStates.clear();
                              });
                            }),
                      ),
                    ),
                  ),

                  textFieldHeight,

                  //////////////////////////End of Fourth Section?///////////////////////////////////////////////////////////
                  textFieldHeight,
                  dividerAndHeadingWidget(
                      heading: 'Indian Address', width: 140.w),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.noneEmptyValidator,
                      controller: value.indianAddressLine1Controller,
                      hitText: 'Address Line 1'),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.noneEmptyValidator,
                      controller: value.indianAddressLine2Controller,
                      hitText: 'Address Line 2'),
                  textFieldHeight,

                  Container(
                    width: 268.w,
                    padding: EdgeInsets.only(left: 60.w, right: 10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: textFormBase),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<AllStatesModel>(
                          alignment: AlignmentDirectional.center,
                          // isExpanded: true,
                          hint: Center(
                            child: Text(
                              "Select States",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.55),
                                  fontSize: 17,
                                  letterSpacing: .1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          value: value.selectedItem,
                          items: value.dropdownMenuItems,
                          onChanged: (value) {
                            setState(() {
                              auth.selectedItem = value;
                              auth.statesName = auth.selectedItem!.stateName;
                            });
                          }),
                    ),
                  ),

                  //////////////////////////End first Section?///////////////////////////////////////////////////////////

                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.pincodeValidator,
                      controller: value.pinController1,
                      textInputType: TextInputType.number,
                      hitText: 'pin'),

                  textFieldHeight,

                  dividerAndHeadingWidget(
                      heading: 'Residence Address in KSA', width: 80.w),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.noneEmptyValidator,
                      controller: value.resAddressLine1Controller,
                      hitText: 'Address Line 1'),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.noneEmptyValidator,
                      controller: value.resAddressLine2Controller,
                      hitText: 'Address Line 2'),

                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.pincodeValidator,
                      controller: value.pinController2,
                      textInputType: TextInputType.number,
                      hitText: 'pin'),
                  textFieldHeight,

                  Container(
                    width: 268.w,
                    padding: const EdgeInsets.only(left: 80, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: textFormBase),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<AllStatesModel>(
                          alignment: AlignmentDirectional.center,
                          // isExpanded: true,
                          hint: Center(
                            child: Text(
                              "Select States",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.55),
                                  fontSize: 17,
                                  letterSpacing: .1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          value: value.stateKsa,
                          items: value.dropdownKsaItems,
                          onChanged: (value) {
                            setState(() {
                              auth.stateKsa = value;
                              auth.statesName = auth.stateKsa!.stateName;
                            });
                          }),
                    ),
                  ),
                  textFieldHeight,
                  TextFormFieldWidget(
                      validator: Rtd_Validators.noneEmptyValidator,
                      controller: value.vehicleNumContoller,
                      hitText: 'Vehicle Number'),
                  textFieldHeight,

                  Container(
                    width: 268.w,
                    // margin: const EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.only(left: 17.w, right: 10.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: textFormBase),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<VehicleData>(
                          alignment: AlignmentDirectional.center,
                          // isExpanded: true,
                          hint: Center(
                            child: Text(
                              "Select Your Vehicle Model ",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.55),
                                  fontSize: 17,
                                  letterSpacing: .1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          value: value.vehicleType,
                          items: value.dropdownMenuItemsVehicleModel,
                          onChanged: (value) {
                            setState(() {
                              auth.vehicleType = value;

                              auth.vehicleTypeName = value!.name.toString();
                            });
                          }),
                    ),
                  ),

                  textFieldHeight,
                  const RadioButtonWidget(),
                  textFieldHeight,
                ],
              ),
            ),
            value.isSubmitted != true
                ? ButtonWidget(
                    buttonBackgroundColor: buttenBlue,
                    buttonForegroundColor: whiteColor,
                    buttonText: 'Submit',
                    borderAvalable: false,
                    press: () {
                      if (auth.isSelected.value) {
                        if (formKey.currentState!.validate()) {
                          value.onRegister(_profileImage);
                        }
                      } else {
                        showToast('Please Agree the Terms and Conditions');
                      }
                    })
                : const SizedBox(),
            // registerStepContainer('2'),
            // textFieldHeight,
            // textFieldHeight,

            Visibility(
              visible: value.isSubmitted,
              child: Column(
                children: [
                  textFieldHeight,
                  Center(
                    child: Text(
                      !value.indianDocSubmitted
                          ? 'No Documents attached'
                          : 'Document is selected',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !value.indianDocSubmitted
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                  textFieldHeight,
                  ButtonWidget(
                      press: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Imagepiker(
                            onImageSelected: _updateSelectedImage,
                            press: () {
                              Get.back();

                              value.uploadIndianDoc(_selectedImage1!.path);
                            },
                          ),
                        );
                      },
                      buttonBackgroundColor: whiteColor,
                      buttonForegroundColor: Colors.blue,
                      buttonText: 'Attach Indian Proof',
                      borderAvalable: true),
                  textFieldHeight,
                  Center(
                    child: Text(
                      !value.ksaDocSubmitted
                          ? 'No Documents attached'
                          : 'Document is selected',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: !value.ksaDocSubmitted
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                  textFieldHeight,
                  ButtonWidget(
                      press: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Imagepiker(
                              onImageSelected: _updateSelectedImage1,
                              press: () {
                                Get.back();
                                value.uploadKsaDoc(_selectedImage2!.path);
                              }),
                        );
                      },
                      buttonBackgroundColor: whiteColor,
                      buttonForegroundColor: Colors.blue,
                      buttonText: 'Attach Ksa Proof',
                      borderAvalable: true),
                  kSizedBoxH20,
                  kSizedBoxH,
                  value.indianDocSubmitted == true &&
                          value.ksaDocSubmitted == true
                      ? ButtonWidget(
                          press: () {
                            value.registerSuccess(2);
                          },
                          buttonBackgroundColor: Colors.blue,
                          buttonForegroundColor: Colors.white,
                          buttonText: 'Continue',
                          borderAvalable: true)
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  imageContainer(RegisterController value) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            // border: Border.all(width: .3),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: selectProfileImage == false
                  ? const AssetImage('assets/images/defaultpic.webp')
                      as ImageProvider
                  : FileImage(File(_profileImage!.path)),
            ),
          ),
        ),
        Positioned(
            right: 5.w,
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
                    Icons.camera_alt_outlined,
                    color: whiteColor,
                    size: 15,
                  )),
            ))
      ],
    );
  }

  Row registerStepContainer(String stepCount) {
    return Row(
      children: [
        Text(
          'Registration Step $stepCount ',
          style: const TextStyle(color: ThemeProvider.blackColor),
        ),
        const SizedBox(
          width: 10,
        ),
        // Container(
        //   height: 20,
        //   width: 20,
        //   decoration: const BoxDecoration(
        //       shape: BoxShape.circle, color: ThemeProvider.blackColor),
        //   child: Center(
        //       child: Text(
        //     stepCount,
        //     style: const TextStyle(
        //         color: Colors.white, fontWeight: FontWeight.bold),
        //   )),
        // ),
      ],
    );
  }

  // Stack profileImage(BuildContext context) {
  //   return Stack(
  //     alignment: AlignmentDirectional.topCenter,
  //     children: [
  //       CircleAvatar(
  //         radius: 55.r,
  //         backgroundImage: !selectProfileImage
  //             ? const AssetImage('assets/images/defaultpic.webp')
  //                 as ImageProvider
  //             : FileImage(File(_profileImage!.path)),
  //       ),
  //       Positioned(
  //         bottom: 0,
  //         right: 90.w,
  //         child: CircleAvatar(
  //           backgroundColor: ThemeProvider.blackColor,
  //           child: IconButton(
  //             onPressed: () => showModalBottomSheet(
  //               context: context,
  //               builder: (context) =>
  //                   Imagepiker(onImageSelected: _updateProfileImage),
  //             ),
  //             icon: const Icon(
  //               CupertinoIcons.camera,
  //               color: ThemeProvider.whiteColor,
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Row dividerAndHeadingWidget({heading, width}) {
    return Row(
      children: [
        Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Text('______________'),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5),
          child: Container(
            color: Colors.grey,
            height: 0.7.h,
            width: width,
          ),
        )
      ],
    );
  }

  Container nochBarAboveLoginContainer() {
    return Container(
      height: 5.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20)),
    );
  }

  Center memberShipRegWidget(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 150.h, bottom: 70.h),
        child: Text(
          'MemberShip\nRegistration',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  imagePickerWidget(context) {
    Container(
      height: 320.h,
      width: 390.w,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(50),
          topStart: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          const Text(
            "Upload your ID Proof",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                // onTap: () async {
                //   final imagefile = await pickImage(ImageSource.gallery);
                //   if (imagefile != null) {}
                // },
                child: Container(
                  width: 116,
                  height: 121,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: const Color(0xfff3f3f3)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/gallary.png'),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text("Choose from Gallery",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                // onTap: () async {
                //   final image =
                //       await imagePickerService.pickImage(ImageSource.camera);
                //   if (image != null) {}
                // },
                child: Container(
                  width: 116,
                  height: 121,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: const Color(0xfff3f3f3)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/camara.png'),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text("Capture from Camera",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          /* const Text("No file Selected",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),*/
          SizedBox(
            height: 20.h,
          ),
          ButtonWidget(
              press: () {
                Navigator.pop(context);
              },
              buttonBackgroundColor: buttenBlue,
              buttonForegroundColor: whiteColor,
              buttonText: 'Upload',
              borderAvalable: true)
        ],
      ),
    );
  }
}

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({
    super.key,
    Key? key1,
  });

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  final RegisterController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Radio<String>(
            toggleable: true,
            value: 'accepted',
            groupValue: auth.isSelected.value ? 'accepted' : '',
            onChanged: (String? newValue) {
              auth.toggleSelection();
            },
          ),
        ),
        SizedBox(width: 2.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'I have read and agreed to the',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              // Adjust the text styling as needed
            ),
            InkWell(
              onTap: () {
                Get.to(
                  const TermsAndConditions(),
                );
              },
              child: const Text(
                'Terms and Conditions.',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: buttenBlue),
                // Adjust the text styling as needed
              ),
            ),
          ],
        ),
      ],
    );
  }
}
