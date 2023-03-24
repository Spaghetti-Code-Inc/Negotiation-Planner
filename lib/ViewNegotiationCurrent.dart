import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

import 'NegotiationDetails.dart';

class ViewNegotiationCurrent extends StatefulWidget {
  final Negotiation negotiation;

  ViewNegotiationCurrent({Key? key, required this.negotiation}) : super(key: key);

  @override
  State<ViewNegotiationCurrent> createState() => _ViewNegotiationCurrentState();
}

class _ViewNegotiationCurrentState extends State<ViewNegotiationCurrent> {
  late List<double> _issueState = [
    0,
    widget.negotiation.cpTarget * .01,
    widget.negotiation.resistance * .01,
    widget.negotiation.cpResistance * .01,
    widget.negotiation.target * .01,
    100,
  ];

  @override
  Widget build(BuildContext context) {
    print(_issueState);

    MultiThumbSliderController sliderController = MultiThumbSliderController();

    return Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: MediaQuery.of(context).size.width * .8,
              child: Column(children: [
                MultiThumbSlider(
                    initalSliderValues: _issueState,
                    valuesChanged: (List<double> values) {
                      setState(() {
                        _issueState = values;
                      });
                    },
                    overdragBehaviour: ThumbOverdragBehaviour.cross,
                    // Optional: Lock behaviour of the first an last thumb.
                    // Defaults to ThumbLockBehaviour.stop
                    lockBehaviour: ThumbLockBehaviour.both,
                    thumbBuilder: (BuildContext context, int index, double value) {
                      return WholeBargainSliders(index: index, value: value);
                    },
                    // Optional: Background widget of the slider.
                    // Optional: Height of the Widget. Defaults to 48.
                    height: 70,
                    // Optional: MultiThumbSliderController can be used to control the slider after build. E.g adding/removing thumbs, get current values, move thumb, etc.
                    controller: MultiThumbSliderController()),
              ])),
          Column(children: [
            Text("CP Target: " + (_issueState[1]*100).toInt().toString()),
            Text("Your Resistance: " + (_issueState[2]*100).toInt().toString()),
            Text("CP Resistance: " + (_issueState[3]*100).toInt().toString()),
            Text("Your Target: " + (_issueState[4]*100).toInt().toString()),
            Text("Entire Bargaining Arrangement: " + (_issueState[3]-_issueState[2] > 0 ?
            ((_issueState[2]-_issueState[3])*100*(-1)).toInt().toString() : "0")),
          ]),
        ],

      );
  }
}


class WholeBargainSliders extends StatelessWidget {
  final int index;
  final double value;
  const WholeBargainSliders({Key? key, required this.index, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index){
    // Front barrier slider
      case 0:
        return FrontBackSlider(front: true);
    // User Resistance
      case 1:
        return UserSlider(value: value, name: "Your Resistance");
    // CP Target
      case 2:
        return CPSlider(value: value, name: "CP Target");
    // User Target
      case 3:
        return UserSlider(value: value, name: "Your Target");
    // CP Resistance
      case 4:
        return CPSlider(value: value, name: "CP Resistance");
    // Back barrier slider
      case 5:
        return FrontBackSlider(front: false);
      default:
        return FrontBackSlider(front: true);
    }

  }
}

//TODO: Make sure no values are greater than 100 when creating new negotiation

// Red with value on top
class CPSlider extends StatelessWidget {
  final double value;
  final String name;
  const CPSlider({Key? key, required this.value, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 2),
        //(value*100).toInt().toString() => value of the slider
        child: Text((value * 100).toInt().toString()),
      ),
      Container(
        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        width: 7.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
      ),
      // Container(
      //   //(value*100).toInt().toString() => value of the slider
      //   child: Text(name),
      // ),
    ]);
  }
}
// Blue with value on bottom
class UserSlider extends StatelessWidget{
  final double value;
  final String name;

  const UserSlider({required this.value, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Container(
      //   margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
      //   child: Text(name),
      // ),
      Container(
        margin: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        width: 7.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
      ),
      Container(
        //(value*100).toInt().toString() => value of the slider
        child: Text((value * 100).toInt().toString()),
      )
    ]);
  }

}
// Black with value on bottom
class FrontBackSlider extends StatelessWidget {
  final bool front;
  const FrontBackSlider({Key? key, required this.front}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        width: 7.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
      ),
      Container(
        //(value*100).toInt().toString() => value of the slider
        child: front ? Text("0") : Text("100"),
      )
    ]);
  }
}