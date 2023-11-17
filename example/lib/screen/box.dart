import 'package:clipped_shapes/clipped_shapes.dart';
import 'package:flutter/material.dart';

import '../custom/custom_scaffold.dart';

class BoxScreen extends StatelessWidget {
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

  const BoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScaffold(
        title: 'ShapedBox',
        body: Wrap(
          children: [
            ShapedBox.rounded(
              color: Colors.blueAccent,
              borderSide: _borderSide,
              shadows: _shadows,
              child: _buildContent(text: 'ShapedBox.rounded\nExample'),
            ),
            ShapedBox.stadium(
              color: Colors.blueAccent,
              borderSide: _borderSide,
              shadows: _shadows,
              child: _buildContent(text: 'ShapedBox.stadium\nExample'),
            ),
            ShapedBox.oval(
              color: Colors.blueAccent,
              borderSide: _borderSide,
              shadows: _shadows,
              child: _buildContent(text: 'ShapedBox.oval\nExample'),
            ),
            ShapedBox.circle(
              size: 80,
              color: Colors.blueAccent,
              borderSide: _borderSide,
              shadows: _shadows,
              child: Center(child: _buildContent(text: 'ShapedBox.circle\nExample')),
            ),
            ShapedBox.bubble(
              color: Colors.blueAccent,
              borderSide: _borderSide,
              shadows: _shadows,
              child: _buildContent(text: 'ShapedBox.bubble\nExample'),
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
