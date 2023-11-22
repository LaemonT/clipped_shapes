import 'package:flutter/painting.dart';

sealed class ShapedButtonStyle {
  final Color? color;
  final VoidCallback? onPressed;

  ShapedButtonStyle({
    this.color,
    this.onPressed,
  });
}

class ShapedCupertinoButtonStyle extends ShapedButtonStyle {
  ShapedCupertinoButtonStyle({
    super.color,
    super.onPressed,
  });
}

class ShapedMaterialButtonStyle extends ShapedButtonStyle {
  final Color? highlightedColor;
  final Color? pressedColor;
  final List<BoxShadow>? shadows;
  final VoidCallback? onLongPressed;

  ShapedMaterialButtonStyle({
    super.color,
    this.highlightedColor,
    this.pressedColor,
    this.shadows,
    super.onPressed,
    this.onLongPressed,
  });
}

class ShapedCustomButtonStyle extends ShapedButtonStyle {
  final Color? highlightedColor;
  final Color? pressedColor;
  final Color? highlightedBorderColor;
  final Color? pressedBorderColor;
  final Color? childOverwriteColor;
  final Color? childOverwriteHighlightedColor;
  final Color? childOverwritePressedColor;
  final List<BoxShadow>? shadows;
  final VoidCallback? onLongPressed;

  ShapedCustomButtonStyle({
    super.color,
    this.highlightedColor,
    this.pressedColor,
    this.highlightedBorderColor,
    this.pressedBorderColor,
    this.childOverwriteColor,
    this.childOverwriteHighlightedColor,
    this.childOverwritePressedColor,
    this.shadows,
    super.onPressed,
    this.onLongPressed,
  });
}

class ShapedPlatformButtonStyle extends ShapedButtonStyle {
  final Color? highlightedColor;
  final Color? pressedColor;
  final List<BoxShadow>? shadows;
  final VoidCallback? onLongPressed;

  ShapedPlatformButtonStyle({
    super.color,
    this.highlightedColor,
    this.pressedColor,
    this.shadows,
    super.onPressed,
    this.onLongPressed,
  });
}

enum RoundedCornerStyle {
  circular, // Quarter-circle: one fourth of pi (𝛑)
  continuous, // Smooth continuous transitions: https://en.wikipedia.org/wiki/Squircle
}

enum ShapeDirection {
  up,
  down,
  left,
  right,
}
