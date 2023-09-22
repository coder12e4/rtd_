import 'package:get/get.dart';

import '../backend/parser/books_parser.dart';

class BookScreenController extends GetxController {
  final BookScreenParser parser;
  BookScreenController({required this.parser});
}
