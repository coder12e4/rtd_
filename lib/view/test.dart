import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyController extends GetxController {
  var progress = 0.0;

  // Simulate some task that updates the progress.
  Future<void> simulateTask() async {
    for (var i = 0; i < 100; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      progress = (i + 1) / 100;
      update();
    }
  }
}

class MyApp extends StatelessWidget {
  final MyController myController = MyController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GetBuilder Linear Progress Indicator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GetBuilder<MyController>(
                init: myController,
                builder: (controller) {
                  return LinearProgressIndicator(
                    value: controller.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await myController.simulateTask();
                },
                child: Text('Start Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
