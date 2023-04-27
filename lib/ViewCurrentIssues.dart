import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';
import 'NegotiationDetails.dart';
import 'ViewNegotiation.dart';

class ViewCurrentIssues extends StatefulWidget {
  final String issueName;
  final Negotiation negotiation;
  final bool editing;

  ViewCurrentIssues(
      {Key? key,
      required this.issueName,
      required this.negotiation,
      required this.editing})
      : super(key: key);

  @override
  State<ViewCurrentIssues> createState() => _ViewCurrentIssuesState();
}

class _ViewCurrentIssuesState extends State<ViewCurrentIssues> {
  late Negotiation negotiation = widget.negotiation;

  late double userRes = double.parse(negotiation.issues[widget.issueName]["D"]);
  late double userTar = double.parse(negotiation.issues[widget.issueName]["A"]);

  late double cpRes = double.parse(
      negotiation.cpIssues[widget.issueName]["resistance"].toString());
  late double cpTar =
      double.parse(negotiation.cpIssues[widget.issueName]["target"].toString());

  late double usWeight =
      100 / double.parse(negotiation.issues[widget.issueName]["relativeValue"]);
  late double cpWeight =
      100 / negotiation.cpIssues[widget.issueName]["relativeValue"];

  late List<double> _issueVals = [
    0,
    userRes / 100,
    cpTar / 100,
    userTar / 100,
    cpRes / 100,
    100
  ];

  String bargainingRange() {
    return widget.issueName +
        ": " +
        (_issueVals[4] - _issueVals[1] > 0
            ? ((_issueVals[1] - _issueVals[4]) * 100 * (-1)).toInt().toString()
            : "0");
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.editing) {
      late Negotiation negotiation = widget.negotiation;

      late double userRes =
          double.parse(negotiation.issues[widget.issueName]["D"].toString());
      late double userTar =
          double.parse(negotiation.issues[widget.issueName]["A"].toString());

      late double cpRes = double.parse(
          negotiation.cpIssues[widget.issueName]["resistance"].toString());
      late double cpTar = double.parse(
          negotiation.cpIssues[widget.issueName]["target"].toString());

      _issueVals = [
        0,
        userRes / 100.0,
        cpTar / 100.0,
        userTar / 100.0,
        cpRes / 100.0,
        100
      ];
    }

    return Column(children: [
      Container(
        margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            bargainingRange(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
        width: MediaQuery.of(context).size.width * .8,
        child: MultiThumbSlider(
          initalSliderValues: _issueVals,
          valuesChanged: (List<double> values) {
            setState(() {
              _issueVals = values;
            });

            List<int> vals = EvenlyDistribute((_issueVals[3]*100).truncate(), (_issueVals[1]*100).truncate());

            widget.negotiation.issues[widget.issueName]["D"] = vals[0];
            widget.negotiation.issues[widget.issueName]["C"] = vals[1];
            widget.negotiation.issues[widget.issueName]["B"] = vals[2];
            widget.negotiation.issues[widget.issueName]["A"] = vals[3];


            widget.negotiation.cpIssues[widget.issueName]["resistance"] =
                (_issueVals[4] * 100).truncate();
            widget.negotiation.cpIssues[widget.issueName]["target"] =
                (_issueVals[2] * 100).truncate();
          },

          overdragBehaviour: ThumbOverdragBehaviour.cross,
          // Locks all of the slider, must be changed to edit the slider
          lockBehaviour: widget.editing
              ? ThumbLockBehaviour.end
              : ThumbLockBehaviour.start,
          thumbBuilder: (BuildContext context, int index, double value) {
            return WholeBargainSliders(index: index, value: value);
          },
          height: 70,
        ),
      ),
      ChangeRelativeValues(
          editing: widget.editing,
          issueName: widget.issueName,
          negotiation: widget.negotiation)
    ]);
  }

  List<int> EvenlyDistribute(int high, int low){

    int length = 3;
    List<int> vals = <int>[low, 0, 0, high];
    // Gets how much the pts should change by in each step
    int total = high-low;
    int step = (total/length).round();

    for(int i = 1; i < length; i++){
      vals[3-i] = (total-step*i) + low;
    }

    return vals;
  }
}

class ChangeRelativeValues extends StatelessWidget {
  final bool editing;
  final String issueName;
  final Negotiation negotiation;
  ChangeRelativeValues(
      {Key? key,
      required this.editing,
      required this.issueName,
      required this.negotiation})
      : super(key: key);

  TextEditingController userCtrl = TextEditingController();
  TextEditingController cpCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (!editing) {
      return Container();
    }

    userCtrl.text = negotiation.issues[issueName]["relativeValue"].toString();
    cpCtrl.text = negotiation.cpIssues[issueName]["relativeValue"].toString();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // Change Relative Value for the User
          Row(children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  "User Weight: ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // Sets slight area between points and issue column
            Container(
              width: 70,
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: TextFormField(
                onChanged: (newVal) {
                  negotiation.issues[issueName]["relativeValue"] =
                      userCtrl.text;
                },
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.next,
                cursorColor: Color(0xff0A0A5B),
                keyboardType: TextInputType.number,
                controller: userCtrl,
                decoration: InputDecoration(
                    contentPadding: EdgeInsetsDirectional.zero,
                    enabledBorder: (OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff0A0A5B)),
                      borderRadius: BorderRadius.circular(20),
                    )),
                    focusedBorder: (OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 3, color: Color(0xff0A0A5B))))),
              )),
            ),
          ]),
          Row(children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  "Counter Part Weight: ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // Sets slight area between points and issue column
            Container(
              width: 70,
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: TextFormField(
                onChanged: (newVal) {
                  negotiation.cpIssues[issueName]["relativeValue"] =
                      int.parse(cpCtrl.text);
                },
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.next,
                cursorColor: Color(0xff0A0A5B),
                keyboardType: TextInputType.number,
                controller: cpCtrl,
                decoration: InputDecoration(
                    contentPadding: EdgeInsetsDirectional.zero,
                    enabledBorder: (OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff0A0A5B)),
                      borderRadius: BorderRadius.circular(20),
                    )),
                    focusedBorder: (OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff0A0A5B)),
                    ))),
              )),
            ),
          ])
        ],
      ),
    );
  }


}
