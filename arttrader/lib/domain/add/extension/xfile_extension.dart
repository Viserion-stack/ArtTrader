import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
