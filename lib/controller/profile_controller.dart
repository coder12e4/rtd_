import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/model/profile_model.dart';
import '../backend/parser/profile_parser.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileParser parser;
  ProfileController({required this.parser});
  Profile? userData;
  bool loading = true;
  @override
  void onInit() {
    getUserDatas();
    super.onInit();
  }

  void getUserDatas() async {
    final response = await parser.getUserData();

    if (response.statusCode == 200) {
      try {
        log(response.statusCode.toString());

        Map<String, dynamic> data = Map<String, dynamic>.from(response.body);
        log(data.toString());
        parser.saveProfileData(
          Data(
              id: data['data']['id'],
              name: data['data']['name'],
              email: data['data']['email'],
              emailVerifiedAt: data['data']['email_verified_at'],
              verificationStatus: data['data']['verification_status'],
              indiaMobileNumber: data['data']['india_mobile_number'],
              ksaMobileNumber: data['data']['ksa_mobile_number'],
              bloodGroup: data['data']['blood_group'],
              indianAddress1: data['data']['indian_address_1'],
              indianAddress2: data['data']['indian_address_2'],
              indiaState: data['data']['india_state'],
              indiaPin: data['data']['india_pin'],
              documentProofIndia: data['data']['document_proof_india'],
              ksaAddress1: data['data']['ksa_address_1'],
              ksaAddress2: data['data']['ksa_address_2'],
              ksaState: data['data']['ksa_state'],
              ksaPin: data['data']['ksa_pin'],
              documentProofKsa: data['data']['document_proof_ksa'],
              createdAt: data['data']['created_at'],
              updatedAt: data['data']['updated_at'],
              deletedAt: data['data']['deleted_at']),
        );
        userData = Profile.fromJson(data);

        log(userData!.data.name.toString());
        loading = false;
      } catch (e) {
        log(e.toString());
      }
    } else {
      log(response.body.toString());
    }
    update();
  }

  logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
