import 'package:get/get.dart';
import 'package:rtd_project/backend/api/api.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/helper/shared_pref.dart';

class ElectedMemberParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  ElectedMemberParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getAllElectedMembers()async{
     return await apiService
       .getPublic(Constants.baseUrl + Constants.getAllElectedMembers);
  }
}
