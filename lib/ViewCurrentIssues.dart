import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

import 'ViewNegotiation.dart';
import 'main.dart';

class ViewCurrentIssues extends StatefulWidget {
  final String issueName;
  const ViewCurrentIssues({Key? key, required this.issueName})
      : super(key: key);

  @override
  State<ViewCurrentIssues> createState() => _ViewCurrentIssuesState();
}

class _ViewCurrentIssuesState extends State<ViewCurrentIssues> {
  late double userRes = double.parse(
      currentNegotiation.issues["issueNames"]![widget.issueName]["D"]);
  late double userTar = double.parse(
      currentNegotiation.issues["issueNames"]![widget.issueName]["A"]);

  late double cpRes = currentNegotiation.cpResistance*1.0;
  late double cpTar = currentNegotiation.cpTarget * 1.0;

  late double userWeight = 100/int.parse(currentNegotiation.issues["issueNames"]![widget.issueName]["relativeValue"]);
  late double cpWeight = currentNegotiation.cpIssues[widget.issueName]! / 100;

  late List<double> _issueVals = [
    0,
    userRes / 100 * userWeight,
    cpTar / 100,
    userTar / 100 * userWeight,
    cpRes / 100,
    100
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: MediaQuery.of(context).size.width * .8,
          child: MultiThumbSlider(
            initalSliderValues: _issueVals,
            valuesChanged: (List<double> values) {
              setState(() {
                _issueVals = values;
              });
            },

            overdragBehaviour: ThumbOverdragBehaviour.cross,
            // Locks all of the slider, must be changed to edit the slider
            lockBehaviour: ThumbLockBehaviour.start,
            thumbBuilder: (BuildContext context, int index, double value) {
              return WholeBargainSliders(index: index, value: value);
            },
            height: 70,
          ),
      ),

      Column(children: [
        Text("Bargaining Range on " + widget.issueName + ": " + (_issueVals[4]-_issueVals[1] > 0 ?
        ((_issueVals[1]-_issueVals[4])*100*(-1)).toInt().toString() : "0")),
      ]),

    ]);
  }
}
