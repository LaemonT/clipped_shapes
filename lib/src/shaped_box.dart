import 'package:clipped_shapes/src/ext/border_side_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'border/bubble_border.dart';
import 'style/shape_styles.dart';

class ShapedBox extends StatelessWidget {
  final Color? color;
  final OutlinedBorder border;
  final BorderSide? borderSide;
  final List<BoxShadow>? shadows;
  final Widget? child;

  ShapedBox.rounded({
    super.key,
    this.color,
    BorderRadius? borderRadius,
    this.borderSide,
    RoundedCornerStyle cornerStyle = RoundedCornerStyle.circular,
    this.shadows,
    this.child,
  }) : border = cornerStyle == RoundedCornerStyle.circular
            ? RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              )
            : ContinuousRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              );

  const ShapedBox.stadium({
    super.key,
    this.color,
    this.borderSide,
    this.shadows,
    this.child,
  }) : border = const StadiumBorder();

  const ShapedBox.oval({
    super.key,
    this.color,
    this.borderSide,
    this.shadows,
    this.child,
  }) : border = const OvalBorder();

  ShapedBox.circle({
    super.key,
    required double size,
    this.color,
    this.borderSide,
    this.shadows,
    Widget? child,
  })  : border = const CircleBorder(),
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
    this.borderSide,
    this.shadows,
    this.child,
  }) : border = BubbleBorder(
          direction: direction,
          arrowWidth: arrowWidth,
          arrowHeight: arrowHeight,
          arrowOffset: arrowOffset,
          borderRadius: borderRadius,
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
          shape: border.evaluate(
            color: borderSide?.color,
            width: borderSide?.width,
            style: borderSide?.style,
          ),
        ),
        child: child,
      );
}
