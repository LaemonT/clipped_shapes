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

// class ExamplePage extends StatelessWidget {
//   final String title;
//
//   const ExamplePage({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: Text(title),
//     ),
//     body: SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//             ShapedBox.rounded(
//               radius: BorderRadius.circular(16.0),
//               borderSide: const BorderSide(
//                 color: Colors.black,
//                 width: 3,
//               ),
//               child: Container(
//                 color: Colors.pinkAccent,
//                 padding: const EdgeInsets.all(8.0),
//                 child: const Text(
//                   'ShapedBox.rounded\nExample',
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ShapedButton.rounded(
//               radius: BorderRadius.circular(16.0),
//               borderSide: const BorderSide(
//                 color: Colors.black,
//                 width: 3,
//               ),
//               shapeStyle: ShapedButtonStyle.material,
//               child: Container(
//                 color: Colors.pinkAccent,
//                 padding: const EdgeInsets.all(8.0),
//                 child: const Text(
//                   'ShapedButton.rounded\nExample',
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               onPressed: () {
//                 print('ShapedButton onPressed');
//               },
//             ),
//             const Divider(height: 40, thickness: 2, indent: 64, endIndent: 64),
//             ShapedBox.stadium(
//               child: Container(
//                 color: Colors.teal,
//                 padding: const EdgeInsets.all(8.0),
//                 child: const Text(
//                   'ShapedBox.stadium\nExample',
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ShapedButton.stadium(
//               shapeStyle: ShapedButtonStyle.material,
//               child: Container(
//                 color: Colors.teal,
//                 padding: const EdgeInsets.all(8.0),
//                 child: const Text(
//                   'ShapedButton.stadium\nExample',
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               onPressed: () {
//                 print('ShapedButton onPressed');
//               },
//             ),
//             const Divider(height: 40, thickness: 2, indent: 64, endIndent: 64),
//             ShapedBox.oval(
//               shadows: const [
//                 BoxShadow(
//                   offset: Offset(3, 3),
//                   blurRadius: 3,
//                 ),
//               ],
//               child: Container(
//                 color: Colors.indigo,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0,
//                   vertical: 16.0,
//                 ),
//                 child: const Text(
//                   'ShapedBox.oval\nExample',
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ShapedButton.oval(
//               // shapeStyle: ShapedButtonStyle.material,
//               shadows: const [
//                 BoxShadow(
//                   offset: Offset(3, 3),
//                   blurRadius: 3,
//                 ),
//               ],
//               child: Container(
//                 color: Colors.indigo,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0,
//                   vertical: 16.0,
//                 ),
//                 child: const Text(
//                   'ShapedButton.oval\nExample',
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               onPressed: () {
//                 print('ShapedButton onPressed');
//               },
//             ),
//             const Divider(height: 40, thickness: 2, indent: 64, endIndent: 64),
//             ShapedBox.bubble(
//               borderSide: const BorderSide(
//                 color: Colors.redAccent,
//                 width: 3,
//               ),
//               shadows: const [
//                 BoxShadow(
//                   offset: Offset(3, 3),
//                 ),
//               ],
//               child: Container(
//                 color: Colors.blue,
//                 padding: const EdgeInsets.all(8.0),
//                 child: const Padding(
//                   padding: EdgeInsets.only(bottom: 16),
//                   child: Text(
//                     'ShapedBox.bubble\nExample',
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ShapedButton.bubble(
//               borderSide: const BorderSide(
//                 color: Colors.redAccent,
//                 width: 3,
//               ),
//               shadows: const [
//                 BoxShadow(
//                   offset: Offset(3, 3),
//                 ),
//               ],
//               child: Container(
//                 color: Colors.blue,
//                 padding: const EdgeInsets.all(8.0),
//                 child: const Padding(
//                   padding: EdgeInsets.only(bottom: 16),
//                   child: Text(
//                     'ShapedButton.bubble\nExample',
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               onPressed: () {
//                 print('ShapedButton onPressed');
//               },
//             ),
//             const Divider(height: 40, thickness: 2, indent: 64, endIndent: 64),
//             ShapedBox.circle(
//               borderSide: const BorderSide(
//                 color: Colors.orange,
//                 width: 1.6,
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'ShapedBox.circle\nExample',
//                   style: TextStyle(color: Colors.orange),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ShapedButton.circle(
//               borderSide: const BorderSide(
//                 color: Colors.orange,
//                 width: 1.6,
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'ShapedBox.circle\nExample',
//                   style: TextStyle(color: Colors.orange),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               onPressed: () {
//                 print('ShapedButton onPressed');
//               },
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
