import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberistTileWidget extends StatelessWidget {
  const MemberistTileWidget({
    super.key,
    required this.name,
    required this.image,
    required this.memberid,
  });
  final String name;
  final String image;
  final String memberid;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: CachedNetworkImageProvider(image))),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '($memberid)',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
