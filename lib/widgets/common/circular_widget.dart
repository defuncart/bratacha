import 'package:flutter/material.dart';

class CircularWidget extends StatelessWidget {
  final Widget child;
  final double radius;

  const CircularWidget({
    Key key,
    @required this.child,
    @required this.radius,
  })  : assert(child != null),
        assert(radius != null && radius > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: radius,
        width: radius,
        child: child,
      ),
    );
  }
}
