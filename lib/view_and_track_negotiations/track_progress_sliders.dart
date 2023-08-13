import 'package:flutter/material.dart';
import 'package:negotiation_tracker/NegotiationDetails.dart';
import 'package:negotiation_tracker/multi_thumb_slider/multi_thumb_slider.dart';
import 'package:negotiation_tracker/view_and_track_negotiations/view_negotiation_infobuttons.dart';

import '../main.dart';

class TrackSliderProgress extends StatefulWidget {

  Issue issue;
  List<double> vals;
  int index;
  Function refresh;

  TrackSliderProgress({Key? key, required this.issue, required this.vals, required this.index, required this.refresh}) : super(key: key);

  @override
  State<TrackSliderProgress> createState() => _TrackSliderProgressState();
}

class _TrackSliderProgressState extends State<TrackSliderProgress> {

  late double multiplier = 1.0/widget.issue.relativeValue;
  late List<double> progressVals = [];

  @override
  Widget build(BuildContext context) {

    progressVals = [0, widget.vals[widget.index]*multiplier, 1];

    // Step 1: Find the closest letter value below
    int closest = 100;
    int closestLetter = 0;
    int i = 0;

    Map<int, String> letters = {0: "A", 1: "B", 2: "C", 3: "D", 4: "F"};
    List<String> alpha = ["A", "B", "C", "D", "F"];

    for(String each in alpha){
      double points = widget.issue.issueVals[each][0];
      double distance = widget.vals[widget.index]-points;
      if(distance >= 0 && distance < closest) {
        closest = distance.toInt();
        closestLetter = i;
      }
      i++;
    }

    // Step 2: Find the distance from each of the closest letter values and assign real value - Run if != A
    String letter = "A";
    double realValue = double.parse(widget.issue.issueVals["A"][1].toString());
    if(closestLetter != 0){
      int min = widget.issue.issueVals[letters[closestLetter]][0].round();
      int max = widget.issue.issueVals[letters[closestLetter-1]][0].round();
      int here = widget.vals[widget.index].toInt();

      max -= min;
      here -= min;
      double distance = here/max;

      if(distance >= 0.5) letter = letters[closestLetter-1]!;
      else letter = letters[closestLetter]!;

      double realMin = double.parse(widget.issue.issueVals[letters[closestLetter]][1].toString());
      double realMax = double.parse(widget.issue.issueVals[letters[closestLetter-1]][1].toString());



      realValue = ((realMin + distance*(realMax-realMin))*1000).truncateToDouble()/1000;
    }

    String name = issueName(realValue.toString(), widget.issue.datatype);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Issue Name Text
        Row(
          children: [
            /// Issue Name
            Expanded(
              child: Text(
                widget.issue.name + ": " + name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 22,
                  color: Color(0xff000000),
                ),
              ),
            ),
            /// Info Button
            SliderInfo(
              currentValue: name,
              points: widget.vals[widget.index].truncate(),
              letter: letter,
              aboveResistance: (letter != "F"),
            )
          ],
        ),

        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: MultiThumbSlider(
            valuesChanged: (List<double> values) {
              progressVals = values;
              setState(() {
                widget.vals[widget.index] = (progressVals[1]/multiplier)*1.0;
              });
              widget.refresh();
            },
            initalSliderValues: progressVals,
            lockBehaviour: ThumbLockBehaviour.end,
            overdragBehaviour: ThumbOverdragBehaviour.cross,


            thumbBuilder: (BuildContext context, int index, double value) {
              return IssueThumbs(index: index, letter: letter, value: value, multiplier: multiplier);
            },
            height: 70,
          ),
        ),
      ],
    );
  }

  /// The point is to remove unnecessary .0 at the end of the display
  String issueName(String value, String datatype){
    try{
      if(value.substring(value.length-2, value.length) == ".0"){

        return value.substring(0, value.length-2) + " " + datatype;
      } else {

        return value + " " + datatype;
      }
    } catch (e) {
      return value + " " + datatype;
    }


  }
}

/// Editable slider info
class SliderInfo extends StatelessWidget {
  String letter;
  String currentValue;
  bool aboveResistance;
  int points;

  SliderInfo(
      {Key? key,
        required this.letter,
        required this.currentValue,
        required this.aboveResistance,
        required this.points
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: navyBlue),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
      ),
      child: IconButton(
        icon: Icon(
          Icons.info_outlined,
          size: 28,
          color: navyBlue,
        ),
        onPressed: () {
          showInfoTrackProgress(context, currentValue, letter, points, aboveResistance);
        },
        padding: EdgeInsets.all(0),
      ),
    );
  }
}


class IssueThumbs extends StatelessWidget {
  final int index;
  final double value;
  final double multiplier;
  final String letter;
  final int target;
  final int resistance;

  IssueThumbs({Key? key, required this.index, required this.letter, required this.value, required this.multiplier, this.target=101, this.resistance=-1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double realVal = (value/multiplier).roundToDouble();
    switch (index) {
      case 0:
        return FrontBack(front: true, value: realVal, name: "F");
      case 1:
        return CurrentVal(value: realVal, name: letter, target: target, resistance: resistance);
      case 2:
        return FrontBack(front: false, value: realVal, name: "A");
      default:
        return FrontBack(front: false, value: realVal, name: "Bad");
    }
  }
}

// Blue with value on bottom
class CurrentVal extends StatelessWidget {
  final double value;
  final String name;
  final int target;
  final int resistance;

  const CurrentVal({required this.value, required this.name, required this.target, required this.resistance});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (value >= 10) ? EdgeInsets.only(right: 11, left: 7) : EdgeInsets.only(right: 13, left: 7),
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          child: Text(name),
        ),
        Container(
          width: 7.0,
          height: 30.0,
          decoration: BoxDecoration(
            // Red if "F" or Below resistance, Green if above target, else blue
            color: (name == "F" || value <= resistance) ? Colors.red : (value >= target || name=="A") ? Colors.green : Colors.blue,
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
          child: Text((value).toInt().toString()),
        ),
      ]),
    );
  }
}

// Black with value on bottom
class FrontBack extends StatelessWidget {
  final bool front;
  final double value;
  final String name;
  const FrontBack({Key? key, required this.front, required this.value, required this.name}) : super(key: key);

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


