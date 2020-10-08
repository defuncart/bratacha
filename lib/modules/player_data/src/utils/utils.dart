import 'dart:io';

import 'package:bratacha/modules/player_data/src/services/player_data_service.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

abstract class Utils {
  static void copyInitialDBToDocuments({@required String filename}) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename.hive');

    final assetDB = await rootBundle.load(PlayerDataService.defaultAssetPath);
    final bytes = assetDB.buffer.asUint8List(assetDB.offsetInBytes, assetDB.lengthInBytes);
    file.writeAsBytesSync(bytes);
  }
}
