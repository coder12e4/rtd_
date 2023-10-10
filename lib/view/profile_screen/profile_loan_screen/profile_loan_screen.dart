import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtd_project/controller/loan/loan_details_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/view/profile_screen/loan_detailes_screen/activelone_details_screen.dart';
import 'package:rtd_project/view/profile_screen/loan_detailes_screen/rejected_loan.dart';

import '../../../backend/model/loan/active_loan_model.dart';

class ProfileLoanScreen extends StatelessWidget {
  const ProfileLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: baseColor,
            body: SingleChildScrollView(
              child: DefaultTabController(
                length: 2,
                child: GetBuilder<LoanDetailsController>(builder: (value) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      wallTextWidget(context),
                      SizedBox(
                        height: 10.h,
                      ),
                      tabBar(),
                      tabBarView(value),
                    ],
                  );
                }),
              ),
            )));
  }

  Container tabBarView(LoanDetailsController controller) {
    return Container(
      height: 1050.h,
      //hallo
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(40),
          topStart: Radius.circular(40),
        ),
      ),
      child: TabBarView(children: [
        activeLoan(controller),
        closedLoan(controller),
      ]),
    );
  }

  Column closedLoan(LoanDetailsController controller) {
    return Column(
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 10.h,
          ),
          feedDate('19/10/2023'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.closedLoans?.data.data.length ?? 0,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RejectedLoanScreen(),
                  ));
                },
                child: activeAndClosedLoans(
                    false, '418', controller, index, controller.closedLoans!)),
          ),
          SizedBox(
            height: 10.h,
          ),
        ]);
  }

  Padding VoteData(bool isActive, String filenumber) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 18.w, right: 18.w),
      child: Container(
        height: 300.h,
        width: 500.w,
        decoration: BoxDecoration(
            color: textFormBase,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Pole Number:$filenumber',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        isActive == true ? 'Active' : 'Closed',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text("വോട്ടിന്റെ വിഷയം ഇവിടെ എഴുതുക",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16)),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  optionButton(
                      borderAvalable: false,
                      buttonForegroundColor: Colors.white,
                      buttonbackgroundColor: Colors.black,
                      buttonText: 'Option one'),
                  optionButton(
                      borderAvalable: false,
                      buttonForegroundColor: Colors.white,
                      buttonbackgroundColor: Colors.black,
                      buttonText: 'Option Two')
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              optionButton(
                  borderAvalable: true,
                  buttonForegroundColor: Colors.white,
                  buttonbackgroundColor: Colors.black,
                  buttonText: 'Option Three Hire'),
              SizedBox(
                height: 10.h,
              ),
              submitedButton(
                  borderAvalable: true,
                  buttonForegroundColor: whiteColor,
                  buttonbackgroundColor: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox submitedButton({
    bool? borderAvalable,
    Color? buttonForegroundColor,
    Color? buttonbackgroundColor,
    Function()? press,
  }) {
    return SizedBox(
        height: 30.h,
        width: 260.w,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll(buttonForegroundColor),
                backgroundColor: MaterialStatePropertyAll(borderAvalable == true
                    ? buttonbackgroundColor
                    : Colors.grey)),
            onPressed: press,
            child: Text(
              borderAvalable == true ? 'Submit' : "submited",
              style: const TextStyle(fontWeight: FontWeight.w700),
            )));
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

  Column activeLoan(LoanDetailsController controller) {
    final data = controller.activeLoans?.data.data;
    return Column(
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 10.h,
          ),
          feedDate('19/10/2023'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActiveLoanDetailsScreen(
                      controller: controller,
                      index: index,
                    ),
                  ),
                );
              },
              child: activeAndClosedLoans(
                  true, '418', controller, index, controller.activeLoans!),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ]);
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

  Padding activeAndClosedLoans(bool isActive, String filenumber,
      LoanDetailsController controller, int index, ActiveLoans loanData) {
    final data = loanData.data.data[index];
    String formattedDate = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(data.dueDate.toString()));
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
                        'File Number: ${data.fileNumber}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: isActive == true
                            ? const Color.fromARGB(255, 91, 207, 95)
                            : Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        isActive == true ? 'FB:Active' : 'FB:Closed',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      data.user.profileImage,
                      height: 40.h,
                      width: 40.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text('${data.user.name} (${data.user.memberId})',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16))
                ],
              ),
              Divider(),
              loanAmount(title: 'കിട്ടിയത്:', price: data.loanAmount),
              loanAmount(title: 'കൊടുത്തത്:', price: data.paidAmount),
              // SizedBox(
              //   height: 10.h,
              // ),
              reternDate(title: 'തിരിച്ചടവ്:', date: formattedDate)
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 80),
      child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 5.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              height: 20,
              text: 'Active',
            ),
            Tab(
              height: 20,
              text: 'Closed',
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
              )),
          SizedBox(
            width: 70.w,
          ),
          Text(
            'Loans',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            width: 105.w,
          )
        ],
      ),
    );
  }
}
