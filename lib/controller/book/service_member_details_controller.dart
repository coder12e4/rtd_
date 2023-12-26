import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> launchURL() async {
    final Uri url = Uri.parse(memberDetails!.data.location.toString());

    if (!await launchUrl(url)) {
      showToast('Failed to find location');
      throw Exception('Could not launch $url');
    }
  }
}
