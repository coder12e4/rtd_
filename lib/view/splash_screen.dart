import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: background(context),
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
          height: 700,
          width: 400,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 80.h,
                child: Container(
                    height: 80.h,
                    width: 100.w,
                    child: Image.asset('assets/images/logo1.png')),
              ),
            ],
          ),
        )
      ],
    );
  }
}
