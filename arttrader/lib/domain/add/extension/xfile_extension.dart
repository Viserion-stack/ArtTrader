import 'dart:convert';

import 'package:camera/camera.dart';

extension XFileExtension on XFile {
  Future<String?> imageBase64() async {
    try {
      final photoAsBytes = await readAsBytes();
      final photoBase64 = const Base64Encoder().convert(photoAsBytes);
      return photoBase64;
    } on Exception catch (_) {
      return null;
    }
  }
}
