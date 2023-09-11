import 'package:get/get.dart';

import '../backend/parser/edit_profile_parser.dart';

class EditProfileController extends GetxController implements GetxService {
  final EditProfileParser parser;
  EditProfileController({required this.parser});
}
