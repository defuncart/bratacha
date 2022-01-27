import 'package:bratacha/widgets/common/circular_widget.dart';
import 'package:bratacha/widgets/common/platform_svg.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    required this.languageCode,
    required this.isSelected,
    required this.onPressed,
    this.size = 64,
    Key? key,
  })  : assert(size > 0),
        super(key: key);

  final String languageCode;
  final bool isSelected;
  final VoidCallback onPressed;
  final double size;

  String get _path => 'assets/languages/${languageCode}.svg';

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1 : 0.4,
      child: GestureDetector(
        child: CircularWidget(
          radius: size,
          child: PlatformSvg.asset(
            _path,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
