import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/dropdown_widget.dart';
import 'package:rtd_project/core/common_widget/imagepicker.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/view/home_screen/home_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Column(children: [
          memberShipRegWidget(context),
          nochBarAboveLoginContainer(),
          SizedBox(
            height: 5.h,
          ),
          textFieldContainer(context),
        ]),
      ),
    );
  }

  Container textFieldContainer(BuildContext context) {
    List<String> _bloodGroups = [
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
    ];

    return Container(
        height: 3690.h,
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
            TextFormFieldWidget(controller: nameRegController, hitText: 'Name'),
            textFieldHeight,
            TextFormFieldWidget(controller: nameRegController, hitText: 'DOB'),
            textFieldHeight,
            DropedownWidget(
                hintText: 'Blood Group', dropDownlist: _bloodGroups),
            textFieldHeight,
            TextFormFieldWidget(
                controller: mobileNumRegController,
                hitText: 'Indian Mobile Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: ksaMobileNumRegController,
                hitText: 'KSA Mobile Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: watsappNumRegController,
                hitText: 'Whatsapp Number'),
            textFieldHeight,
            //////////////////////////End first Section?///////////////////////////////////////////////////////////
            dividerAndHeadingWidget(
                heading: 'Residence Address in KSA', width: 80.w),
            textFieldHeight,
            TextFormFieldWidget(
                controller: resAddressLine1Controller,
                hitText: 'Address Line 1'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: resAddressLine2Controller,
                hitText: 'Address Line 2'),
            textFieldHeight,
            DropedownWidget(hintText: 'State', dropDownlist: []),

            textFieldHeight,
            const DropedownWidget(hintText: 'Pin', dropDownlist: []),

            textFieldHeight,
            const Center(
              child: Text(
                'No Documents attached',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            textFieldHeight,
            ButtonWidget(
                press: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Imagepiker(),
                  );
                },
                buttonBackgroundColor: whiteColor,
                buttonForegroundColor: Colors.blue,
                buttonText: 'Attach Address Proof',
                borderAvalable: true),

            //////////////////////////End Of Second Section?///////////////////////////////////////////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(
                heading: ' Emergency Contact 1 (KSA)', width: 70.w),
            textFieldHeight,
            TextFormFieldWidget(controller: emName1Controller, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
            textFieldHeight,
            TextFormFieldWidget(
                controller: emMobileNum1Controller, hitText: 'Mobile Number'),
            //////////////////////////End of third Section?///////////////////////////////////////////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(
                heading: ' Emergency Contact 2 (KSA)', width: 60.w),
            textFieldHeight,
            TextFormFieldWidget(
                controller: emIndiaName2Controller, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
            textFieldHeight,
            TextFormFieldWidget(
                controller: emIndiaName2Controller, hitText: 'Mobile Number'),
            //////////////////////////End of Fourth Section?///////////////////////////////////////////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(heading: 'Indian Address', width: 140.w),
            textFieldHeight,
            TextFormFieldWidget(
                controller: indianAddressLine1Controller,
                hitText: 'Address Line 1'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: indianAddressLine2Controller,
                hitText: 'Address Line 2'),
            textFieldHeight,
            const DropedownWidget(hintText: 'State', dropDownlist: []),

            textFieldHeight,
            const DropedownWidget(hintText: 'Pin', dropDownlist: []),

            textFieldHeight,
            const Center(
              child: Text(
                'No Documents attached',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                      builder: (context) => Imagepiker(),
                    );
                  },
                  buttonBackgroundColor: whiteColor,
                  buttonForegroundColor: Colors.blue,
                  buttonText: 'Attach Address Proof',
                  borderAvalable: false),
            ),
            textFieldHeight,
            /////////////////////End of Fiveth Section////////////////////
            dividerAndHeadingWidget(
                heading: 'Emergency Contact 1: (india)', width: 60.w),
            textFieldHeight,
            TextFormFieldWidget(
                controller: emIndiaName1Controller, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
            textFieldHeight,
            TextFormFieldWidget(
                controller: emIndiaMobile1Controller, hitText: 'Mobile Number'),
            /////////////////////End of Sixth Section////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(
                heading: 'Emergency Contact 2: (india)', width: 60.w),
            textFieldHeight,
            TextFormFieldWidget(
                controller: emIndiaName2Controller, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
            textFieldHeight,
            TextFormFieldWidget(
                controller: emIndiaMobile2Controller, hitText: 'Mobile Number'),
            textFieldHeight,
            /////////////////End Of Seventh section///////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: iqamaNumController, hitText: 'Iqama Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: iqamaexperyDateController, hitText: 'Expiry Date'),
            textFieldHeight,
            ////////////////////////End Of Eight Section//////////////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: passNumController, hitText: 'Passport Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: passExperyNumController, hitText: 'Expiry Date'),
            textFieldHeight,
            ////////////////////////////End of Nine Section//////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: maritalStatusController, hitText: 'Martial Status'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: numOfChildrenController,
                hitText: 'Number of Children'),
            textFieldHeight,
            ////////////////////////End of Tenth Section/////////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nomineController, hitText: 'Nominee'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship', dropDownlist: []),
            textFieldHeight,
            //////////////////////////End of 11T Section////////////////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: sponserNameController, hitText: 'Sponsor Name'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: locationController, hitText: 'Location'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: estNmaeController, hitText: 'Establishment Name'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: teleNumController, hitText: 'Telephone Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: lastMobileNumController, hitText: 'Mobile Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: sprMobileNumController,
                hitText: 'Sponsor Related Mobile Number'),
            textFieldHeight,
            ///////////////////////End of 12TH Section//////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: resVehichleNumController,
                hitText: 'Responsible Vehicle Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: vehMoedelController, hitText: 'Model'),
            textFieldHeight,
            TextFormFieldWidget(controller: vehTypeController, hitText: 'Type'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: vehCompanyController, hitText: 'Company'),
            textFieldHeight,
            const RadioButtonWidget(),
            textFieldHeight,
            ButtonWidget(
                buttonBackgroundColor: buttenBlue,
                buttonForegroundColor: whiteColor,
                buttonText: 'Submit',
                borderAvalable: false,
                press: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => NavigationBarpage(),
                  ));
                }),
            textFieldHeight,
          ],
        ));
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
            ],
          ),
        ],
      ),
    );
  }
}

final TextEditingController nameRegController = TextEditingController();
final TextEditingController mobileNumRegController = TextEditingController();
final TextEditingController ksaMobileNumRegController = TextEditingController();
final TextEditingController watsappNumRegController = TextEditingController();
/////resisidants adress in ksa/////////
final TextEditingController resAddressLine1Controller = TextEditingController();
final TextEditingController resAddressLine2Controller = TextEditingController();
/////////////////////////emargency contact 1 ksa////////////////////////
final TextEditingController emName1Controller = TextEditingController();
final TextEditingController emMobileNum1Controller = TextEditingController();
/////////////////////////emargency contact 2 ksa////////////////////////
final TextEditingController emName2Controller = TextEditingController();
final TextEditingController emMObilenum2Controller = TextEditingController();
/////////////////////////indian adress////////////////////////
final TextEditingController indianAddressLine1Controller =
    TextEditingController();
final TextEditingController indianAddressLine2Controller =
    TextEditingController();
///////////////////////emarangcy contact india1//////////////////////////////////
final TextEditingController emIndiaName1Controller = TextEditingController();
final TextEditingController emIndiaMobile1Controller = TextEditingController();
///////////////////////emarangcy contact india2//////////////////////////////////
final TextEditingController emIndiaName2Controller = TextEditingController();
final TextEditingController emIndiaMobile2Controller = TextEditingController();
///////////////////////last section//////////////////////////////////
final TextEditingController iqamaNumController = TextEditingController();
final TextEditingController iqamaexperyDateController = TextEditingController();
final TextEditingController passNumController = TextEditingController();
final TextEditingController passExperyNumController = TextEditingController();
final TextEditingController maritalStatusController = TextEditingController();
final TextEditingController numOfChildrenController = TextEditingController();
final TextEditingController nomineController = TextEditingController();
final TextEditingController sponserNameController = TextEditingController();
final TextEditingController locationController = TextEditingController();
final TextEditingController estNmaeController = TextEditingController();
final TextEditingController teleNumController = TextEditingController();
final TextEditingController lastMobileNumController = TextEditingController();
final TextEditingController sprMobileNumController = TextEditingController();
final TextEditingController resVehichleNumController = TextEditingController();
final TextEditingController vehMoedelController = TextEditingController();
final TextEditingController vehTypeController = TextEditingController();
final TextEditingController vehCompanyController = TextEditingController();
