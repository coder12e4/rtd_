import 'package:get/get.dart';
import 'package:rtd_project/controller/network_controller/network_controller.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkController());
  }
}
