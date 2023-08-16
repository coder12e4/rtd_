import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/core/color/colors.dart';

class ElectedMemberListTileWidget extends StatelessWidget {
  const ElectedMemberListTileWidget({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 80.h,
            width: 90.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
          Text(
            'Bapputty',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '    Charity \nCoordinator',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
          ),
          Text(
            '+91 9745 12 34 56',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 14, color: buttenBlue),
          ),
        ],
      ),
    );
  }
}
