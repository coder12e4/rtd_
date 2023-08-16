import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

class WallPage extends StatelessWidget {
  const WallPage({super.key});

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
                      height: 10.h,
                    ),
                    tabBar(),
                    tabBarView(),
                  ],
                ),
              ),
            )));
  }

  Container tabBarView() {
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
        feedView(),
        votesView(),
      ]),
    );
  }

  Column votesView() {
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
            itemCount: 2,
            itemBuilder: (context, index) => VoteData(true, '07'),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) => VoteData(false, "08"),
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

  Column feedView() {
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
            itemCount: 2,
            itemBuilder: (context, index) => feedActiveData(true, '418'),
          ),
          SizedBox(
            height: 10.h,
          ),
          feedDate('19/10/2023'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) => feedActiveData(false, "481"),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 80),
      child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.blue,
          automaticIndicatorColorAdjustment: true,
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              height: 20,
              text: 'feed',
            ),
            Tab(
              height: 20,
              text: 'Votes',
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
          SizedBox(
            width: 70.w,
          ),
          Text(
            'Wall',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            width: 70.w,
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
