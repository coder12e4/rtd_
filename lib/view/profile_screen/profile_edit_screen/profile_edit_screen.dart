import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';

List<String> bloodGroup = ['o+', 'o-', 'A+', 'B+', 'A-'];
String selectedBloodGroup = 'Select a blood group';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appbar(context),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 950.h,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(50),
                    topEnd: Radius.circular(50),
                  )),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  imageContainer(),
                  kSizedBoxH,
                  nameText(),
                  kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,

                  ProfileEditScreenTextField(
                      controller: indianMobNumContoller,
                      hinttext: '+91 9745123456',
                      labelText: "India"),
                  kSizedBoxH20,
                  // dividerWidget(),
                  // kSizedBoxH,
                  ProfileEditScreenTextField(
                      controller: saudiMobNumContoller,
                      hinttext: '+91 9745123456',
                      labelText: "Saudi Arabia "),
                  kSizedBoxH,
                  // dividerWidget(),
                  kSizedBoxH,
                  ProfileEditScreenTextField(
                      controller: mailContoller,
                      hinttext: 'example@gmail.com',
                      labelText: "Mail Address"),
                  kSizedBoxH,
                  // dividerWidget(),
                  kSizedBoxH,
                  ProfileEditScreenTextField(
                      controller: mail2Contoller,
                      hinttext: 'example@gmail.com',
                      labelText: "Mail Address"),
                  kSizedBoxH,
                  // dividerWidget(),
                  kSizedBoxH,
                  Center(
                    child: DropdownButton<String>(
                      underline: Container(),
                      value:
                          selectedBloodGroup, // Set the initial value (hint text)
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBloodGroup = newValue!;
                        });
                      },
                      items: [
                        // Add a dummy item with hint text as the first option
                        const DropdownMenuItem<String>(
                          value:
                              'Select a blood group', // This value doesn't have to match any real value
                          alignment: Alignment.center,
                          child: Text('Blood Group'),
                        ),
                        // Generate other blood group options
                        ...bloodGroup
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.center,
                            value: value,
                            child: Text(value),
                          );
                        })
                      ],
                    ),
                  ),
                  // kSizedBoxH,
                  dividerWidget(),
                  kSizedBoxH,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38.0.w),
                    child: Text(
                      ' Indian Address Line  :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                  ),
                  ProfileEditScreenTextField(
                      controller: indianAddStateContoller,
                      hinttext: 'Kerala',
                      labelText: "State"),
                  kSizedBoxH20,
                  ProfileEditScreenTextField(
                      controller: indiaAddPinContoller,
                      hinttext: 'example@gmail.com',
                      labelText: "Pin"),
                  kSizedBoxH20,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38.0.w),
                    child: Text(
                      ' Saudi Arabia Address Line  :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                  ),
                  ProfileEditScreenTextField(
                      controller: saudiAddStateContoller,
                      hinttext: 'Kerala',
                      labelText: "State"),
                  kSizedBoxH20,
                  ProfileEditScreenTextField(
                      controller: saudiAddPinContoller,
                      hinttext: 'example@gmail.com',
                      labelText: "Pin"),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 100.0.w, vertical: 20.h),
                    child: TextButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => const Size(60, 50)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => baseColor)),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 18, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.save_outlined, color: whiteColor),
                              Text(
                                'Save Edit',
                                style:
                                    TextStyle(color: whiteColor, fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
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

  Column nameText() {
    return const Column(
      children: [
        Text(
          'Shanavas Kolangattil',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text('(M.109)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  imageContainer() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30.h),
        child: Stack(
          children: [
            Container(
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
                  onPressed: () {},
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

final TextEditingController indianMobNumContoller =
    TextEditingController(text: '+91 9745123456');
final TextEditingController saudiMobNumContoller =
    TextEditingController(text: '+91 9745123456');
final TextEditingController mailContoller =
    TextEditingController(text: 'example@gmail.com');
final TextEditingController mail2Contoller =
    TextEditingController(text: 'example@gmail.com');
final TextEditingController indianAddStateContoller =
    TextEditingController(text: 'Kerala');
final TextEditingController indiaAddPinContoller =
    TextEditingController(text: '688011');
final TextEditingController saudiAddStateContoller =
    TextEditingController(text: 'Damam');
final TextEditingController saudiAddPinContoller =
    TextEditingController(text: '15263');

class ProfileEditScreenTextField extends StatelessWidget {
  const ProfileEditScreenTextField({
    super.key,
    required this.hinttext,
    required this.labelText,
    required this.controller,
  });
  final String hinttext;
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.0.w),
      child: TextFormField(
        cursorColor: baseColor,
        style: const TextStyle(color: baseColor),
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
