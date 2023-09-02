import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/backend/parser/sighnup_parser.dart';

class Athentication extends GetxController implements GetxService {
  Athentication( {required this.parser});
  final SignUpParser parser;
  final picker = ImagePicker();

  final Rx<XFile?> ksaDoc = Rx<XFile?>(null);
  final Rx<XFile?> indianDoc = Rx<XFile?>(null);

  
final TextEditingController nameRegController = TextEditingController();
final TextEditingController mobileNumRegController = TextEditingController();
final TextEditingController ksaMobileNumRegController = TextEditingController();
final TextEditingController watsappNumRegController = TextEditingController();
/////resisidants adress in ksa/////////
final TextEditingController resAddressLine1Controller = TextEditingController();
final TextEditingController resAddressLine2Controller = TextEditingController();
/////////////////////////emargency contact 1 ksa////////////////////////
final TextEditingController emName1Controller = TextEditingController();
final TextEditingController emMobileNum1Controller = TextEditingController();
/////////////////////////emargency contact 2 ksa////////////////////////
final TextEditingController emName2Controller = TextEditingController();
final TextEditingController emMObilenum2Controller = TextEditingController();
/////////////////////////indian adress////////////////////////
final TextEditingController indianAddressLine1Controller =
    TextEditingController();
final TextEditingController indianAddressLine2Controller =
    TextEditingController();
///////////////////////emarangcy contact india1//////////////////////////////////
final TextEditingController emIndiaName1Controller = TextEditingController();
final TextEditingController emIndiaMobile1Controller = TextEditingController();
///////////////////////emarangcy contact india2//////////////////////////////////
final TextEditingController emIndiaName2Controller = TextEditingController();
final TextEditingController emIndiaMobile2Controller = TextEditingController();
///////////////////////last section//////////////////////////////////
final TextEditingController iqamaNumController = TextEditingController();
final TextEditingController iqamaexperyDateController = TextEditingController();
final TextEditingController passNumController = TextEditingController();
final TextEditingController passExperyNumController = TextEditingController();
final TextEditingController maritalStatusController = TextEditingController();
final TextEditingController numOfChildrenController = TextEditingController();
final TextEditingController nomineController = TextEditingController();
final TextEditingController sponserNameController = TextEditingController();
final TextEditingController locationController = TextEditingController();
final TextEditingController estNmaeController = TextEditingController();
final TextEditingController teleNumController = TextEditingController();
final TextEditingController lastMobileNumController = TextEditingController();
final TextEditingController sprMobileNumController = TextEditingController();
final TextEditingController resVehichleNumController = TextEditingController();
final TextEditingController vehMoedelController = TextEditingController();
final TextEditingController vehTypeController = TextEditingController();
final TextEditingController vehCompanyController = TextEditingController();

  Future<XFile?> pickImage(ImageSource source) async {
    return await picker.pickImage(source: source);
  }
}
