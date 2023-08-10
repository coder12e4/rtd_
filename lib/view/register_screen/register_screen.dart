import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

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
            height: 900.h,
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
                    controller: nameregController, hitText: 'Name'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController, hitText: 'DOB'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController, hitText: 'Blood Group'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController,
                    hitText: 'Indian Mobile Number'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController,
                    hitText: 'KSA Mobile Number'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController,
                    hitText: 'Whatsapp Number'),
                textFieldHeight,
   //////////////////////////End first Section?///////////////////////////////////////////////////////////
                dividerAndHeadingWidget(heading: 'Residence Address in KSA'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController, hitText: 'Name'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController, hitText: 'DOB'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController, hitText: 'Blood Group'),
                textFieldHeight,
                TextFormFieldWidget(
                    controller: nameregController,
                    hitText: 'Indian Mobile Number'),
                textFieldHeight,
                const Text('No Documents attached')
              ],
            ));
  }

  Row dividerAndHeadingWidget({heading}) {
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
            height: 0.2.h,
            width: 116.w,
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

final TextEditingController nameregController = TextEditingController();
