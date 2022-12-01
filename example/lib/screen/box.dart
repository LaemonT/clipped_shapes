import 'package:clipped_shapes/clipped_shapes.dart';
import 'package:flutter/material.dart';

import '../custom/custom_scaffold.dart';

class BoxScreen extends StatelessWidget {
  const BoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScaffold(
        title: 'ShapedBox',
        body: Wrap(
          children: [
            ShapedBox.rounded(
              child: _buildContent(text: 'ShapedBox.rounded\nExample'),
            ),
            ShapedBox.stadium(
              child: _buildContent(text: 'ShapedBox.stadium\nExample'),
            ),
            ShapedBox.oval(
              child: _buildContent(text: 'ShapedBox.oval\nExample'),
            ),
            ShapedBox.circle(
              child: _buildContent(text: 'ShapedBox.circle\nExample'),
            ),
            ShapedBox.bubble(
              child: _buildContent(text: 'ShapedBox.bubble\nExample'),
            ),
          ],
        ),
      );

  Widget _buildContent({
    required String text,
    Color color = Colors.blueAccent,
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
