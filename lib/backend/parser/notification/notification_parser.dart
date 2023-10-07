import 'package:get/get.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class NotificationParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  NotificationParser({
    required this.sharedPreferencesManager,
    required this.apiService,
  });
  Future<Response> getNotification() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.getPrivate(
        Constants.baseUrl + Constants.getNotification, accessToken!);
  }

  Future<Response> markNotificationSeen(body) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.postPrivate(
        Constants.baseUrl + Constants.seenNotification, body, accessToken!);
  }
}
