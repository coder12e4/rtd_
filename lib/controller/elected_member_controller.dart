import 'dart:developer';
import 'dart:async';
import 'package:get/get.dart';
import 'package:rtd_project/backend/model/elected_member_model.dart';
import 'package:rtd_project/backend/parser/elected_member_parser.dart';
import 'package:rtd_project/helper/router.dart';

class ElectedMemberController extends GetxController implements GetxService {
  final ElectedMemberParser parser;

  ElectedMemberController({required this.parser});



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

  void goToELectedMemberScreen() {
    Get.toNamed(AppRouter.getElectedMemberRoute());
  }
}
