import 'package:bratacha/widgets/common/circular_widget.dart';
import 'package:bratacha/widgets/common/platform_svg.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final String languageCode;
  final bool isSelected;
  final void Function() onPressed;
  final double size;

  const LanguageButton({
    Key key,
    @required this.languageCode,
    @required this.isSelected,
    @required this.onPressed,
    this.size = 64,
  })  : assert(languageCode != null),
        assert(isSelected != null),
        assert(onPressed != null),
        assert(size != null),
        assert(size > 0),
        super(key: key);

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
