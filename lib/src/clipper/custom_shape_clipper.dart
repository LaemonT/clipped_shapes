import 'package:flutter/rendering.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  final OutlinedBorder border;

  CustomShapeClipper({
    required this.border,
  });

  @override
  Path getClip(Size size) {
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width,
      height: size.height,
    );
    return border.getOuterPath(rect);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => this != oldClipper;
}
