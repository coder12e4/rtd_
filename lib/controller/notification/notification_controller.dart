import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';

import '../../backend/model/notification_model/notification_model.dart';
import '../../backend/parser/notification/notification_parser.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationParser parser;
  NotificationController({required this.parser});
  @override
  void onInit() {
    // Timer.periodic(const Duration(seconds: 6), (Timer timer) {
    getNotification();
    // });

    super.onInit();
  }

  bool loading = true;
  int? notificationCount;
  Notification? notification;
  Future<void> getNotification() async {
    try {
      Response response = await parser.getNotification();
      log('notification responce ${response.body}');
      if (response.statusCode == 200) {
        if (response.body != null) {
          notification = Notification.fromJson(response.body);
          notificationCount =
              notification!.data!.where((element) => element.seen == 0).length;
        }

        log('Notification count $notificationCount');
        log('Notification data ${response.body}');
      }
    } catch (e, stackTrace) {
      log('Notification Catch $e', error: e, stackTrace: stackTrace);
    }
    loading = false;
    update();
    // log('Notification list ${notification!.data[0].details.id}');
  }

  Future<void> markNotificationSeen(int id) async {
    final body = {"notification_id": id};
    try {
      Response response = await parser.markNotificationSeen(body);
      if (response.statusCode == 200) {
        log('notification seen api response ${response.body}');
        await getNotification();
      } else {
        log('failed seen notification statusCode: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Seen Notification Catch $e', error: e, stackTrace: stackTrace);
    }

    // log('Notification list ${notification!.data[0].details.id}');
  }
}
