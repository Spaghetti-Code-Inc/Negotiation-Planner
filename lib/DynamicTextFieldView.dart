import 'package:flutter/material.dart';

class DynamicTextFieldView extends StatelessWidget {
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

class _View1 extends StatefulWidget {
  @override
  _View1State createState() => _View1State();
}
