import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String? title;
  final Widget body;

  const CustomScaffold({
    Key? key,
    this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: title != null ? Text(title!) : null,
        ),
        backgroundColor: Colors.grey.shade200,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: body,
              ),
            ),
          ),
        ),
      );
}
