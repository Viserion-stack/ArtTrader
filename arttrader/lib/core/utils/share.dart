import 'dart:io';

import 'package:arttrader/export.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ShareHelper {
  static void share(String name, String imageUrl) async {
    final uri = Uri.parse(imageUrl);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);
    await Share.shareXFiles([XFile(path)], subject: name);
  }
}
