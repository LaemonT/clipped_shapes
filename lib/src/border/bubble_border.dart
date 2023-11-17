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

  Path _getPath(RRect original) {
    final helfStroke = side.width / 2.0;
    final rrect = original.deflate(helfStroke);
    final rect = rrect.outerRect;

    final ratio = rect.size.width / original.outerRect.size.width;
    final resizedArrowWidth = arrowWidth * ratio;
    final range = (rect.width - resizedArrowWidth) / 2.0;

    final halfArrowWidth = resizedArrowWidth / 2.0;
    final resizedArrowHeight = arrowHeight;

    switch (direction) {
      case ShapeDirection.up:
        final minOffset = max(range - rrect.blRadiusX, 0);
        final maxOffset = max(range - rrect.brRadiusX, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.bottomCenter.dx + offset, rect.bottomCenter.dy)
          ..lineTo(rect.bottomCenter.dx - halfArrowWidth + offset, rect.bottomCenter.dy - resizedArrowHeight)
          ..lineTo(rect.bottomLeft.dx + rrect.blRadiusX, rect.bottomLeft.dy - resizedArrowHeight)
          ..quadraticBezierTo(rect.bottomLeft.dx, rect.bottomLeft.dy - resizedArrowHeight, rect.bottomLeft.dx,
              rect.bottomLeft.dy - rrect.blRadiusY - resizedArrowHeight)
          ..lineTo(rect.topLeft.dx, rect.topLeft.dy + rrect.tlRadiusY)
          ..quadraticBezierTo(rect.topLeft.dx, rect.topLeft.dy, rect.topLeft.dx + rrect.tlRadiusX, rect.topLeft.dy)
          ..lineTo(rect.topRight.dx - rrect.trRadiusX, rect.topRight.dy)
          ..quadraticBezierTo(rect.topRight.dx, rect.topRight.dy, rect.topRight.dx, rect.topRight.dy + rrect.trRadiusY)
          ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy - rrect.brRadiusY - resizedArrowHeight)
          ..quadraticBezierTo(rect.bottomRight.dx, rect.bottomRight.dy - resizedArrowHeight,
              rect.bottomRight.dx - rrect.brRadiusX, rect.bottomRight.dy - resizedArrowHeight)
          ..lineTo(rect.bottomCenter.dx + halfArrowWidth + offset, rect.bottomCenter.dy - resizedArrowHeight)
          ..close();
      case ShapeDirection.down:
        final minOffset = max(range - rrect.tlRadiusX, 0);
        final maxOffset = max(range - rrect.trRadiusX, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.topCenter.dx + offset, rect.topCenter.dy)
          ..lineTo(rect.topCenter.dx + halfArrowWidth + offset, rect.topCenter.dy + resizedArrowHeight)
          ..lineTo(rect.topRight.dx - rrect.trRadiusX, rect.topRight.dy + resizedArrowHeight)
          ..quadraticBezierTo(rect.topRight.dx, rect.topRight.dy + resizedArrowHeight, rect.topRight.dx,
              rect.topRight.dy + rrect.trRadiusY + resizedArrowHeight)
          ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy - rrect.brRadiusY)
          ..quadraticBezierTo(
              rect.bottomRight.dx, rect.bottomRight.dy, rect.bottomRight.dx - rrect.brRadiusX, rect.bottomRight.dy)
          ..lineTo(rect.bottomLeft.dx + rrect.blRadiusX, rect.bottomLeft.dy)
          ..quadraticBezierTo(
              rect.bottomLeft.dx, rect.bottomLeft.dy, rect.bottomLeft.dx, rect.bottomLeft.dy - rrect.blRadiusY)
          ..lineTo(rect.topLeft.dx, rect.topLeft.dy + rrect.tlRadiusY + resizedArrowHeight)
          ..quadraticBezierTo(rect.topLeft.dx, rect.topLeft.dy + resizedArrowHeight, rect.topLeft.dx + rrect.tlRadiusX,
              rect.topLeft.dy + resizedArrowHeight)
          ..lineTo(rect.topCenter.dx - halfArrowWidth + offset, rect.topCenter.dy + resizedArrowHeight)
          ..close();
      case ShapeDirection.left:
        final minOffset = max(range - rrect.tlRadiusY, 0);
        final maxOffset = max(range - rrect.blRadiusY, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.centerRight.dx, rect.centerRight.dy + offset)
          ..lineTo(rect.centerRight.dx - resizedArrowHeight, rect.centerRight.dy + halfArrowWidth + offset)
          ..lineTo(rect.bottomRight.dx - resizedArrowHeight, rect.bottomRight.dy - rrect.brRadiusY)
          ..quadraticBezierTo(rect.bottomRight.dx - resizedArrowHeight, rect.bottomRight.dy,
              rect.bottomRight.dx - rrect.brRadiusX - resizedArrowHeight, rect.bottomRight.dy)
          ..lineTo(rect.bottomLeft.dx + rrect.blRadiusX, rect.bottomLeft.dy)
          ..quadraticBezierTo(
              rect.bottomLeft.dx, rect.bottomLeft.dy, rect.bottomLeft.dx, rect.bottomLeft.dy - rrect.blRadiusY)
          ..lineTo(rect.topLeft.dx, rect.topLeft.dy + rrect.tlRadiusY)
          ..quadraticBezierTo(rect.topLeft.dx, rect.topLeft.dy, rect.topLeft.dx + rrect.tlRadiusX, rect.topLeft.dy)
          ..lineTo(rect.topRight.dx - resizedArrowHeight - rrect.trRadiusX, rect.topRight.dy)
          ..quadraticBezierTo(rect.topRight.dx - resizedArrowHeight, rect.topRight.dy,
              rect.topRight.dx - resizedArrowHeight, rect.topRight.dy + rrect.trRadiusY)
          ..lineTo(rect.centerRight.dx - resizedArrowHeight, rect.centerRight.dy - halfArrowWidth + offset)
          ..close();
      case ShapeDirection.right:
        final minOffset = max(range - rrect.trRadiusY, 0);
        final maxOffset = max(range - rrect.brRadiusY, 0);
        final offset = arrowOffset.clamp(-minOffset, maxOffset);
        return Path()
          ..moveTo(rect.centerLeft.dx, rect.centerLeft.dy + offset)
          ..lineTo(rect.centerLeft.dx + resizedArrowHeight, rect.centerLeft.dy - halfArrowWidth + offset)
          ..lineTo(rect.topLeft.dx + resizedArrowHeight, rect.topLeft.dy + rrect.tlRadiusY)
          ..quadraticBezierTo(rect.topLeft.dx + resizedArrowHeight, rect.topLeft.dy,
              rect.topLeft.dx + rrect.tlRadiusX + resizedArrowHeight, rect.topLeft.dy)
          ..lineTo(rect.topRight.dx - rrect.trRadiusX, rect.topRight.dy)
          ..quadraticBezierTo(rect.topRight.dx, rect.topRight.dy, rect.topRight.dx, rect.topRight.dy + rrect.trRadiusY)
          ..lineTo(rect.bottomRight.dx, rect.bottomRight.dy - rrect.brRadiusY)
          ..quadraticBezierTo(
              rect.bottomRight.dx, rect.bottomRight.dy, rect.bottomRight.dx - rrect.brRadiusX, rect.bottomRight.dy)
          ..lineTo(rect.bottomLeft.dx + resizedArrowHeight + rrect.blRadiusX, rect.bottomLeft.dy)
          ..quadraticBezierTo(rect.bottomLeft.dx + resizedArrowHeight, rect.bottomLeft.dy,
              rect.bottomLeft.dx + resizedArrowHeight, rect.bottomLeft.dy - rrect.blRadiusY)
          ..lineTo(rect.centerLeft.dx + resizedArrowHeight, rect.centerLeft.dy + halfArrowWidth + offset)
          ..close();
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(borderRadius.resolve(textDirection).toRRect(rect).deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(borderRadius.resolve(textDirection).toRRect(rect));
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
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        canvas.drawPath(
          getOuterPath(rect, textDirection: textDirection),
          side.toPaint()
            ..strokeJoin = StrokeJoin.round
            ..strokeCap = StrokeCap.round,
        );
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
}
