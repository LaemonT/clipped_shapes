import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'clipper/custom_shape_clipper.dart';
import 'shaped_box.dart';
import 'style/shape_styles.dart';

class ShapedButton extends StatelessWidget {
  final ShapedButtonStyle? shapeStyle;
  final ShapedBox shapedBox;
  final Color? feedbackColor; // No effect in cupertino style, and always shown with translucent.
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  final _onTapDown = ValueNotifier(false); // This is only used by cupertino style button

  Color get resolvedFeedbackColor {
    final color = (feedbackColor ?? Colors.white70);
    return color.withOpacity(color.opacity * 0.5);
  }

  bool get enabled => onPressed != null;

  ShapedButton.rounded({
    Key? key,
    BorderRadius? radius,
    BorderSide? borderSide,
    RoundedCornerStyle cornerStyle = RoundedCornerStyle.circular,
    List<BoxShadow>? shadows,
    required Widget child,
    this.shapeStyle,
    this.feedbackColor,
    required this.onPressed,
    this.onLongPressed,
  })  : shapedBox = ShapedBox.rounded(
          radius: radius,
          borderSide: borderSide,
          cornerStyle: cornerStyle,
          shadows: shadows,
          child: child,
        ),
        super(key: key);

  ShapedButton.stadium({
    Key? key,
    BorderSide? borderSide,
    List<BoxShadow>? shadows,
    required Widget child,
    this.shapeStyle,
    this.feedbackColor,
    required this.onPressed,
    this.onLongPressed,
  })  : shapedBox = ShapedBox.stadium(
          borderSide: borderSide,
          shadows: shadows,
          child: child,
        ),
        super(key: key);

  ShapedButton.oval({
    Key? key,
    BorderSide? borderSide,
    List<BoxShadow>? shadows,
    required Widget child,
    this.shapeStyle,
    this.feedbackColor,
    required this.onPressed,
    this.onLongPressed,
  })  : shapedBox = ShapedBox.oval(
          borderSide: borderSide,
          shadows: shadows,
          child: child,
        ),
        super(key: key);

  ShapedButton.circle({
    Key? key,
    BorderSide? borderSide,
    List<BoxShadow>? shadows,
    required Widget child,
    this.shapeStyle,
    this.feedbackColor,
    required this.onPressed,
    this.onLongPressed,
  })  : shapedBox = ShapedBox.circle(
          borderSide: borderSide,
          shadows: shadows,
          child: child,
        ),
        super(key: key);

  ShapedButton.bubble({
    Key? key,
    ShapeDirection direction = ShapeDirection.up,
    double? arrowWidth,
    double? arrowHeight,
    double? arrowOffset,
    BorderRadius? radius,
    BorderSide? borderSide,
    List<BoxShadow>? shadows,
    required Widget child,
    this.shapeStyle,
    this.feedbackColor,
    required this.onPressed,
    this.onLongPressed,
  })  : shapedBox = ShapedBox.bubble(
          direction: direction,
          arrowWidth: arrowWidth,
          arrowHeight: arrowHeight,
          arrowOffset: arrowOffset,
          radius: radius,
          borderSide: borderSide,
          shadows: shadows,
          child: child,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _onTapDown,
        builder: (BuildContext context, bool tapDown, Widget? child) => _buildButton(context, child),
        child: shapedBox,
      );

  Widget _buildButton(
    BuildContext context,
    Widget? child,
  ) {
    switch (shapeStyle ?? ShapedButtonStyle.platform) {
      case ShapedButtonStyle.platform:
        switch (defaultTargetPlatform) {
          case TargetPlatform.iOS:
          case TargetPlatform.macOS:
            return _buildCupertinoStyleButton(context, child);
          default:
            return _buildMaterialStyleButton(context, child);
        }

      /// Button with Material style has a splash circle on touch and expand to fill available space
      case ShapedButtonStyle.material:
        return _buildMaterialStyleButton(context, child);

      /// Button with Cupertino style will reduce its opacity on touch
      case ShapedButtonStyle.cupertino:
        return _buildCupertinoStyleButton(context, child);

      /// Button with Custom style draws the feedback color on top of the child
      case ShapedButtonStyle.custom:
        return _buildCustomStyleButton(context, child);
    }
  }

  Widget _buildMaterialStyleButton(
    BuildContext context,
    Widget? child,
  ) =>
      Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          if (child != null) child,
          // Draw splash above the child, so it does not covered by the child's background
          Positioned.fill(
            child: ClipPath(
              clipper: CustomShapeClipper(border: shapedBox.border),
              clipBehavior: Clip.antiAlias,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: resolvedFeedbackColor,
                  highlightColor: resolvedFeedbackColor.withOpacity(0.2),
                  onTap: onPressed,
                  onLongPress: onLongPressed,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildCupertinoStyleButton(
    BuildContext context,
    Widget? child,
  ) =>
      ClipPath(
        clipper: CustomShapeClipper(border: shapedBox.border),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: enabled
              ? (_) {
                  _onTapDown.value = true;
                }
              : null,
          onTapUp: enabled
              ? (_) {
                  _onTapDown.value = false;
                }
              : null,
          onTapCancel: enabled
              ? () {
                  _onTapDown.value = false;
                }
              : null,
          onTap: onPressed,
          onLongPress: onLongPressed,
          child: ValueListenableBuilder(
            valueListenable: _onTapDown,
            builder: (BuildContext context, bool tapDown, Widget? child) => AnimatedOpacity(
              opacity: tapDown ? 0.5 : 1.0,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              child: child,
            ),
            child: Container(
              // Add this to fix that when using Spacer() in child, the occupied space is not clickable
              color: Colors.transparent,
              child: child,
            ),
          ),
        ),
      );

  Widget _buildCustomStyleButton(
    BuildContext context,
    Widget? child,
  ) =>
      Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          if (child != null) child,
          // Draw the feedback color above the child
          Positioned.fill(
            child: ClipPath(
              clipper: CustomShapeClipper(border: shapedBox.border),
              clipBehavior: Clip.antiAlias,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: resolvedFeedbackColor,
                  onTap: onPressed,
                  onLongPress: onLongPressed,
                ),
              ),
            ),
          ),
        ],
      );
}
