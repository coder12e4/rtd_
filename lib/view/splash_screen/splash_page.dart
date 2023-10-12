import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<SplashScreenController>(
      builder: (controller) => Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: background(context),
        ),
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
            children: <Widget>[
              logoAndText(),
              greenContaner(),
              roadWidget(),
              version()
            ],
          ),
        )
      ],
    );
  }

  Positioned version() => Positioned(
        bottom: 60.h,
        child: const Text(
          'Version: 1.0.8',
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

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
