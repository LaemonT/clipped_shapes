import 'dart:async';

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
    this.buttonStyle,
    required Widget child,
  }) : _shapedBox = ShapedBox.rounded(
          borderRadius: borderRadius,
          borderSide: borderSide,
          cornerStyle: cornerStyle,
          child: child,
        );

  ShapedButton.stadium({
    super.key,
    BorderSide borderSide = BorderSide.none,
    this.buttonStyle,
    required Widget child,
  }) : _shapedBox = ShapedBox.stadium(
          borderSide: borderSide,
          child: child,
        );

  ShapedButton.oval({
    super.key,
    BorderSide borderSide = BorderSide.none,
    this.buttonStyle,
    required Widget child,
  }) : _shapedBox = ShapedBox.oval(
          borderSide: borderSide,
          child: child,
        );

  ShapedButton.circle({
    super.key,
    required double size,
    BorderSide borderSide = BorderSide.none,
    this.buttonStyle,
    required Widget child,
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
    this.buttonStyle,
    required Widget child,
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
        highlightColor: style.highlightedColor ?? style.color?.lighten() ?? Colors.black12,
        splashColor: style.pressedColor ?? style.color?.darken() ?? Colors.black12,
        onPressed: style.onPressed,
        onLongPress: style.onLongPressed,
        child: _shapedBox,
      );

  Widget _buildCustomStyleButton({
    required ShapedCustomButtonStyle style,
  }) {
    final normalColor = style.color;
    final highlightedColor = style.highlightedColor ?? normalColor?.lighten() ?? Colors.black.withOpacity(0.04);
    final pressedColor = style.pressedColor ?? normalColor?.darken() ?? Colors.black12;

    final borderNormalColor = _shapedBox.border.side.color;
    final borderHighlightedColor = style.highlightedBorderColor ?? borderNormalColor.lighten();
    final borderPressedColor = style.pressedBorderColor ?? borderNormalColor.darken();

    final childOverwriteNormalColor = style.childOverwriteColor;
    final childOverwriteHighlightedColor = style.childOverwriteHighlightedColor;
    final childOverwritePressedColor = style.childOverwritePressedColor;

    final onNormal = (normalColor, borderNormalColor, childOverwriteNormalColor);
    final onHovering = (highlightedColor, borderHighlightedColor, childOverwriteHighlightedColor);
    final onPressed = (pressedColor, borderPressedColor, childOverwritePressedColor);

    const animationDuration = Duration(milliseconds: 60);
    final onColorChange = ValueNotifier((normalColor, borderNormalColor, childOverwriteNormalColor));

    bool hovering = false;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        onColorChange.value = onPressed;
      },
      onTapUp: (_) {
        onColorChange.value = onHovering;
      },
      onTapCancel: () {
        onColorChange.value = hovering ? onHovering : onNormal;
      },
      onTap: () {
        // Applies the animation
        onColorChange.value = onPressed;
        Future.delayed(
          animationDuration,
          () {
            onColorChange.value = hovering ? onHovering : onNormal;
          },
        );
        // Execute the button action
        style.onPressed?.call();
      },
      onLongPress: style.onLongPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) {
          hovering = true;
          onColorChange.value = onHovering;
        },
        onExit: (_) {
          hovering = false;
          onColorChange.value = onNormal;
        },
        child: ValueListenableBuilder(
          valueListenable: onColorChange,
          builder: (BuildContext context, (Color?, Color, Color?) value, Widget? child) => AnimatedContainer(
            duration: animationDuration,
            color: value.$1,
            child: _buildResolvedChild(value.$2, value.$3),
          ),
        ),
      ),
    );
  }

  Widget _buildResolvedChild(
    Color borderColor,
    Color? childOverwriteColor,
  ) =>
      _shapedBox.copyWith(
        borderSide: _shapedBox.border.side.copyWith(
          color: borderColor,
        ),
        child: childOverwriteColor != null
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                  childOverwriteColor,
                  BlendMode.srcIn,
                ),
                child: _shapedBox.child,
              )
            : null,
      );
}
