import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rtd_project/controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: background(context),
      ),
    ));
  }

  Widget background(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/rectangle2.jpg',
                  ))),
          height: 660.h,
          width: 400.w,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[logoAndText(), greenContaner(), roadWidget()],
          ),
        )
      ],
    );
  }

  Positioned roadWidget() {
    return Positioned(
        top: 280.h,
        child: Image.asset(
          'assets/images/road.png',
          height: 400.h,
        ));
  }

  Positioned greenContaner() {
    return Positioned(
        top: 280.h,
        child: Container(
          height: 166.h,
          width: 360.w,
          color: const Color(0xff599354),
        ));
  }

  Positioned logoAndText() {
    return Positioned(
      top: 60.h,
      child: SizedBox(
          height: 300.h,
          width: 300.w,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo1-removebg-preview.png',
                height: 133.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                textAlign: TextAlign.center,
                'RENT TRUCK DRIVERS\n GOOD WILL ORGANIZATION',
                style: TextStyle(
                    fontFamily: 'JekoFont', fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}

////hi Iam rifaee