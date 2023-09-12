import '../../helper/shared_pref.dart';
import '../api/api.dart';

class LoanScreenParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  LoanScreenParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
