import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/model/bloodgroup_model.dart';
import 'package:rtd_project/backend/model/states_model.dart';
import 'package:rtd_project/controller/authentication/regitration.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/dropdown_widget.dart';
import 'package:rtd_project/core/common_widget/imagepicker.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/view/home_screen/home_page.dart';

import '../../util/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  XFile? _selectedImage;
  XFile? _selectedImage1;
  bool image1 = false;
  bool image2 = false;

  void _updateSelectedImage(XFile? newImage) {
    setState(() {
      _selectedImage = newImage;
      image1 = true;
    });
  }

  void _updateSelectedImage1(XFile? newImage) {
    setState(() {
      _selectedImage1 = newImage;
      image2 = true;
    });
  }

  final RegisterController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
          child: GetBuilder<RegisterController>(builder: (value) {
        return Column(children: [
          memberShipRegWidget(context),
          nochBarAboveLoginContainer(),
          SizedBox(
            height: 5.h,
          ),
          textFieldContainer(context, value),
        ]);
      })),
    );
  }

  Form textFieldContainer(BuildContext context, RegisterController value) {
    final RegisterController imagePickerService = Get.find();

    List<String> allstates = [];

    List<String> allBloodGroup = [];
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
          height: 2200.h,
          width: 390.w,
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(50),
              topStart: Radius.circular(50),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(45),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              TextFormFieldWidget(
                  validator: Rtd_Validators.noneEmptyValidator,
                  controller: value.nameRegController,
                  hitText: 'Name'),
              textFieldHeight,

              TextFormFieldWidget(
                  validator: Rtd_Validators.emailValidator,

                  controller: value.emailRegController, hitText: 'email'),

              textFieldHeight,
              TextFormFieldWidget(
                validator: Rtd_Validators.passwordValidator,
                  controller: value.passwordRegController, hitText: 'password'),

              textFieldHeight,
              TextFormFieldWidget(
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
                  hitText: 'confirm password'),


              textFieldHeight,
              TextFormFieldWidget(
                validator: Rtd_Validators.mobileNumberValidator,
                  controller: value.mobileNumRegController,
                  hitText: 'Indian Mobile Number'),
              textFieldHeight,
              TextFormFieldWidget(
                  validator: Rtd_Validators.mobileNumberValidator,
                  controller: value.ksaMobileNumRegController,
                  hitText: 'Mobile Number'),

              textFieldHeight,

              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: textFormBase
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<BloodGroup>(
                      isExpanded: true,
                      hint: const Text(
                        "Select Your blood group",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: .1,
                            fontWeight: FontWeight.w500),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      value: value.bloodGroup,
                      items: value.dropdownMenuItemsBloodgroup,
                      onChanged: (value) {
                        setState(() {
                          auth.bloodGroup = value;

                          auth.bloodgroupname = value!.groupName.toString();

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
              dividerAndHeadingWidget(heading: 'Indian Address', width: 140.w),
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
                margin: EdgeInsets.only(left: 5,right: 5),
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: textFormBase
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<AllStatesModel>(
                      isExpanded: true,
                      hint: const Text(
                        "Select States",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: .1,
                            fontWeight: FontWeight.w500),
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




              /* TextFormFieldWidget(
                  controller: value.watsappNumRegController,
                  hitText: 'Whatsapp Number'),
              textFieldHeight,*/
              //////////////////////////End first Section?///////////////////////////////////////////////////////////



              textFieldHeight,
              TextFormFieldWidget(
                  validator: Rtd_Validators.pincodeValidator,
                  controller: value.pinController1, hitText: 'pin'),

              textFieldHeight,
              Center(
                child: Text(
                  !image1 ? 'No Documents attached' : 'Document is selected',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !image1 ? Colors.red : Colors.green),
                ),
              ),
              textFieldHeight,
              ButtonWidget(
                  press: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Imagepiker(
                        onImageSelected: _updateSelectedImage,
                      ),
                    );
                  },
                  buttonBackgroundColor: whiteColor,
                  buttonForegroundColor: Colors.blue,
                  buttonText: 'Attach Address Proof',
                  borderAvalable: true),
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
                  controller: value.pinController2, hitText: 'pin'),
              textFieldHeight,

              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: textFormBase
                ),
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
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      value: value.stateKsa,
                      items: value.dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          auth.stateKsa = value;
                          auth.statesName = auth.stateKsa!.stateName;
                        });
                      }),
                ),

              ),

              textFieldHeight,
              Center(
                child: Text(
                  !image2 ? 'No Documents attached' : 'Document is selected',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !image2 ? Colors.red : Colors.green),
                ),
              ),
              textFieldHeight,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
                child: ButtonWidget(
                    press: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Imagepiker(
                          onImageSelected: _updateSelectedImage1,
                        ),
                      );
                    },
                    buttonBackgroundColor: whiteColor,
                    buttonForegroundColor: Colors.blue,
                    buttonText: 'Attach Address Proof',
                    borderAvalable: false),
              ),

              //////////////////////////End Of Second Section?///////////////////////////////////////////////////////////
          /*    textFieldHeight,
              dividerAndHeadingWidget(
                  heading: ' Emergency Contact 1 (KSA)', width: 70.w),
              textFieldHeight,
              TextFormFieldWidget(
                  validator: Rtd_Validators.noneEmptyValidator,
                  controller: value.emName1Controller, hitText: 'Name'),
              textFieldHeight,
              const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
              textFieldHeight,
              TextFormFieldWidget(
                  validator: Rtd_Validators.mobileNumberValidator,
                  controller: value.emMobileNum1Controller,
                  hitText: 'Mobile Number'),
          */    //////////////////////////End of third Section?///////////////////////////////////////////////////////////
          /*    textFieldHeight,
              dividerAndHeadingWidget(
                  heading: ' Emergency Contact 2 (KSA)', width: 60.w),
              textFieldHeight,
              TextFormFieldWidget(
                  validator: Rtd_Validators.noneEmptyValidator,
                  controller: value.emIndiaName2Controller, hitText: 'Name'),
              textFieldHeight,
           *//*   const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
           *//*   textFieldHeight,
              TextFormFieldWidget(
                  validator: Rtd_Validators.mobileNumberValidator,
                  controller: value.emMObilenum2Controller,
                  hitText: 'Mobile Number'),

*/

/*
              textFieldHeight,
*/
              /////////////////////End of Fiveth Section////////////////////
              /*      dividerAndHeadingWidget(
                  heading: 'Emergency Contact 1: (india)', width: 60.w),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.emIndiaName1Controller, hitText: 'Name'),
              textFieldHeight,
              const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.emIndiaMobile1Controller,
                  hitText: 'Mobile Number'),
              /////////////////////End of Sixth Section////////////////////
              textFieldHeight,
              dividerAndHeadingWidget(
                  heading: 'Emergency Contact 2: (india)', width: 60.w),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.emIndiaName2Controller, hitText: 'Name'),
              textFieldHeight,
              const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.emIndiaMobile2Controller,
                  hitText: 'Mobile Number'),
              textFieldHeight,
              /////////////////End Of Seventh section///////////////////
              const Divider(),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.iqamaNumController, hitText: 'Iqama Number'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.iqamaexperyDateController,
                  hitText: 'Expiry Date'),
              textFieldHeight,
              ////////////////////////End Of Eight Section//////////////////////////
              const Divider(),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.passNumController,
                  hitText: 'Passport Number'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.passExperyNumController,
                  hitText: 'Expiry Date'),
              textFieldHeight,
              ////////////////////////////End of Nine Section//////////////////
              const Divider(),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.maritalStatusController,
                  hitText: 'Martial Status'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.numOfChildrenController,
                  hitText: 'Number of Children'),
              textFieldHeight,
              ////////////////////////End of Tenth Section/////////////////////
              const Divider(),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.nomineController, hitText: 'Nominee'),
              textFieldHeight,
              const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
              textFieldHeight,
              //////////////////////////End of 11T Section////////////////////////////
              const Divider(),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.sponserNameController,
                  hitText: 'Sponsor Name'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.locationController, hitText: 'Location'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.estNmaeController,
                  hitText: 'Establishment Name'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.teleNumController,
                  hitText: 'Telephone Number'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.lastMobileNumController,
                  hitText: 'Mobile Number'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.sprMobileNumController,
                  hitText: 'Sponsor Related Mobile Number'),
              textFieldHeight,
              ///////////////////////End of 12TH Section//////////////////
              const Divider(),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.resVehichleNumController,
                  hitText: 'Responsible Vehicle Number'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.vehMoedelController, hitText: 'Model'),
              textFieldHeight,
              TextFormFieldWidget(
                  controller: value.vehTypeController, hitText: 'Type'),
        */

            //  textFieldHeight,
              /*TextFormFieldWidget(
                  validator: Rtd_Validators.noneEmptyValidator,
                  controller: value.vehCompanyController, hitText: 'Company'),
              textFieldHeight,*/
              textFieldHeight,
              const RadioButtonWidget(),
              textFieldHeight,
              ButtonWidget(
                  buttonBackgroundColor: buttenBlue,
                  buttonForegroundColor: whiteColor,
                  buttonText: 'Submit',
                  borderAvalable: false,
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      value.onRegister(_selectedImage!, _selectedImage1!);
                      // Form is valid, perform desired action
                    }
                    log("first image ${_selectedImage!.path.toString()}");
                    log("Second image ${_selectedImage1!.path.toString()}");

                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => const NavigationBarpage(),
                    // ));
                  }),
              textFieldHeight,
              textFieldHeight,
              textFieldHeight,
            ],
          )),
    );
  }

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
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected; // Toggle the selection state
        });
      },
      child: Row(
        children: [
          Radio<String>(
            // The actual Radio widget
            value: 'accepted',
            groupValue: _isSelected
                ? 'accepted'
                : '', // Use groupValue based on _isSelected
            onChanged: (String? newValue) {
              setState(() {
                _isSelected = !_isSelected; // Toggle the selection state
              });
            },
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
