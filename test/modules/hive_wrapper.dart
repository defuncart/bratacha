import 'dart:io';

import 'package:hive/hive.dart';

Future<void> hiveWrapper({
  required Future<void> Function() callback,
  bool cleanUpOnSetUp = true,
}) async {
  const dir = '_temp';

  if (cleanUpOnSetUp) {
    // set up clean, temp directory
    if (await Directory(dir).exists()) {
      await Directory(dir).delete(recursive: true);
    }
  }

  // initialize Hive
  Hive.init(dir);

  // await tests
  await callback();

  // ensure all temp files are removed
  if (await Directory(dir).exists()) {
    await Directory(dir).delete(recursive: true);
  }
}
