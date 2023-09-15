import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/backend/model/home_data_model.dart';

import '../backend/parser/home_parser.dart';
import 'dart:async';


class HomeController extends GetxController implements GetxService {
  final HomeParser parser;
  HomeController({required this.parser});
  @override
  void onInit() async{
    await getHomeDatas();
    super.onInit();
  }

     HomeData? homeData;
  final _homeDataController = StreamController<HomeData>();

  Stream<HomeData> get homeDataStream => _homeDataController.stream;


  Future<HomeData> getHomeDatas() async {
    Response response = await parser.getHomeData();

    if (response.statusCode == 200) {
      HomeData data = HomeData.fromJson(response.body);
      homeData = data;
      log(data.data.graphData.toString());

      _homeDataController.add(data); // Emit data to the stream
    }
    return homeData!;
  }

}
