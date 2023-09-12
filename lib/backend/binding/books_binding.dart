import 'package:get/get.dart';
import 'package:rtd_project/controller/book_screen_controller.dart';

class BookScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookScreenController(parser: Get.find()));
  }
}
