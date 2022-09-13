import 'package:flutter/material.dart';

import 'border/bubble_border.dart';
import 'border/oval_border.dart';
import 'clipper/custom_shape_clipper.dart';
import 'style/shape_styles.dart';

class ShapedBox extends StatelessWidget {
  final OutlinedBorder border;
  final List<BoxShadow>? shadows;
  final Widget? child;

  ShapedBox.rounded({
    Key? key,
    BorderRadius? radius,
    BorderSide? borderSide,
    RoundedCornerStyle cornerStyle = RoundedCornerStyle.circular,
    this.shadows,
    required this.child,
  })  : border = cornerStyle == RoundedCornerStyle.circular
            ? RoundedRectangleBorder(
                side: _makeBorderSide(
                  color: borderSide?.color,
                  width: borderSide?.width,
                  style: borderSide?.style,
                ),
                borderRadius: radius ?? BorderRadius.circular(8.0),
              )
            : ContinuousRectangleBorder(
                side: _makeBorderSide(
                  color: borderSide?.color,
                  width: borderSide?.width,
                  style: borderSide?.style,
                ),
                borderRadius: radius ?? BorderRadius.circular(8.0),
              ),
        super(key: key);

  ShapedBox.stadium({
    Key? key,
    BorderSide? borderSide,
    this.shadows,
    required this.child,
  })  : border = StadiumBorder(
          side: _makeBorderSide(
            color: borderSide?.color,
            width: borderSide?.width,
            style: borderSide?.style,
          ),
        ),
        super(key: key);

  ShapedBox.oval({
    Key? key,
    BorderSide? borderSide,
    this.shadows,
    required this.child,
  })  : border = OvalBorder(
          side: _makeBorderSide(
            color: borderSide?.color,
            width: borderSide?.width,
            style: borderSide?.style,
          ),
        ),
        super(key: key);

  ShapedBox.circle({
    Key? key,
    BorderSide? borderSide,
    this.shadows,
    required this.child,
  })  : border = CircleBorder(
          side: _makeBorderSide(
            color: borderSide?.color,
            width: borderSide?.width,
            style: borderSide?.style,
          ),
        ),
        super(key: key);

  ShapedBox.bubble({
    Key? key,
    ShapeDirection direction = ShapeDirection.up,
    double? arrowWidth,
    double? arrowHeight,
    double? arrowOffset,
    BorderRadius? radius,
    BorderSide? borderSide,
    this.shadows,
    required this.child,
  })  : border = BubbleBorder(
          direction: direction,
          arrowWidth: arrowWidth,
          arrowHeight: arrowHeight,
          arrowOffset: arrowOffset,
          side: _makeBorderSide(
            color: borderSide?.color,
            width: borderSide?.width,
            style: borderSide?.style,
          ),
          borderRadius: radius,
        ),
        super(key: key);

  static BorderSide _makeBorderSide({
    Color? color,
    double? width,
    BorderStyle? style,
  }) {
    final borderColor = color ?? Colors.black;
    final borderWidth = width ?? 2.0;
    final borderStyle = style ?? BorderStyle.none;

    return (borderColor.opacity > 0.0 && borderWidth > 0.0 && borderStyle == BorderStyle.solid)
        ? BorderSide(
            color: borderColor,
            width: borderWidth,
            style: borderStyle,
          )
        : BorderSide.none;
  }

  @override
  Widget build(BuildContext context) =>
      // Use the Center widget to wrap content, otherwise it expands to fill parent
      Center(
        child: Container(
          // Draw shadow
          decoration: ShapeDecoration(
            shape: border.copyWith(
              side: BorderSide.none,
            ),
            shadows: shadows,
          ),
          // Draw border
          foregroundDecoration: ShapeDecoration(
            shape: border,
          ),
          child: ClipPath(
            clipper: CustomShapeClipper(border: border),
            clipBehavior: Clip.antiAlias,
            child: child,
          ),
        ),
      );
}
