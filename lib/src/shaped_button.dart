import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'clipper/custom_shape_clipper.dart';
import 'shaped_box.dart';
import 'style/shape_styles.dart';

class ShapedButton extends StatelessWidget {
  final ShapedButtonStyle? shapeStyle;
  final Color? feedbackColor; // No effect in cupertino style, and always shown with translucent.
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  final ShapedBox _shapedBox;
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
  })  : _shapedBox = ShapedBox.rounded(
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
  })  : _shapedBox = ShapedBox.stadium(
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
  })  : _shapedBox = ShapedBox.oval(
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
  })  : _shapedBox = ShapedBox.circle(
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
  })  : _shapedBox = ShapedBox.bubble(
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
  Widget build(BuildContext context) {
    switch (shapeStyle ?? ShapedButtonStyle.platform) {
      case ShapedButtonStyle.platform:
        switch (defaultTargetPlatform) {
          case TargetPlatform.iOS:
          case TargetPlatform.macOS:
            return _buildCupertinoStyleButton(context);
          default:
            return _buildMaterialStyleButton(context);
        }

      /// Button with Cupertino style will reduce its opacity on touch
      case ShapedButtonStyle.cupertino:
        return _buildCupertinoStyleButton(context);

      /// Button with Material style has a splash circle on touch and expand to fill available space
      case ShapedButtonStyle.material:
        return _buildMaterialStyleButton(context);

      /// Button with Custom style draws the feedback color on top of the child
      case ShapedButtonStyle.custom:
        return _buildCustomStyleButton(context);
    }
  }

  Widget _buildCupertinoStyleButton(BuildContext context) => _shapedBox.shadows != null
      ? ValueListenableBuilder(
          valueListenable: _onTapDown,
          builder: (BuildContext context, bool tapDown, Widget? child) => Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: tapDown ? 0.0 : 1.0,
                  curve: Curves.ease,
                  child: _buildShadow(null),
                ),
              ),
              Container(
                child: child,
              ),
            ],
          ),
          child: _buildCupertinoButton(context),
        )
      : _buildCupertinoButton(context);

  Widget _buildCupertinoButton(BuildContext context) => GestureDetector(
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
            duration: const Duration(milliseconds: 300),
            opacity: tapDown ? 0.5 : 1.0,
            curve: Curves.ease,
            child: child,
          ),
          child: Container(
            // Add this to fix that when using Spacer() in child, the occupied space is not clickable
            color: Colors.transparent,
            child: _buildClipped(_shapedBox.child),
          ),
        ),
      );

  Widget _buildMaterialStyleButton(BuildContext context) => _shapedBox.shadows != null
      ? _buildShadow(
          _buildMaterialButton(context),
        )
      : _buildMaterialButton(context);

  Widget _buildMaterialButton(BuildContext context) => Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          _buildClipped(_shapedBox.child),
          // Draw splash above the child, so it does not covered by the child's background
          Positioned.fill(
            child: ClipPath(
              clipper: CustomShapeClipper(border: _shapedBox.border),
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

  Widget _buildCustomStyleButton(BuildContext context) => _shapedBox.shadows != null
      ? _buildShadow(
          _buildCustomButton(context),
        )
      : _buildCustomButton(context);

  Widget _buildCustomButton(BuildContext context) => Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          _buildClipped(_shapedBox.child),
          // Draw the feedback color above the child
          Positioned.fill(
            child: ClipPath(
              clipper: CustomShapeClipper(border: _shapedBox.border),
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

  Widget _buildShadow(Widget? child) => DecoratedBox(
        decoration: ShapeDecoration(
          shape: _shapedBox.border.copyWith(
            side: BorderSide.none,
          ),
          shadows: _shapedBox.shadows,
        ),
        child: child,
      );

  Widget _buildClipped(Widget? child) => ClipPath(
        clipper: CustomShapeClipper(border: _shapedBox.border),
        clipBehavior: Clip.antiAlias,
        child: DecoratedBox(
          // Draw border
          decoration: ShapeDecoration(
            shape: _shapedBox.border,
          ),
          position: DecorationPosition.foreground,
          child: child,
        ),
      );
}
