import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/backend/model/elected_member_model.dart';
import 'package:rtd_project/backend/parser/elected_member_parser.dart';

class ElectedMemberController extends GetxController implements GetxService {
  final ElectedMemberParser parser;

  ElectedMemberController({required this.parser});
  @override
  void onInit() {
    isStart = Get.arguments[0];
    super.onInit();
  }

  bool? isStart;

  List<ElectedMemberData> _allElectedMembers = <ElectedMemberData>[];
  List<ElectedMemberData> get allElectedMembers => _allElectedMembers;

  Future<List<ElectedMemberData>> getElectedMembers() async {
    var response = await parser.getAllElectedMembers();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var allElectedMembers = myMap['data'];

      _allElectedMembers = [];

      allElectedMembers.forEach((data) {
        ElectedMemberData individual = ElectedMemberData.fromJson(data);
        _allElectedMembers.add(individual);
      });
    }
    log(_allElectedMembers.toString());
    return _allElectedMembers;
  }
}
