import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    this.size = 512,
    this.hasTransparentBackground = false,
  });

  final double size;
  final bool hasTransparentBackground;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ColoredBox(
        color: hasTransparentBackground ? Colors.transparent : Theme.of(context).colorScheme.secondary,
        child: Icon(
          MdiIcons.flagVariantOutline,
          size: size * 0.75,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
