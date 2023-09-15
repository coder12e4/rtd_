import 'package:get/get.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';

import '../backend/parser/home_parser.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;
  HomeController({required this.parser});
  @override
  void onInit() {
    getHomeDatas();
    super.onInit();
  }

  HomeData? data;
  bool loading = true;
  Future<void> getHomeDatas() async {
    Response response = await parser.getHomeData();
    // log(response.body.toString());
    if (response.statusCode == 200) {
      data = HomeData.fromJson(response.body);
      loading = false;
    }
  }
}
