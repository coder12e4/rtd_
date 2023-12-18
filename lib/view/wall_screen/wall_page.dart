import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rtd_project/controller/wall_screen_controller.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/constraints/conatrints.dart';
import 'package:rtd_project/util/theme.dart';

class WallPage extends StatelessWidget {
  const WallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: baseColor,
            body: DefaultTabController(
              length: 2,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    kSizedBoxH,
                    wallTextWidget(context),
                    kSizedBoxH,
                    tabBar(),
                    tabBarView(context),
                  ],
                ),
              ),
            )));
  }

  Container tabBarView(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 10),
      height: 550.h,
      //hallo
      padding: EdgeInsets.only(bottom: 6.h),
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(40),
          topStart: Radius.circular(40),
        ),
      ),
      child: GetBuilder<WallScreenController>(builder: (value) {
        return Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: TabBarView(children: [
            feedView(value),
            votesView(value),
          ]),
        );
      }),
    );
  }

  Widget votesView(WallScreenController controller) {
    return controller.votesData.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.votesData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  kSizedBoxH,
                  feedDate(controller.votesData[index].createdAt.toString()),
                  VoteData(index, controller)
                ],
              );
            },
          )
        : const Center(
            child: Text(
            "Votes is empty",
            style: TextStyle(fontWeight: FontWeight.w600),
          ));
  }

  Padding VoteData(int index, WallScreenController controller) {
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
                        'Pole Number: ${controller.votesData[index].id}',
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
                        controller.votesData[index].activeStatus == true
                            ? 'Active'
                            : 'Closed',
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
              Text(controller.votesData[index].title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              Divider(),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 15.w,
                runSpacing: 15.h,
                children: controller.votesData[index].options
                    .map(
                      (i) => GestureDetector(
                        onTap: () {
                          // controller.selectedOption = i.option;
                          // controller.update();
                          controller.selectOption(i.option, index);
                          controller.optionId = i.id;
                        },
                        child: optionButton(
                            borderAvalable:
                                controller.selectedOption[index] == i.option
                                    ? true
                                    : false,
                            buttonForegroundColor: Colors.white,
                            buttonbackgroundColor: Colors.black,
                            buttonText: i.option),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: submitedButton(
                  submitStatus: controller.votesData[index].isVoted,
                  buttonForegroundColor: whiteColor,
                  buttonbackgroundColor: Colors.blue,
                  press: () {
                    controller
                        .submitVote(
                            controller
                                .votesData[index].options[0].voteQuestionId,
                            controller.optionId!)
                        .then((value) => controller.optionId = null);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox submitedButton({
    bool? submitStatus,
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
                backgroundColor: MaterialStatePropertyAll(submitStatus != true
                    ? buttonbackgroundColor
                    : Colors.grey)),
            onPressed: submitStatus != true ? press : null,
            child: Text(
              submitStatus != true ? 'Submit' : "submited",
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

  Widget feedView(WallScreenController controller) {
    return controller.loading == true
        ? const Center(
            child: CircularProgressIndicator(
            strokeWidth: 6,
            color: ThemeProvider.blackColor,
          ))
        : Column(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: controller.data?.data.length != 0 ||
                        controller.data?.data == null
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: controller.data?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              feedDate(controller
                                  .data!.data[index].user.createdAt
                                  .toString()),
                              feedActiveData(controller, index),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          );
                        })
                    : const Center(
                        child: Text(
                        "Feed is empty",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
              ),
            ),

            // feedDate('19/10/2023'),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: 1,
            //   itemBuilder: (context, index) => feedActiveData(false, "481"),
            // ),
          ]);
  }

  Container feedDate(String date) {
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
    return Container(
      height: 30.h,
      width: 120.w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: textFormBase),
      child: Center(
        child: Text(formattedDate, textAlign: TextAlign.center),
      ),
    );
  }

  Padding feedActiveData(WallScreenController controller, int index) {
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
                        'File Number: ${controller.data!.data[index].fileNumber}',
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
                        color: controller.data!.data[index].status == 1
                            ? const Color.fromARGB(255, 91, 207, 95)
                            : Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: Text(
                        'FB: ${controller.data!.data[index].statusText}',
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
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage(
                        controller.data!.data[index].user.profileImage),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(controller.data!.data[index].user.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18))
                ],
              ),
              Divider(),
              loanAmount(
                  title: 'കൊടുത്തത്:',
                  price: '${controller.data!.data[index].loanAmount} INR'),
              SizedBox(
                height: 10.h,
              ),
              reternDate(
                  title: 'തിരിച്ചടവ്:',
                  date: controller.data!.data[index].dueDate.toString())
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
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(date!));
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
            formattedDate,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }

  SizedBox Divider() {
    return SizedBox(
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

  Text wallTextWidget(BuildContext context) {
    return Text(
      'Wall',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}
