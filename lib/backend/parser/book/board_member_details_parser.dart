import 'package:get/get.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class BoardMemberDetailsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  BoardMemberDetailsParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getBoardMemberDetails(id) async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    return await apiService.getPrivate(
        "${Constants.baseUrl + Constants.getBoardMemberDetails}$id",
        accessToken!);
  }
}
