import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Flag extends StatelessWidget {
  const Flag(
    this.countryCode, {
    required this.size,
    super.key,
  }) : assert(size > 0);

  final String countryCode;
  final double size;

  String get _path => 'assets/flags/$countryCode.svg';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.05),
      // seems to look better than antiAlias with svgs
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SvgPicture.asset(
        _path,
        width: size,
        height: size,
      ),
    );
  }
}
