import 'package:clipped_shapes/src/ext/color_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'shaped_box.dart';
import 'style/shape_styles.dart';

class ShapedButton extends StatelessWidget {
  final ShapedButtonStyle? buttonStyle;
  final ShapedBox _shapedBox;

  ShapedButton.rounded({
    super.key,
    BorderRadius? borderRadius,
    BorderSide borderSide = BorderSide.none,
    RoundedCornerStyle cornerStyle = RoundedCornerStyle.circular,
    required Widget child,
    this.buttonStyle,
  }) : _shapedBox = ShapedBox.rounded(
          borderRadius: borderRadius,
          borderSide: borderSide,
          cornerStyle: cornerStyle,
          child: child,
        );

  ShapedButton.stadium({
    super.key,
    BorderSide borderSide = BorderSide.none,
    required Widget child,
    this.buttonStyle,
  }) : _shapedBox = ShapedBox.stadium(
          borderSide: borderSide,
          child: child,
        );

  ShapedButton.oval({
    super.key,
    BorderSide borderSide = BorderSide.none,
    required Widget child,
    this.buttonStyle,
  }) : _shapedBox = ShapedBox.oval(
          borderSide: borderSide,
          child: child,
        );

  ShapedButton.circle({
    super.key,
    required double size,
    BorderSide borderSide = BorderSide.none,
    required Widget child,
    this.buttonStyle,
  }) : _shapedBox = ShapedBox.circle(
          size: size,
          borderSide: borderSide,
          child: child,
        );

  ShapedButton.bubble({
    super.key,
    ShapeDirection direction = ShapeDirection.up,
    double? arrowWidth,
    double? arrowHeight,
    double? arrowOffset,
    BorderRadius? borderRadius,
    BorderSide borderSide = BorderSide.none,
    required Widget child,
    this.buttonStyle,
  }) : _shapedBox = ShapedBox.bubble(
          direction: direction,
          arrowWidth: arrowWidth,
          arrowHeight: arrowHeight,
          arrowOffset: arrowOffset,
          borderRadius: borderRadius,
          borderSide: borderSide,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    final buttonStyle = this.buttonStyle ?? ShapedPlatformButtonStyle();

    final Widget shapedButton;
    List<BoxShadow>? shadows;

    switch (buttonStyle) {
      case ShapedCupertinoButtonStyle():
        shapedButton = _buildCupertinoStyleButton(style: buttonStyle);
      case ShapedMaterialButtonStyle():
        shapedButton = _buildMaterialStyleButton(style: buttonStyle);
        shadows = buttonStyle.shadows;
      case ShapedCustomButtonStyle():
        shapedButton = _buildCustomStyleButton(style: buttonStyle);
        shadows = buttonStyle.shadows;
      case ShapedPlatformButtonStyle():
        switch (defaultTargetPlatform) {
          case TargetPlatform.iOS:
          case TargetPlatform.macOS:
            shapedButton = _buildCupertinoStyleButton(
              style: ShapedCupertinoButtonStyle(
                color: buttonStyle.color,
                onPressed: buttonStyle.onPressed,
              ),
            );
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
            shapedButton = _buildMaterialStyleButton(
              style: ShapedMaterialButtonStyle(
                color: buttonStyle.color,
                highlightedColor: buttonStyle.highlightedColor,
                pressedColor: buttonStyle.pressedColor,
                onPressed: buttonStyle.onPressed,
                onLongPressed: buttonStyle.onLongPressed,
              ),
            );
          default:
            shapedButton = _buildCustomStyleButton(
              style: ShapedCustomButtonStyle(
                color: buttonStyle.color,
                onPressed: buttonStyle.onPressed,
              ),
            );
        }
        shadows = buttonStyle.shadows;
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: _shapedBox.border.copyWith(
          side: BorderSide.none,
        ),
        shadows: shadows,
      ),
      child: shapedButton,
    );
  }

  Widget _buildCupertinoStyleButton({
    required ShapedCupertinoButtonStyle style,
  }) =>
      CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        color: style.color,
        onPressed: style.onPressed,
        child: _shapedBox,
      );

  Widget _buildMaterialStyleButton({
    required ShapedMaterialButtonStyle style,
  }) =>
      MaterialButton(
        padding: EdgeInsets.zero,
        color: style.color,
        splashColor: style.pressedColor,
        highlightColor: style.highlightedColor,
        onPressed: style.onPressed,
        onLongPress: style.onLongPressed,
        child: _shapedBox,
      );

  Widget _buildCustomStyleButton({
    required ShapedCustomButtonStyle style,
  }) {
    final colorNormal = style.color;
    final colorHighlighted = style.highlightedColor ?? colorNormal?.lighten() ?? Colors.white10;
    final colorPressed = style.pressedColor ?? colorNormal?.darken() ?? Colors.black12;

    final colorNormalBorder = _shapedBox.border.side.color;
    final colorHighlightedBorder = style.highlightedBorderColor ?? colorNormalBorder.lighten();
    final colorPressedBorder = style.pressedBorderColor ?? colorNormalBorder.darken();

    final onColorChange = ValueNotifier((colorNormal, colorNormalBorder));

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        onColorChange.value = (colorPressed, colorPressedBorder);
      },
      onTapUp: (_) {
        onColorChange.value = (colorNormal, colorNormalBorder);
      },
      onTapCancel: () {
        onColorChange.value = (colorNormal, colorNormalBorder);
      },
      onTap: style.onPressed,
      onLongPress: style.onLongPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) {
          onColorChange.value = (colorHighlighted, colorHighlightedBorder);
        },
        onExit: (_) {
          onColorChange.value = (colorNormal, colorNormalBorder);
        },
        child: ValueListenableBuilder(
          valueListenable: onColorChange,
          builder: (BuildContext context, (Color?, Color) value, Widget? child) => AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            color: value.$1,
            child: _shapedBox.copyWith(
              borderSide: _shapedBox.border.side.copyWith(
                color: value.$2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
