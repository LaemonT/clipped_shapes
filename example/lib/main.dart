import 'package:flutter/material.dart';

import 'demo_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Clipped Shapes Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const DemoScreen(),
      );
}
