import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

import 'NegotiationDetails.dart';
import 'ViewNegotiation.dart';

class ViewCurrentIssues extends StatefulWidget {
  final String issueName;
  final Negotiation negotiation;
  ViewCurrentIssues({Key? key, required this.issueName, required this.negotiation})
      : super(key: key);

  @override
  State<ViewCurrentIssues> createState() => _ViewCurrentIssuesState();
}

class _ViewCurrentIssuesState extends State<ViewCurrentIssues> {

  late Negotiation negotiation = widget.negotiation;

  late double userRes = double.parse(
      negotiation.issues[widget.issueName]["D"]);
  late double userTar = double.parse(
      negotiation.issues[widget.issueName]["A"]);

  late double cpRes = negotiation.cpResistance*1.0;
  late double cpTar = negotiation.cpTarget * 1.0;

  late double userWeight = 100/int.parse(negotiation.issues[widget.issueName]["relativeValue"]);
  late double cpWeight = negotiation.cpIssues[widget.issueName]! / 100;

  late List<double> _issueVals = [
    0,
    userRes / 100 * userWeight,
    cpTar / 100,
    userTar / 100 * userWeight,
    cpRes / 100,
    100
  ];

  late String _bargainingRange = widget.issueName + ": " + (_issueVals[4]-_issueVals[1] > 0 ?
  ((_issueVals[1]-_issueVals[4])*100*(-1)).toInt().toString(): "0");

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

      Text(
        _bargainingRange,
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          color: Color(0xff000000),
        ),
      ),



    ]);
  }
}
