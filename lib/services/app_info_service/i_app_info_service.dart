import 'package:flutter/material.dart';

abstract class IAppInfoService {
  String get applicationName;
  String get applicationVersion;
  Widget get applicationIcon;
  String get applicationLegalese;
}
