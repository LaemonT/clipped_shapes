import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../style/shape_styles.dart';

class BubbleBorder extends OutlinedBorder {
  final ShapeDirection direction;
  final double arrowWidth;
  final double arrowHeight;
  final double arrowOffset;
  final BorderRadius borderRadius;

  BubbleBorder({
    required this.direction,
    double? arrowWidth,
    double? arrowHeight,
    double? arrowOffset,
    BorderSide side = BorderSide.none,
    BorderRadius? borderRadius,
  })  : arrowWidth = arrowWidth ?? 16.0,
        arrowHeight = arrowHeight ?? 16.0,
        arrowOffset = arrowOffset ?? 0.0,
        borderRadius = borderRadius ?? BorderRadius.circular(16.0),
        assert(side.strokeAlign == BorderSide.strokeAlignInside, 'BubbleBorder only draws the border line inside'),
        super(side: side);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  ShapeBorder scale(double t) {
    return BubbleBorder(
      direction: direction,
      arrowWidth: arrowWidth,
      arrowHeight: arrowHeight,
      arrowOffset: arrowOffset,
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  BubbleBorder copyWith({
    ShapeDirection? direction,
    double? arrowWidth,
    double? arrowHeight,
    double? arrowOffset,
    BorderSide? side,
    BorderRadius? borderRadius,
  }) {
    return BubbleBorder(
      direction: direction ?? this.direction,
      arrowWidth: arrowWidth ?? this.arrowWidth,
      arrowHeight: arrowHeight ?? this.arrowHeight,
      arrowOffset: arrowOffset ?? this.arrowOffset,
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _bubblePath(rect.deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _bubblePath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final paint = side.toPaint();
        paint.strokeWidth = side.width * 2;
        canvas.drawPath(_bubblePath(rect), paint);
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is BubbleBorder &&
        (other.direction == direction &&
            other.arrowWidth == arrowWidth &&
            other.arrowHeight == arrowHeight &&
            other.arrowOffset == arrowOffset &&
            other.side == side &&
            other.borderRadius == borderRadius);
  }

  @override
  int get hashCode => side.hashCode;

  @override
  String toString() {
    return '${objectRuntimeType(this, 'BubbleBorder')}($side)';
  }

  Path _bubblePath(Rect rect) {
    final range = (rect.width - arrowWidth) / 2.0;

    switch (direction) {
      case ShapeDirection.up:
        final minOffset = max(range - borderRadius.bottomLeft.x, 0);
        final maxOffset = max(range - borderRadius.bottomRight.x, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.bottomCenter.dx + offset, rect.bottomCenter.dy)
          ..lineTo(rect.bottomCenter.dx - (arrowWidth / 2.0) + offset, rect.bottomCenter.dy - arrowHeight)
          ..lineTo(rect.bottomLeft.dx + borderRadius.bottomLeft.x, rect.bottomLeft.dy - arrowHeight)
          ..quadraticBezierTo(rect.bottomLeft.dx, rect.bottomLeft.dy - arrowHeight, rect.bottomLeft.dx,
              rect.bottomLeft.dy - borderRadius.bottomLeft.y - arrowHeight)
          ..lineTo(rect.topLeft.dx, rect.topLeft.dy + borderRadius.topLeft.y)
          ..quadraticBezierTo(
              rect.topLeft.dx, rect.topLeft.dy, rect.topLeft.dx + borderRadius.topLeft.x, rect.topLeft.dy)
          ..lineTo(rect.topRight.dx - borderRadius.topRight.x, rect.topRight.dy)
          ..quadraticBezierTo(
              rect.topRight.dx, rect.topRight.dy, rect.topRight.dx, rect.topRight.dy + borderRadius.topRight.y)
          ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy - borderRadius.bottomRight.y - arrowHeight)
          ..quadraticBezierTo(rect.bottomRight.dx, rect.bottomRight.dy - arrowHeight,
              rect.bottomRight.dx - borderRadius.bottomRight.x, rect.bottomRight.dy - arrowHeight)
          ..lineTo(rect.bottomCenter.dx + (arrowWidth / 2.0) + offset, rect.bottomCenter.dy - arrowHeight)
          ..close();
      case ShapeDirection.down:
        final minOffset = max(range - borderRadius.topLeft.x, 0);
        final maxOffset = max(range - borderRadius.topRight.x, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.topCenter.dx + offset, rect.topCenter.dy)
          ..lineTo(rect.topCenter.dx + (arrowWidth / 2.0) + offset, rect.topCenter.dy + arrowHeight)
          ..lineTo(rect.topRight.dx - borderRadius.topRight.x, rect.topRight.dy + arrowHeight)
          ..quadraticBezierTo(rect.topRight.dx, rect.topRight.dy + arrowHeight, rect.topRight.dx,
              rect.topRight.dy + borderRadius.topRight.y + arrowHeight)
          ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy - borderRadius.bottomRight.y)
          ..quadraticBezierTo(rect.bottomRight.dx, rect.bottomRight.dy,
              rect.bottomRight.dx - borderRadius.bottomRight.x, rect.bottomRight.dy)
          ..lineTo(rect.bottomLeft.dx + borderRadius.bottomLeft.x, rect.bottomLeft.dy)
          ..quadraticBezierTo(rect.bottomLeft.dx, rect.bottomLeft.dy, rect.bottomLeft.dx,
              rect.bottomLeft.dy - borderRadius.bottomLeft.y)
          ..lineTo(rect.topLeft.dx, rect.topLeft.dy + borderRadius.topLeft.y + arrowHeight)
          ..quadraticBezierTo(rect.topLeft.dx, rect.topLeft.dy + arrowHeight, rect.topLeft.dx + borderRadius.topLeft.x,
              rect.topLeft.dy + arrowHeight)
          ..lineTo(rect.topCenter.dx - (arrowWidth / 2.0) + offset, rect.topCenter.dy + arrowHeight)
          ..close();
      case ShapeDirection.left:
        final minOffset = max(range - borderRadius.topLeft.y, 0);
        final maxOffset = max(range - borderRadius.bottomLeft.y, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.centerRight.dx, rect.centerRight.dy + offset)
          ..lineTo(rect.centerRight.dx - arrowHeight, rect.centerRight.dy + (arrowWidth / 2.0) + offset)
          ..lineTo(rect.bottomRight.dx - arrowHeight, rect.bottomRight.dy - borderRadius.bottomRight.y)
          ..quadraticBezierTo(rect.bottomRight.dx - arrowHeight, rect.bottomRight.dy,
              rect.bottomRight.dx - borderRadius.bottomRight.x - arrowHeight, rect.bottomRight.dy)
          ..lineTo(rect.bottomLeft.dx + borderRadius.bottomLeft.x, rect.bottomLeft.dy)
          ..quadraticBezierTo(rect.bottomLeft.dx, rect.bottomLeft.dy, rect.bottomLeft.dx,
              rect.bottomLeft.dy - borderRadius.bottomLeft.y)
          ..lineTo(rect.topLeft.dx, rect.topLeft.dy + borderRadius.topLeft.y)
          ..quadraticBezierTo(
              rect.topLeft.dx, rect.topLeft.dy, rect.topLeft.dx + borderRadius.topLeft.x, rect.topLeft.dy)
          ..lineTo(rect.topRight.dx - arrowHeight - borderRadius.topRight.x, rect.topRight.dy)
          ..quadraticBezierTo(rect.topRight.dx - arrowHeight, rect.topRight.dy, rect.topRight.dx - arrowHeight,
              rect.topRight.dy + borderRadius.topRight.y)
          ..lineTo(rect.centerRight.dx - arrowHeight, rect.centerRight.dy - (arrowWidth / 2.0) + offset)
          ..close();
      case ShapeDirection.right:
        final minOffset = max(range - borderRadius.topRight.y, 0);
        final maxOffset = max(range - borderRadius.bottomRight.y, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.centerLeft.dx, rect.centerLeft.dy + offset)
          ..lineTo(rect.centerLeft.dx + arrowHeight, rect.centerLeft.dy - (arrowWidth / 2.0) + offset)
          ..lineTo(rect.topLeft.dx + arrowHeight, rect.topLeft.dy + borderRadius.topLeft.y)
          ..quadraticBezierTo(rect.topLeft.dx + arrowHeight, rect.topLeft.dy,
              rect.topLeft.dx + borderRadius.topLeft.x + arrowHeight, rect.topLeft.dy)
          ..lineTo(rect.topRight.dx - borderRadius.topRight.x, rect.topRight.dy)
          ..quadraticBezierTo(
              rect.topRight.dx, rect.topRight.dy, rect.topRight.dx, rect.topRight.dy + borderRadius.topRight.y)
          ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy - borderRadius.bottomRight.y)
          ..quadraticBezierTo(rect.bottomRight.dx, rect.bottomRight.dy,
              rect.bottomRight.dx - borderRadius.bottomRight.x, rect.bottomRight.dy)
          ..lineTo(rect.bottomLeft.dx + arrowHeight + borderRadius.bottomLeft.x, rect.bottomLeft.dy)
          ..quadraticBezierTo(rect.bottomLeft.dx + arrowHeight, rect.bottomLeft.dy, rect.bottomLeft.dx + arrowHeight,
              rect.bottomLeft.dy - borderRadius.bottomLeft.y)
          ..lineTo(rect.centerLeft.dx + arrowHeight, rect.centerLeft.dy + (arrowWidth / 2.0) + offset)
          ..close();
    }
  }
}
