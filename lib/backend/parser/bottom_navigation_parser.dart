import '../../helper/shared_pref.dart';
import '../api/api.dart';

class BottomNavParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  BottomNavParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
