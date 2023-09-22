import '../../helper/shared_pref.dart';
import '../api/api.dart';

class WallScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  WallScreenParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
