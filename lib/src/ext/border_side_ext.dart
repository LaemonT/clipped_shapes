import 'package:flutter/widgets.dart';

extension OutlinedBorderExt on OutlinedBorder {
  OutlinedBorder evaluate({
    Color? color,
    double? width,
    BorderStyle? style,
  }) {
    final borderColor = color ?? const Color(0x00000000);
    final borderWidth = width ?? 2.0;
    final borderStyle = style ?? BorderStyle.none;

    return copyWith(
      side: (borderColor.opacity > 0.0 && borderWidth > 0.0 && borderStyle == BorderStyle.solid)
          ? BorderSide(
              color: borderColor,
              width: borderWidth,
              style: borderStyle,
            )
          : BorderSide.none,
    );
  }
}
