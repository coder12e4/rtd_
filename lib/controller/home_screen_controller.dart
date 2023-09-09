import 'package:get/get.dart';

import '../backend/parser/home_parser.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;
  HomeController({required this.parser});
}
