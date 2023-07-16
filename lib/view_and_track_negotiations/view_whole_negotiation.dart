import 'package:flutter/material.dart';
import '../NegotiationDetails.dart';

import '../multi_thumb_slider/multi_thumb_slider.dart';
import '../multi_thumb_slider/src/thumb_lock_behaviour.dart';


class ViewNegotiationCurrent extends StatefulWidget {
  final Negotiation negotiation;
  final bool editing;

  ViewNegotiationCurrent({Key? key, required this.negotiation, required this.editing}) : super(key: key);

  @override
  State<ViewNegotiationCurrent> createState() => _ViewNegotiationCurrentState();
}

class _ViewNegotiationCurrentState extends State<ViewNegotiationCurrent> {
  // The values that the sliders are based off of
  // The code takes for granted that cpTarget: 1, resistance: 2, cpResistance: 3, target: 4
  late List<double> _issueState = [
    0,
    widget.negotiation.resistance * .01,
    widget.negotiation.target * .01,
    100,
  ];

  @override
  Widget build(BuildContext context) {

    // If this widget is not currently being edited then it should equal the same as the negotiation passed to it
    if(!widget.editing){
      _issueState = [
        0,
        widget.negotiation.resistance * .01,
        widget.negotiation.target * .01,
        100,
      ];
    }

    return Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * .85,
              child: Column(children: [
                MultiThumbSlider(
                    initalSliderValues: _issueState,
                    valuesChanged: (List<double> values) {
                      setState(() {
                        _issueState = values;
                      });

                      // This sets the negotiationSnap in ViewNegotiation to the new value
                      widget.negotiation.resistance = (_issueState[1]*100).truncate();
                      widget.negotiation.target = (_issueState[2]*100).truncate();
                    },
                    overdragBehaviour: ThumbOverdragBehaviour.cross,
                    // Optional: Lock behaviour of the first an last thumb.
                    // WHENEVER IT SAYS START IT LOCKS ALL
                    lockBehaviour: widget.editing ? ThumbLockBehaviour.end : ThumbLockBehaviour.start,
                    thumbBuilder: (BuildContext context, int index, double value) {
                      return WholeBargainSliders(index: index, value: value);
                    },

                    height: 70,
                    controller: MultiThumbSliderController()),
              ])),
          // valueNamesUnderneath(issueState: _issueState, editing: widget.editing),
        ],

      );
  }
}

class valueNamesUnderneath extends StatelessWidget {
  final editing;
  final List<double> issueState;
  const valueNamesUnderneath({Key? key, this.editing, required this.issueState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(editing){
      return Padding( padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Column(children: [
          Text("CP Target: " + (issueState[1]*100).toInt().toString()),
          Text("Your Resistance: " + (issueState[2]*100).toInt().toString()),
          Text("CP Resistance: " + (issueState[3]*100).toInt().toString()),
          Text("Your Target: " + (issueState[4]*100).toInt().toString()),

          Text("Entire Bargaining Range: " + (issueState[3]-issueState[2] > 0 ?
          ((issueState[2]-issueState[3])*100*(-1)).toInt().toString() : "0")),

        ]),
      );
    }
    return Container();
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
    // User Target
      case 2:
        return UserSlider(value: value, name: "Your Target");
    // Back barrier slider
      case 3:
        return FrontBackSlider(front: false);
      default:
        return FrontBackSlider(front: true);
    }

  }
}

// // Red with value on top
// class CPSlider extends StatelessWidget {
//   final double value;
//   final String name;
//   const CPSlider({Key? key, required this.value, required this.name}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//         margin: EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 2),
//         //(value*100).toInt().toString() => value of the slider
//         child: Text((value * 100).toInt().toString()),
//       ),
//       Container(
//         margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//         width: 7.0,
//         height: 30.0,
//         decoration: BoxDecoration(
//           color: Colors.red,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.2),
//               blurRadius: 6.0,
//               spreadRadius: 2.0,
//               offset: const Offset(0.0, 0.0),
//             ),
//           ],
//         ),
//       ),
//       // Container(
//       //   //(value*100).toInt().toString() => value of the slider
//       //   child: Text(name),
//       // ),
//     ]);
//   }
// }

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
// Black with no values shown
class FrontBackSlider extends StatelessWidget {
  final bool front;
  const FrontBackSlider({Key? key, required this.front}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsetsDirectional.fromSTEB(0, 20, 7, 0),
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
    ]);
  }
}