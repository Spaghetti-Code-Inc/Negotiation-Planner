import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../NegotiationDetails.dart';
import 'ViewNegotiation.dart';
import '../multi_thumb_slider/src/multi_thumb_slider.dart';
import '../multi_thumb_slider/src/thumb_lock_behaviour.dart';
import '../multi_thumb_slider/src/thumb_overdrag_behaviour.dart';

class ViewCurrentIssues extends StatefulWidget {
  final bool editing;
  final bool comesFromMyNegotiations;
  final Issue issue;

  List lastVals = [4];

  ViewCurrentIssues(
      {Key? key,
      required this.editing,
      required this.comesFromMyNegotiations,
      required this.issue})
      : super(key: key);

  @override
  State<ViewCurrentIssues> createState() => _ViewCurrentIssuesState();
}

class _ViewCurrentIssuesState extends State<ViewCurrentIssues> {
  late Issue issue = widget.issue;

  late double userRes = double.parse(issue.issueVals["D"].toString());
  late double userTar = double.parse(issue.issueVals["A"].toString());

  // late double cpRes = double.parse(issue.cpResistance.toString());
  // late double cpTar = double.parse(issue.cpTarget.toString());

  late double usWeight = 100.0 / issue.relativeValue;
  // late double cpWeight = 100.0 / issue.cpRelativeValue;

  late List<double> _issueVals = [0, userRes / 100, 0 / 100, userTar / 100, 0 / 100, 1];

  String bargainingRange() {
    return issue.name +
        ": " +
        (_issueVals[4] - _issueVals[1] > 0
            ? ((_issueVals[1] - _issueVals[4]) * 100 * (-1)).toInt().toString()
            : "0");
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.editing) {

      late double userRes = double.parse(issue.issueVals["D"].toString());
      late double userTar = double.parse(issue.issueVals["A"].toString());

      // late double cpRes = double.parse(issue.cpResistance.toString());
      // late double cpTar = double.parse(issue.cpTarget.toString());

      _issueVals = [0, userRes / 100.0, 0 / 100.0, userTar / 100.0, 0 / 100.0, 1];
    }

    return Column(children: [

      Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
        width: MediaQuery.of(context).size.width * .85,
        child: MultiThumbSlider(
          initalSliderValues: _issueVals,
          valuesChanged: (List<double> values) {
            setState(() {
              _issueVals = values;
            });

            List<int> vals = EvenlyDistribute(
                (_issueVals[3] * 100).truncate(), (_issueVals[1] * 100).truncate());

            issue.issueVals["D"] = vals[0];
            issue.issueVals["C"] = vals[1];
            issue.issueVals["B"] = vals[2];
            issue.issueVals["A"] = vals[3];
            //
            // issue.cpResistance = (_issueVals[4] * 100).truncate();
            // issue.cpTarget = (_issueVals[2] * 100).truncate();
          },

          overdragBehaviour: ThumbOverdragBehaviour.cross,
          // Locks all of the slider, must be changed to edit the slider
          lockBehaviour: widget.editing ? ThumbLockBehaviour.end : ThumbLockBehaviour.start,
          thumbBuilder: (BuildContext context, int index, double value) {
            return WholeNegotiationSliders(index: index, value: value);
          },
          height: 70,
        ),
      ),
      ChangeRelativeValues(
          editing: widget.editing, issue: issue)
    ]);
  }

  List<int> EvenlyDistribute(int high, int low) {
    int length = 3;
    List<int> vals = <int>[low, 0, 0, high];
    // Gets how much the pts should change by in each step
    int total = high - low;
    int step = (total / length).round();

    for (int i = 1; i < length; i++) {
      vals[3 - i] = (total - step * i) + low;
    }

    return vals;
  }
}

class ChangeRelativeValues extends StatelessWidget {
  final bool editing;
  final Issue issue;
  ChangeRelativeValues(
      {Key? key, required this.editing, required this.issue})
      : super(key: key);

  TextEditingController userCtrl = TextEditingController();
  TextEditingController cpCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (!editing) {
      return Container();
    }

    userCtrl.text = issue.relativeValue.toString();
    // cpCtrl.text = issue.cpRelativeValue.toString();
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          // Change Relative Value for the User
          Expanded(
            child: Row(children: [
              // User Weight text
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

              // User Input Weight
              Expanded(
                child: Center(
                    child: TextFormField(
                  onChanged: (newVal) {
                    issue.relativeValue = int.parse(userCtrl.text);
                  },
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  cursorColor: Color(0xff0A0A5B),
                  keyboardType: TextInputType.number,
                  controller: userCtrl,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.zero,
                      enabledBorder: (OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B)),
                        borderRadius: BorderRadius.circular(20),
                      )),
                      focusedBorder: (OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B))))),
                )),
              ),

              // Sets slight area between points and issue column
              Container(
                width: 20,
              ),

              // Counter Part text
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

              // Counter Part Weight input
              Expanded(
                child: Center(
                    child: TextFormField(
                  onChanged: (newVal) {
                    // issue.cpRelativeValue = int.parse(cpCtrl.text);
                  },
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  cursorColor: Color(0xff0A0A5B),
                  keyboardType: TextInputType.number,
                  controller: cpCtrl,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsetsDirectional.zero,
                    enabledBorder: (OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B)),
                      borderRadius: BorderRadius.circular(20),
                    )),
                    focusedBorder: (OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B)),
                    )),
                  ),
                )),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

Color navyBlue = Color(0xff0A0A5B);
