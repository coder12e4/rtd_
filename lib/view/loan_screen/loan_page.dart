import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';
import 'package:rtd_project/core/common_widget/dropdown_widget.dart';
import 'package:rtd_project/core/common_widget/textformfield_widget.dart';
import 'package:rtd_project/view/loan_screen/widgets/attach_bottem_sheet.dart';
import 'package:rtd_project/view/loan_screen/widgets/cancel_popup.dart';
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

  Container requestDate(String date) {
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

  Container tabBarView(BuildContext context) {
    return Container(
      height: 850.h,
      //hallo
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(40),
          topStart: Radius.circular(40),
        ),
      ),
      child:
          TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
        NewRequestView(context),
        requestView(context),
      ]),
    );
  }

  ListView requestView(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) => Column(children: [
        SizedBox(
          height: 10.h,
        ),
        requestDate('19/10/2023'),
        SizedBox(
          height: 10.h,
        ),
        requestData(index == 0 ? true : false, context)
      ]),
    );
  }

  Padding requestData(bool prossesing, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: prossesing == true ? 300.h : 360.h,
        width: 500.w,
        decoration: BoxDecoration(
            color: textFormBase,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 40.h,
                    width: 140.w,
                    child: Center(
                      child: Text(
                        prossesing == true
                            ? 'Status:Prossesing'
                            : 'Status:Rejected',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 110.w,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Center(
                      child: Text(
                        'Edit Request',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              loanAmount(price: '200SR', title: 'ആവശ്യപ്പെട്ടത്:'),
              Divider(),
              imageRow(prossesing),
              SizedBox(
                height: 8.h,
              ),
              prossesing == true
                  ? ButtonWidget(
                      buttonBackgroundColor: whiteColor,
                      buttonForegroundColor: buttenBlue,
                      buttonText: 'Cancel Request',
                      borderAvalable: true,
                      press: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => CancelPopup(),
                        );
                      })
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reasons for rejection:',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const Text(
                          'Here reasons for the rejection can be shown',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          ' \ . First reason for rejection',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          ' \. Second reason for rejection',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          ' \. Third reason for rejection',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Row imageRow(bool prossesing) {
    return Row(
      children: [
        Chechmarkimage(true, true),
        Chechmarkimage(true, true),
        Chechmarkimage(false, prossesing == false ? true : false),
        Chechmarkimage(false, prossesing == false ? true : false)
      ],
    );
  }

  Stack Chechmarkimage(bool checkmark, bool markAvalable) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            minRadius: 30.r,
            backgroundImage:
                const AssetImage('assets/images/pexels-pixabay-220453 1.png'),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: markAvalable == true
                ? Container(
                    width: 20.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                        color: checkmark == true ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(50.r))),
                    child: Icon(
                      checkmark == true ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                : Container())
      ],
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
        const Text('Choose Sureties', textAlign: TextAlign.start),
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
                  const AssetImage('assets/images/pexels-pixabay-220453 1.png'),
            ),
            CircleAvatar(
              minRadius: 35.r,
              backgroundColor: textFormBase,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ),
            CircleAvatar(
              minRadius: 35.r,
              backgroundColor: textFormBase,
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
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
            builder: (context) => const PorposeWidget(),
          ),
          child: Container(
            height: 50.h,
            width: 290.w,
            decoration: BoxDecoration(
              color: textFormBase,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Text('purpose')),
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
                builder: (context) => const AttachBottemSheet(),
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

  //

  Container Divider() {
    return Container(
      width: 280.w,
      child: const Text(
        overflow: TextOverflow.fade,
        maxLines: 1,
        '---------------------------',
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
