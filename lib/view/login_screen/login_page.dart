import 'package:flutter/material.dart';

class LOginPage extends StatelessWidget {
  const LOginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: loginWidget(context),
    ));
  }

  Widget loginWidget(BuildContext context) {
    return const Column(
      children: [Text('login page')],
    );
  }
}
