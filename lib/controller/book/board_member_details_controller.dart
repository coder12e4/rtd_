import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';

import '../../backend/model/books/board_member_details_model.dart';
import '../../backend/parser/book/board_member_details_parser.dart';

class BoardMemberDetailsController extends GetxController
    implements GetxService {
  final BoardMemberDetailsParser parser;
  BoardMemberDetailsController({required this.parser});
  @override
  void onInit() {
    memberId = Get.arguments[0];
    getBoardMemberDetails();
    super.onInit();
  }

  bool loading = true;
  MemberDetails? memberDetails;
  var memberId;

  Future<void> getBoardMemberDetails() async {
    Response response = await parser.getBoardMemberDetails(memberId);

    log("bord member details response ${response.body}");
    try {
      if (response.statusCode == 200) {
        loading = false;
        if (response.body["status"] == true) {
          memberDetails = MemberDetails.fromJson(response.body);
        } else {
          showToast('${response.body['message']}');
        }
      } else {
        showToast('${response.body['message']}');
      }
    } catch (e, stackTrace) {
      log("Board member details catch $e", error: e, stackTrace: stackTrace);
    }
    update();
  }
}
