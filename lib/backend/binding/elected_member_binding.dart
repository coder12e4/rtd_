import 'dart:developer';

import 'package:get/get.dart';
import 'package:rtd_project/controller/elected_member_controller.dart';

class ElectedMemberBinding extends Bindings {
  @override
  void dependencies() async {
    log('from binding');
    Get.lazyPut(
            ()=> ElectedMemberController(parser: Get.find())
    );
  }
}
