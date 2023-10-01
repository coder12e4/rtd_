import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rtd_project/backend/model/elected_member_model.dart';
import 'package:rtd_project/core/color/colors.dart';

class ElectedMemberListTileWidget extends StatelessWidget {
  const ElectedMemberListTileWidget({
    super.key,
    required this.image,
    required this.data,
  });
  final String image;
  final ElectedMemberData data;
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
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data.image),
              ),
            ),
          ),
          Text(
            data.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            data.position,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
          ),
          Text(
            data.mobile,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 14, color: buttenBlue),
          ),
        ],
      ),
    );
  }
}
