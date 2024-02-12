import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.url,
    required this.height,
    required this.width,
  });
  final String url;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: url,
        filterQuality: FilterQuality.high,
        // placeholder: (context, url) => Container(
        //   decoration: const BoxDecoration(
        //     shape: BoxShape.circle,
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/placeholder_image.png"),
        //     ),
        //   ),
        // ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.contain,
      ),
    );
  }
}
