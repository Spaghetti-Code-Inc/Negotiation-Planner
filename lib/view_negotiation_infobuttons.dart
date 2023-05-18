import 'dart:math';
import 'package:flutter/material.dart';

Future<void> showMyDialog(context, String name, Map<String, int> values) {
  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text(name),
          content: info_content(name: name, values: values),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
  );
}

class info_content extends StatelessWidget {
  String name;
  Map<String, int> values;

  info_content({Key? key, required this.name, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    num bargainingRange = values["cpResistance"]!-values["resistance"]!;

    return Container(
      height: 171,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("This graph shows the rubric for the $name. \n"),
          Text("Your Target is: ${values["target"]}"),
          Text("Your Resistance is: ${values["resistance"]}"),
          Text("Your Counterparts Target is: ${values["cpTarget"]}"),
          Text("Your Counterparts Resistance is: ${values["cpResistance"]} \n"),
          Text("Your Bargaining Range is: ${max(bargainingRange, 0)}")
        ]
      ),
    );
  }
}

