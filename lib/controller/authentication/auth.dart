import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Athentication extends GetxController {
  final picker = ImagePicker();
  
  // Rx<XFile?> ksaDoc = ''.obs;
 final indianDoc = ''.obs;
  Future<XFile?> pickImage(ImageSource source) async {
    return await picker.pickImage(source: source);
  }
}
