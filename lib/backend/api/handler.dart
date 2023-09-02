/*writen by hariprasad*/
import 'package:get/get.dart';
import 'package:rtd_project/util/toast.dart';


class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showToast('Session expired!'.tr);
    } else {
      showToast(response.statusText.toString().tr);
    }
  }
}
