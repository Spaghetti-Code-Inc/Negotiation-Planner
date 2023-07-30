import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../NegotiationDetails.dart';
import '../multi_thumb_slider/src/multi_thumb_slider.dart';
import '../multi_thumb_slider/src/thumb_lock_behaviour.dart';
import '../multi_thumb_slider/src/thumb_overdrag_behaviour.dart';

class ViewCurrentIssues extends StatefulWidget {
  final Issue issue;
  Function refresh;

  List lastVals = [5];

  ViewCurrentIssues(
      {Key? key,
      required this.issue, required this.refresh})
      : super(key: key);

  @override
  State<ViewCurrentIssues> createState() => _ViewCurrentIssuesState();
}

class _ViewCurrentIssuesState extends State<ViewCurrentIssues> {
  late Issue issue = widget.issue;

  late double A = double.parse(issue.issueVals["A"][0].toString());
  late double B = double.parse(issue.issueVals["B"][0].toString());
  late double C = double.parse(issue.issueVals["C"][0].toString());
  late double D = double.parse(issue.issueVals["D"][0].toString());
  late double F = double.parse(issue.issueVals["F"][0].toString());

  late double multiplier = 1.0/issue.relativeValue;

  late List<double> _issueVals = [0, D*multiplier, C*multiplier, B*multiplier, 1];

  String bargainingRange() {
    return issue.name + ": " + (A-D).toString();
  }

  @override
  Widget build(BuildContext context) {
    if (true) {
      late double B = double.parse(issue.issueVals["B"][0].toString());
      late double C = double.parse(issue.issueVals["C"][0].toString());
      late double D = double.parse(issue.issueVals["D"][0].toString());
      /// Multiplier puts every value on a scale from [0-1]
      _issueVals = [0, D*multiplier, C*multiplier, B*multiplier, 1];

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

              issue.issueVals["A"][0] = (_issueVals[4]/multiplier).round();
              issue.issueVals["B"][0] = (_issueVals[3]/multiplier).round();
              issue.issueVals["C"][0] = (_issueVals[2]/multiplier).round();
              issue.issueVals["D"][0] = (_issueVals[1]/multiplier).round();
              issue.issueVals["F"][0] = (_issueVals[0]/multiplier).round();

            });

            widget.refresh();

          },

          overdragBehaviour: ThumbOverdragBehaviour.stop,
          // Locks all of the slider, must be changed to edit the slider
          lockBehaviour: ThumbLockBehaviour.end,
          thumbBuilder: (BuildContext context, int index, double value) {
            return IssueThumbs(index: index, value: value, multiplier: multiplier);
          },
          height: 70,
        ),
      ),
      // ChangeRelativeValues(
      //     editing: widget.editing, issue: issue)
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

              /// Counter part relative value change
              // // Counter Part text
              // Expanded(
              //   flex: 3,
              //   child: Center(
              //     child: Text(
              //       "Counter Part Weight: ",
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
              // // Counter Part Weight input
              // Expanded(
              //   child: Center(
              //       child: TextFormField(
              //     onChanged: (newVal) {
              //       // issue.cpRelativeValue = int.parse(cpCtrl.text);
              //     },
              //     textAlign: TextAlign.center,
              //     textInputAction: TextInputAction.next,
              //     cursorColor: Color(0xff0A0A5B),
              //     keyboardType: TextInputType.number,
              //     controller: cpCtrl,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsetsDirectional.zero,
              //       enabledBorder: (OutlineInputBorder(
              //         borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B)),
              //         borderRadius: BorderRadius.circular(20),
              //       )),
              //       focusedBorder: (OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20),
              //         borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B)),
              //       )),
              //     ),
              //   )),
              // ),
            ]),
          ),
        ],
      ),
    );
  }
}

class IssueThumbs extends StatelessWidget {
  final int index;
  double value;
  final double multiplier;
  IssueThumbs({Key? key, required this.index, required this.value, required this.multiplier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    value = (value/multiplier).roundToDouble();
    switch (index) {
    // F
      case 0:
        return FrontBackSlider(value: value, front: true, name: "F");
    // D
      case 1:
        return UserSlider(value: value, name: "D");
    // C
      case 2:
        return UserSlider(value: value, name: "C");
    // B
        case 3:
        return UserSlider(value: value, name: "B");
    // A
      case 4:
        return FrontBackSlider(value: value, front: false, name: "A");
    // Never going to send
      default:
        return FrontBackSlider(value: value, front: true, name: "Wrong");
    }
  }
}

// Blue with value on bottom
class UserSlider extends StatelessWidget {
  final double value;
  final String name;

  const UserSlider({required this.value, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (value >= 10) ? EdgeInsets.only(right: 4) : EdgeInsets.only(right: 6),
      padding: EdgeInsets.only(right: 8, left: 8),
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          child: Text(name),
          color: Colors.white,
        ),
        Container(
          width: 7.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 6.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
        ),
        Container(
          //(value*100).toInt().toString() => value of the slider
          child: Text((value).toInt().toString()),
        )
      ]),
    );
  }
}

// Black with value on bottom
class FrontBackSlider extends StatelessWidget {
  final bool front;
  final double value;
  final String name;
  const FrontBackSlider({Key? key, required this.front, required this.value, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (value >= 10) ? EdgeInsets.only(right: 4) : EdgeInsets.only(right: 6),
      child: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Text(name),
          color: Colors.white,
        ),
        Container(
          width: 7.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 6.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
        ),
        Container(
          // => value of the slider
          child: Text((value).toInt().toString()),
        )
      ]),
    );
  }
}

Color navyBlue = Color(0xff0A0A5B);
