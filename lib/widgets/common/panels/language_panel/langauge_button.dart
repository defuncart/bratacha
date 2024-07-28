import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    required this.languageCode,
    required this.isSelected,
    required this.onPressed,
    this.size = 64,
    super.key,
  }) : assert(size > 0);

  final String languageCode;
  final bool isSelected;
  final VoidCallback onPressed;
  final double size;

  String get _path => 'assets/languages/$languageCode.svg';

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1 : 0.4,
      child: GestureDetector(
        onTap: onPressed,
        child: ClipOval(
          // seems to look better than antiAlias with svgs
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SvgPicture.asset(
            _path,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
