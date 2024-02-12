import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuretyWidget extends StatelessWidget {
  const SuretyWidget(
      {super.key,
      required this.url,
      required this.name,
      required this.suretyStatus});
  final String url;
  final String name;
  final int suretyStatus;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 60.h,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                minRadius: 30.r,
                backgroundImage: CachedNetworkImageProvider(url),
              ),
              Positioned(
                bottom: 0.h,
                right: 5,
                child: suretyStatusWidget(status: suretyStatus),
              )
            ],
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

Container suretyStatusWidget({required int status}) {
  if (status == 0) {
    return Container(
      width: 20.w,
      height: 18.h,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(50.r))),
      child: const Icon(
        Icons.pending_actions,
        color: Colors.white,
        size: 16,
      ),
    );
  }
  if (status == 1) {
    return Container(
      width: 20.w,
      height: 18.h,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(50.r))),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  return Container(
    width: 20.w,
    height: 18.h,
    decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(50.r))),
    child: const Icon(
      Icons.close,
      color: Colors.white,
      size: 16,
    ),
  );
}
