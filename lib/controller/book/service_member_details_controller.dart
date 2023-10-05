import 'dart:developer';

import 'package:get/get.dart';

import '../../backend/model/books/service_member_details.dart';
import '../../backend/parser/book/service_member_parser.dart';

class ServiceMemberDetailsController extends GetxController {
  final ServiceMemberDetailsParser parser;

  ServiceMemberDetailsController({required this.parser});
  @override
  void onInit() {
    id = Get.arguments[0];
    log(id.toString());
    getServiceMemberDetails(id);
    super.onInit();
  }

  var id;
  bool loading = true;
  ServicesMemberDetails? memberDetails;
  Future<void> getServiceMemberDetails(id) async {
    update();

    try {
      var response = await parser.getServiceMemberDetails(serviceMemberId: id);
      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        log("${response.body}");
        memberDetails = ServicesMemberDetails.fromJson(response.body);
      }
      loading = !loading;
      update();
    } catch (e, stackTrace) {
      log(
        'search member catch $e',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
