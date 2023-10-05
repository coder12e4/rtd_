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

  bool selectProfileImage = false;
  // void _updateProfileImage(XFile? profileImage) {
  //   setState(() {
  //     _profileImage = profileImage;
  //     selectProfileImage = true;
  //   });
  // }

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
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
          height: value.isSubmitted ? 400.h : 1650.h,
          width: 390.w,
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(50),
              topStart: Radius.circular(50),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(45).r,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // profileImage(context),
              Visibility(
                visible: !value.isSubmitted,
                child: Column(
                  children: <Widget>[
                    registerStepContainer('1'),

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
                                borderSide:
                                    const BorderSide(color: textFormBase),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: textFormBase),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: textFormBase),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: textFormBase),
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
                          } else if (valuee !=
                              value.passwordRegController.text) {
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
                        textAlign: TextAlign
                            .center, // Centers the text inside the field
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
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: textFormBase),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<BloodGroup>(
                            isExpanded: true,
                            alignment: AlignmentDirectional.centerEnd,
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
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: textFormBase),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<AllStatesModel>(
                            isExpanded: true,
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
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
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
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: textFormBase),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<AllStatesModel>(
                            isExpanded: true,
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
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
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
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: textFormBase),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<VehicleData>(
                            isExpanded: true,
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
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            value: value.vehicleType,
                            items: value.dropdownMenuItemsVehicleModel,
                            onChanged: (value) {
                              setState(() {
                                auth.vehicleType = value;

                                auth.vehicleTypeName = value!.name.toString();

                                //   newStateList.clear();
                                //  newStateList=[];
                                //_dropdownMenuItemsStates.clear();
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
                          if (_formKey.currentState!.validate()) {
                            value.onRegister();
                          }
                        } else {
                          showToast('Please Agree the Terms and Conditions');
                        }
                      })
                  : registerStepContainer('2'),
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
                        !value.ksaDocSubmitted!
                            ? 'No Documents attached'
                            : 'Document is selected',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !value.ksaDocSubmitted!
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
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Row registerStepContainer(String stepCount) {
    return Row(
      children: [
        const Text(
          'Registration Step',
          style: TextStyle(color: ThemeProvider.blackColor),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ThemeProvider.blackColor),
          child: Center(
              child: Text(
            stepCount,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
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
    Key? key,
  });

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  final RegisterController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        auth.toggleSelection();
      },
      child: Row(
        children: [
          Obx(
            () => Radio<String>(
              value: 'accepted',
              groupValue: auth.isSelected.value ? 'accepted' : '',
              onChanged: (String? newValue) {
                auth.toggleSelection();
              },
            ),
          ),
          SizedBox(width: 2.w),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I have read and agreed to the',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // Adjust the text styling as needed
              ),
              Text(
                'Terms and Conditions.',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: buttenBlue),
                // Adjust the text styling as needed
              ),
            ],
          ),
        ],
      ),
    );
  }
}
