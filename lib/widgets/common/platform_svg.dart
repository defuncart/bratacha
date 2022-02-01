import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Taken from https://github.com/dnfield/flutter_svg/issues/173#issuecomment-681676269
class PlatformSvg {
  static Widget asset(
    String assetName, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    alignment = Alignment.center,
    String? semanticsLabel,
  }) {
    if (kIsWeb) {
      return Image.network(
        assetName,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        semanticLabel: semanticsLabel,
      );
    }
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}
