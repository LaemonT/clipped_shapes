import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'border/bubble_border.dart';
import 'style/shape_styles.dart';

class ShapedBox extends StatelessWidget {
  final Color? color;
  final OutlinedBorder border;
  final List<BoxShadow>? shadows;
  final Widget? child;

  const ShapedBox._({
    this.color,
    required this.border,
    this.shadows,
    this.child,
  });

  ShapedBox.rounded({
    super.key,
    this.color,
    BorderRadius? borderRadius,
    BorderSide borderSide = BorderSide.none,
    RoundedCornerStyle cornerStyle = RoundedCornerStyle.circular,
    this.shadows,
    this.child,
  }) : border = cornerStyle == RoundedCornerStyle.circular
            ? RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
                side: borderSide,
              )
            : ContinuousRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
                side: borderSide,
              );

  ShapedBox.stadium({
    super.key,
    this.color,
    BorderSide borderSide = BorderSide.none,
    this.shadows,
    this.child,
  }) : border = StadiumBorder(side: borderSide);

  ShapedBox.oval({
    super.key,
    this.color,
    BorderSide borderSide = BorderSide.none,
    this.shadows,
    this.child,
  }) : border = OvalBorder(side: borderSide);

  ShapedBox.circle({
    super.key,
    required double size,
    this.color,
    BorderSide borderSide = BorderSide.none,
    this.shadows,
    Widget? child,
  })  : border = CircleBorder(side: borderSide),
        child = SizedBox(
          width: size,
          height: size,
          child: child,
        );

  ShapedBox.bubble({
    super.key,
    ShapeDirection direction = ShapeDirection.up,
    double? arrowWidth,
    double? arrowHeight,
    double? arrowOffset,
    this.color,
    BorderRadius? borderRadius,
    BorderSide borderSide = BorderSide.none,
    this.shadows,
    this.child,
  }) : border = BubbleBorder(
          direction: direction,
          arrowWidth: arrowWidth,
          arrowHeight: arrowHeight,
          arrowOffset: arrowOffset,
          borderRadius: borderRadius,
          side: borderSide,
        );

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: color,
          shape: border.copyWith(
            side: BorderSide.none,
          ),
          shadows: shadows,
        ),
        foregroundDecoration: ShapeDecoration(
          shape: border,
        ),
        child: child,
      );

  ShapedBox copyWith({
    BorderSide? borderSide,
    Widget? child,
  }) =>
      ShapedBox._(
        color: color,
        border: border.copyWith(side: borderSide),
        shadows: shadows,
        child: child ?? this.child,
      );
}
