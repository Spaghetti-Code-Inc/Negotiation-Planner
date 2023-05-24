import 'dart:math';
import 'package:flutter/material.dart';

import 'NegotiationDetails.dart';

/// These two functions display the info buttons on the rubric page in my negotiations
Future<void> showInfoRubric(context, String name, Map<String, int> values) {
  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text(name),
          content: info_content_rubric(name: name, values: values),
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
class info_content_rubric extends StatelessWidget {
  String name;
  Map<String, int> values;

  info_content_rubric({Key? key, required this.name, required this.values}) : super(key: key);

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


/// These two functions display the issue info buttons for the issue slider on track progress page
Future<void> showInfoTrackProgress(context, String name, double value, Negotiation negotiation){
  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text(name),
          content: info_content_track_progress(name: name, value: value, negotiation: negotiation),
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
class info_content_track_progress extends StatelessWidget{

  String name;
  double value;
  Negotiation negotiation;

  info_content_track_progress({required this.name, required this.value, required this.negotiation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Column(
        children: [
          Text("This is the current value of the issue $name: ${value.truncate()}\n"),
          Text("This the letter grade for this is: TODOTODOTODO"),
          Text("The weight of this issue for the user is a;dsfja, and for the cp: asd;jfa")
        ],
      ),
    );
  }

}

/// These two functions display the issue info buttons for the total value sliders on track progress page
Future<void> showTotalInfoTrackProgress(context, double userValue, double cpValue, Negotiation negotiation){
  return showDialog(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(
          title: Text("Total Value Info"),
          content: info_content_total_track_progress(userValue: userValue, cpValue: cpValue, negotiation: negotiation,),
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
class info_content_total_track_progress extends StatelessWidget{

  double userValue;
  double cpValue;
  Negotiation negotiation;

  info_content_total_track_progress({required this.userValue, required this.cpValue, required this.negotiation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Text("This is your total value on the negotiation: ${(userValue*100).truncate()}"),
          Text("This is your counterparts total value on the negotiation: ${(cpValue*100).truncate()}"),
        ],
      ),
    );
  }


}