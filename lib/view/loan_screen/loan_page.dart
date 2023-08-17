import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/dropdown_widget.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/view/loan_screen/widgets/attach_bottem_sheet.dart';
import 'package:rtd_project/view/loan_screen/widgets/porpose.dart';

class LoanPage extends StatelessWidget {
  const LoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: baseColor,
            body: SingleChildScrollView(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    wallTextWidget(context),
                    SizedBox(
                      height: 70.h,
                    ),
                    tabBar(),
                    tabBarView(context),
                  ],
                ),
              ),
            )));
  }

  Container tabBarView(BuildContext context) {
    return Container(
      height: 500.h,
      //hallo
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(40),
          topStart: Radius.circular(40),
        ),
      ),
      child: TabBarView(children: [
        NewRequestView(context),
        RequestView(),
      ]),
    );
  }

  Column RequestView() {
    return Column(
        // physics: const NeverScrollableScrollPhysics(),

        children: []);
  }

  SizedBox optionButton(
      {bool? borderAvalable,
      Color? buttonForegroundColor,
      Color? buttonbackgroundColor,
      Function()? press,
      String? buttonText}) {
    return SizedBox(
        height: 40.h,
        // width: 260.w,
        child: ElevatedButton(
            style: ButtonStyle(
                side: borderAvalable == false
                    ? const MaterialStatePropertyAll(
                        BorderSide(color: Colors.black))
                    : null,
                foregroundColor: MaterialStatePropertyAll(borderAvalable == true
                    ? buttonForegroundColor
                    : buttonbackgroundColor),
                backgroundColor: MaterialStatePropertyAll(borderAvalable == true
                    ? buttonbackgroundColor
                    : buttonForegroundColor)),
            onPressed: press,
            child: Text(
              buttonText!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            )));
  }

  Padding NewRequestView(BuildContext context) {
    List<String> loanType = ['1', '2'];
    TextEditingController loanController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20.h,
        ),
        DropedownWidget(hintText: 'Loan Type', dropDownlist: loanType),
        SizedBox(
          height: 10.h,
        ),
        Text('Choose Sureties', textAlign: TextAlign.start),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              minRadius: 35.r,
              backgroundColor: textFormBase,
              backgroundImage:
                  AssetImage('assets/images/pexels-pixabay-220453 1.png'),
            ),
            CircleAvatar(
              minRadius: 35.r,
              backgroundColor: textFormBase,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ),
            CircleAvatar(
              minRadius: 35.r,
              backgroundColor: textFormBase,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormFieldWidget(controller: loanController, hitText: 'Loan Amount'),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) => PorposeWidget(),
          ),
          child: Container(
            height: 50.h,
            width: 290.w,
            decoration: BoxDecoration(
              color: textFormBase,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text('purpose')),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        ButtonWidget(
            buttonBackgroundColor: whiteColor,
            buttonForegroundColor: buttenBlue,
            buttonText: 'Attach Docements',
            borderAvalable: true,
            press: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => AttachBottemSheet(),
              );
            }),
        SizedBox(
          height: 30.h,
        ),
        ButtonWidget(
            buttonBackgroundColor: buttenBlue,
            buttonForegroundColor: whiteColor,
            buttonText: 'submit',
            borderAvalable: false,
            press: () {})
      ]),
    );
  }

  Container feedDate(String date) {
    return Container(
      height: 30.h,
      width: 120.w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: textFormBase),
      child: Center(
        child: Text(date, textAlign: TextAlign.center),
      ),
    );
  }

  Padding feedActiveData(bool isActive, String filenumber) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 18.w, right: 18.w),
      child: Container(
        height: 230.h,
        width: 500.w,
        decoration: BoxDecoration(
            color: textFormBase,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 40.h,
                    width: 160.w,
                    child: Center(
                      child: Text(
                        'File Number:${filenumber}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    child: Center(
                      child: Text(
                        isActive == true ? 'FB:Active' : 'FB:Closed',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: isActive == true
                            ? const Color.fromARGB(255, 91, 207, 95)
                            : Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  ClipRRect(
                      child: Image.asset(
                        'assets/images/pexels-pixabay-220453 1.png',
                        height: 40.h,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(60))),
                  SizedBox(
                    width: 8.w,
                  ),
                  const Text('ഷഫീഖ് കൊല്ലം (M.107)',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16))
                ],
              ),
              Divider(),
              loanAmount(title: 'കൊടുത്തത്:', price: '200SR'),
              SizedBox(
                height: 10.h,
              ),
              reternDate(title: 'തിരിച്ചടവ്:', date: "26.05.2023")
            ],
          ),
        ),
      ),
    );
  }

  Padding loanAmount({String? title, String? price}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.money),
              Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
          Text(
            price!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }

  Padding reternDate({String? title, String? date}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.date_range),
              Text(
                title!,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
          Text(
            date!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }

  Container Divider() {
    return Container(
      width: 270.w,
      child: const Text(
        '-------------------',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Padding tabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              height: 20.h,
              text: 'New Request',
            ),
            Tab(
              height: 20.h,
              text: 'Request',
            )
          ]),
    );
  }

  Container wallTextWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
              )),
          Text(
            'Loan Request',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: whiteColor,
              ))
        ],
      ),
    );
  }
}
