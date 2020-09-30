import 'package:bratacha/widgets/common/platform_svg.dart';
import 'package:flutter/material.dart';

class Flag extends StatelessWidget {
  final String countryCode;
  final double width;
  final double height;

  const Flag(
    this.countryCode, {
    this.width,
    this.height,
    Key key,
  })  : assert(countryCode != null),
        assert(width == height),
        super(key: key);

  String get _path => 'assets/flags/${countryCode}.svg';

  @override
  Widget build(BuildContext context) {
    return PlatformSvg.asset(
      _path,
      width: width,
      height: height,
    );
  }
}
