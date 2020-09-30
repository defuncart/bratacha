import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return SvgPicture.asset(
      _path,
      width: width,
      height: height,
    );
  }
}
