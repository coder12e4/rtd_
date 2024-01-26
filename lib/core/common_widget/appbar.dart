import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.title, this.leading, this.trailing});
  final String title;
  final Widget? leading;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leading != null
            ? leading!
            : const SizedBox(
                width: 30,
              ),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        trailing != null
            ? trailing!
            : const SizedBox(
                width: 30,
              ),
      ],
    );
  }
}
