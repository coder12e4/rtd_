import 'dart:developer';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<void> compressImage(String imagePath) async {
  final file = File(imagePath);
  final originalBytes = await file.readAsBytes();

  final compressedBytes = await FlutterImageCompress.compressWithList(
    originalBytes,
    quality: 75,
    minHeight: 1920,
    minWidth: 1080,
  );

  final compressedFile = File(imagePath)..writeAsBytesSync(compressedBytes);
  log('compressed image : $compressedFile');
}
