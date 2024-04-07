import 'package:bratacha/widgets/common/platform_svg.dart';
import 'package:flutter/material.dart';

class Flag extends StatelessWidget {
  const Flag(
    this.countryCode, {
    required this.size,
    super.key,
  })  : assert(size > 0);

  final String countryCode;
  final double size;

  String get _path => 'assets/flags/$countryCode.svg';

  @override
  Widget build(BuildContext context) {
    return PlatformSvg.asset(
      _path,
      width: size,
      height: size,
    );
  }
}
