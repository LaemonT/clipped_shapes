import 'package:example/screen/box.dart';
import 'package:example/screen/custom.dart';
import 'package:flutter/material.dart';

import 'custom/custom_scaffold.dart';
import 'screen/cupertino.dart';
import 'screen/material.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DemoScreenState();
}

class DemoScreenState extends State<DemoScreen> {
  Divider get _separator => const Divider(color: Colors.transparent);

  @override
  Widget build(BuildContext context) => CustomScaffold(
        title: 'Clipped Shapes Demo',
        body: Column(
          children: [
            _separator,
            _buildButton(
              title: 'ShapedBox',
              widget: const BoxScreen(),
            ),
            _separator,
            _separator,
            const Text('// ShapedButton'),
            _separator,
            _buildButton(
              title: 'Cupertino Style',
              widget: const CupertinoScreen(),
            ),
            _separator,
            _buildButton(
              title: 'Material Style',
              widget: const MaterialScreen(),
            ),
            _separator,
            _buildButton(
              title: 'Custom Style',
              widget: const CustomScreen(),
            ),
            _separator,
          ],
        ),
      );

  Widget _buildButton({
    required String title,
    required Widget widget,
  }) =>
      ElevatedButton(
        child: Text(title),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => widget,
            ),
          );
        },
      );
}
