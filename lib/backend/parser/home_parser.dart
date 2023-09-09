import '../../helper/shared_pref.dart';
import '../api/api.dart';

class HomeParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  HomeParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
