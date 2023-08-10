import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/dropdown_widget.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/view/login_screen/login_page.dart';

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
          textFieldContainer(),
        ]),
      ),
    );
  }

  Container textFieldContainer() {
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
            TextFormFieldWidget(controller: nameregController, hitText: 'Name'),
            textFieldHeight,
            TextFormFieldWidget(controller: nameregController, hitText: 'DOB'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Blood Group'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Indian Mobile Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'KSA Mobile Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Whatsapp Number'),
            textFieldHeight,
            //////////////////////////End first Section?///////////////////////////////////////////////////////////
            dividerAndHeadingWidget(
                heading: 'Residence Address in KSA', width: 116.w),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Address Line 1'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Address Line 2'),
            textFieldHeight,
            const DropedownWidget(hintText: 'State'),

            textFieldHeight,
            const DropedownWidget(hintText: 'Pin'),

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
                  press: () {},
                  buttonBackgroundColor: whiteColor,
                  buttonForegroundColor: Colors.blue,
                  buttonText: 'Attach Address Proof',
                  borderAvalable: false),
            ),
            //////////////////////////End Of Second Section?///////////////////////////////////////////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(
                heading: ' Emergency Contact 1 (KSA)', width: 105.0.w),
            textFieldHeight,
            TextFormFieldWidget(controller: nameregController, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Mobile Number'),
            //////////////////////////End of third Section?///////////////////////////////////////////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(
                heading: ' Emergency Contact 2 (KSA)', width: 104.0.w),
            textFieldHeight,
            TextFormFieldWidget(controller: nameregController, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Mobile Number'),
            //////////////////////////End of Fourth Section?///////////////////////////////////////////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(heading: 'Indian Address', width: 180.w),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Address Line 1'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Address Line 2'),
            textFieldHeight,
            const DropedownWidget(hintText: 'State'),

            textFieldHeight,
            const DropedownWidget(hintText: 'Pin'),

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
                  press: () {},
                  buttonBackgroundColor: whiteColor,
                  buttonForegroundColor: Colors.blue,
                  buttonText: 'Attach Address Proof',
                  borderAvalable: false),
            ),
            textFieldHeight,
            /////////////////////End of Fiveth Section////////////////////
            dividerAndHeadingWidget(
                heading: 'Emergency Contact 1: (india)', width: 100.w),
            textFieldHeight,
            TextFormFieldWidget(controller: nameregController, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Mobile Number'),
            /////////////////////End of Sixth Section////////////////////
            textFieldHeight,
            dividerAndHeadingWidget(
                heading: 'Emergency Contact 2: (india)', width: 100.w),
            textFieldHeight,
            TextFormFieldWidget(controller: nameregController, hitText: 'Name'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Mobile Number'),
            textFieldHeight,
            /////////////////End Of Seventh section///////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Iqama Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Expiry Date'),
            textFieldHeight,
            ////////////////////////End Of Eight Section//////////////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Passport Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Expiry Date'),
            textFieldHeight,
            ////////////////////////////End of Nine Section//////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Martial Status'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Number of Children'),
            textFieldHeight,
            ////////////////////////End of Tenth Section/////////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Nominee'),
            textFieldHeight,
            const DropedownWidget(hintText: 'Relationship'),
            textFieldHeight,
            //////////////////////////End of 11T Section////////////////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Sponsor Name'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Location'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Establishment Name'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Telephone Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Mobile Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController,
                hitText: 'Sponsor Related Mobile Number'),
            textFieldHeight,
            ///////////////////////End of 12TH Section//////////////////
            const Divider(),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController,
                hitText: 'Responsible Vehicle Number'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Model'),
            textFieldHeight,
            TextFormFieldWidget(controller: nameregController, hitText: 'Type'),
            textFieldHeight,
            TextFormFieldWidget(
                controller: nameregController, hitText: 'Company'),
            textFieldHeight,
            const RadioButtonWidget(),
            textFieldHeight,
            ButtonWidget(
                buttonBackgroundColor: buttenBlue,
                buttonForegroundColor: whiteColor,
                buttonText: 'Submit',
                borderAvalable: false,
                press: () {}),
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
  const RadioButtonWidget({Key? key});

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
          const SizedBox(width: 5),
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
                'Terms and Conditions',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: buttenBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final TextEditingController nameregController = TextEditingController();
