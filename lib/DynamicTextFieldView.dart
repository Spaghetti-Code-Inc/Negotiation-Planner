import 'package:flutter/material.dart';

class DynamicTextFieldView extends StatelessWidget {
  const DynamicTextFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: [
          _View1(),
          _View2(),
          _View3(),
          _View4(),
        ],
      ),
    );
  }
}