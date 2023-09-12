import '../../helper/shared_pref.dart';
import '../api/api.dart';

class BookScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  BookScreenParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
