import 'package:clipped_shapes/clipped_shapes.dart';
import 'package:flutter/material.dart';

import '../custom/custom_scaffold.dart';

class CustomScreen extends StatelessWidget {
  BorderSide get _borderSide => const BorderSide(
        color: Colors.indigo,
        width: 3,
      );

  List<BoxShadow> get _shadows => const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ];

  const CustomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScaffold(
        title: 'Custom ShapedButton',
        body: Wrap(
          alignment: WrapAlignment.center,
          spacing: 24.0,
          runSpacing: 24.0,
          children: [
            ShapedButton.rounded(
              shapeStyle: ShapedButtonStyle.custom,
              borderSide: _borderSide,
              shadows: _shadows,
              onPressed: () {},
              child: _buildContent(text: 'ShapedButton.rounded\nExample'),
            ),
            ShapedButton.stadium(
              shapeStyle: ShapedButtonStyle.custom,
              borderSide: _borderSide,
              shadows: _shadows,
              onPressed: () {},
              child: _buildContent(text: 'ShapedButton.stadium\nExample'),
            ),
            ShapedButton.oval(
              shapeStyle: ShapedButtonStyle.custom,
              borderSide: _borderSide,
              shadows: _shadows,
              onPressed: () {},
              child: _buildContent(text: 'ShapedButton.oval\nExample'),
            ),
            ShapedButton.circle(
              shapeStyle: ShapedButtonStyle.custom,
              borderSide: _borderSide,
              shadows: _shadows,
              onPressed: () {},
              child: _buildContent(text: 'ShapedButton.circle\nExample'),
            ),
            ShapedButton.bubble(
              shapeStyle: ShapedButtonStyle.custom,
              borderSide: _borderSide,
              shadows: _shadows,
              onPressed: () {},
              child: _buildContent(text: 'ShapedButton.bubble\nExample'),
            ),
          ],
        ),
      );

  Widget _buildContent({
    required String text,
    Color color = Colors.orange,
    Color textColor = Colors.white,
  }) =>
      Container(
        color: color,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.center,
        ),
      );
}
