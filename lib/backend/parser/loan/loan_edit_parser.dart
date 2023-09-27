import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../core/constraints/api_urls.dart';
import '../../../helper/shared_pref.dart';
import '../../api/api.dart';

class LoanEditParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;
  LoanEditParser(
      {required this.sharedPreferencesManager, required this.apiService});
  Future<Response> getLoanTypes() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.loanType, accessToken!);
    return response;
  }

  Future<Response> getSurties() async {
    final accessToken = sharedPreferencesManager.getString('access_token');
    var response = await apiService.getPrivate(
        Constants.baseUrl + Constants.loanSurties, accessToken!);
    return response;
  }

  Future<Response> getLoanDetails(body) async {
    String accessToken = sharedPreferencesManager.getString('access_token')!;
    return await apiService.postPrivate(
        Constants.baseUrl + Constants.loanRequestEdit, body, accessToken);
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }
}
