import 'package:clipped_shapes/clipped_shapes.dart';
import 'package:flutter/material.dart';

import '../custom/custom_scaffold.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  BorderSide get _borderSide => const BorderSide(
        color: Colors.indigo,
        width: 5,
      );

  ShapedButtonStyle get _buttonStyle => ShapedMaterialButtonStyle(
        color: Colors.redAccent,
        shadows: [
          const BoxShadow(
            color: Colors.grey,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        onPressed: () {},
      );

  @override
  Widget build(BuildContext context) => CustomScaffold(
        title: 'Material ShapedButton',
        body: Wrap(
          alignment: WrapAlignment.center,
          spacing: 24.0,
          runSpacing: 24.0,
          children: [
            ShapedButton.rounded(
              buttonStyle: _buttonStyle,
              borderSide: _borderSide,
              child: _buildContent(text: 'ShapedButton.rounded\nExample'),
            ),
            ShapedButton.stadium(
              buttonStyle: _buttonStyle,
              borderSide: _borderSide,
              child: _buildContent(text: 'ShapedButton.stadium\nExample'),
            ),
            ShapedButton.oval(
              buttonStyle: _buttonStyle,
              borderSide: _borderSide,
              child: _buildContent(text: 'ShapedButton.oval\nExample'),
            ),
            ShapedButton.circle(
              size: 80,
              buttonStyle: _buttonStyle,
              borderSide: _borderSide,
              child: _buildContent(text: 'ShapedButton.circle\nExample'),
            ),
            ShapedButton.bubble(
              buttonStyle: _buttonStyle,
              borderSide: _borderSide,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildContent(text: 'ShapedButton.bubble\nExample'),
              ),
            ),
          ],
        ),
      );

  Widget _buildContent({
    required String text,
    Color textColor = Colors.white,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.center,
        ),
      );
}
