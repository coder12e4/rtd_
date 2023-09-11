import '../../helper/shared_pref.dart';
import '../api/api.dart';

class EditProfileParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  EditProfileParser(
      {required this.sharedPreferencesManager, required this.apiService});
}
