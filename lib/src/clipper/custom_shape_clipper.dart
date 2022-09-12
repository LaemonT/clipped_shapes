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
    final resolvedRect = _downsizedRect(rect, border);
    return border.getOuterPath(resolvedRect);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => this != oldClipper;

  // Reduce the clipper size
  Rect _downsizedRect(Rect rect, OutlinedBorder border) => rect.deflate(border.side.width / 2.0);
}
