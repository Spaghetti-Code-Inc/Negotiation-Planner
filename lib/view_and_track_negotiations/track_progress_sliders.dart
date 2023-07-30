import 'package:flutter/material.dart';
import 'package:negotiation_tracker/NegotiationDetails.dart';
import 'package:negotiation_tracker/multi_thumb_slider/multi_thumb_slider.dart';

import 'TrackProgress.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Issue Name Text

        Row(
          children: [
            /// Issue Name
            Expanded(
              child: Text(
                widget.issue.name + ": " + "Current Real Value",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 22,
                  color: Color(0xff000000),
                ),
              ),
            ),
            /// Info Button
            TotalValueInfo(
              userValue: 1.0,
              counterPartValue: 1.0,
              negotiation: new Negotiation(title: "test", summary: '', issues: [], target: 8, resistance: 2, BATNA: null, ),
            )
          ],
        ),

        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: MultiThumbSlider(
            valuesChanged: (List<double> values) {
              progressVals = values;
              setState(() {
                widget.vals[widget.index] = (progressVals[1]/multiplier).round()*1.0;
              });
              widget.refresh();
            },
            initalSliderValues: progressVals,
            lockBehaviour: ThumbLockBehaviour.end,
            overdragBehaviour: ThumbOverdragBehaviour.cross,


            thumbBuilder: (BuildContext context, int index, double value) {
              return IssueThumbs(index: index, value: value, multiplier: multiplier);
            },
            height: 70,
          ),
        ),
      ],
    );
  }
}


class IssueThumbs extends StatelessWidget {
  final int index;
  final double value;
  final double multiplier;

  IssueThumbs({Key? key, required this.index, required this.value, required this.multiplier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double realVal = (value/multiplier).roundToDouble();
    switch (index) {
      case 0:
        return FrontBack(front: true, value: realVal, name: "F");
      case 1:
        return CurrentVal(value: realVal, name: "RV");
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

  const CurrentVal({required this.value, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (value >= 10) ? EdgeInsets.only(right: 10) : EdgeInsets.only(right: 12),
      padding: EdgeInsets.only(left: 4),
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
          color: Colors.white,
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
      margin: (value >= 10) ? EdgeInsets.only(right: 2) : EdgeInsets.only(right: 6),
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


