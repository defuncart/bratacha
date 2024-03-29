import 'package:flutter/material.dart';

class CircularWidget extends StatelessWidget {
  const CircularWidget({
    required this.child,
    required this.radius,
    Key? key,
  })  : assert(radius > 0),
        super(key: key);

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        height: radius,
        width: radius,
        child: child,
      ),
    );
  }
}
