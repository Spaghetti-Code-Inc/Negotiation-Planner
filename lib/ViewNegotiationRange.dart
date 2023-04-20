import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

import 'ViewNegotiation.dart';

class ViewNegotiationRange extends StatefulWidget {

  final DocumentSnapshot<Object?>? negotiation;
  const ViewNegotiationRange({Key? key, required this.negotiation}) : super(key: key);

  @override
  State<ViewNegotiationRange> createState() => _ViewNegotiationRangeState();
}

class _ViewNegotiationRangeState extends State<ViewNegotiationRange> {

  late List<double> _totalBargainingRange = [
    0,
    widget.negotiation?.get("cpTarget") * .01,
    widget.negotiation?.get("resistance") * .01,
    widget.negotiation?.get("cpResistance") * .01,
    widget.negotiation?.get("target") * .01,
    100,
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width * .8,
            child: Column(children: [
              Text(
                "Bargaining Range for the Entire Negotiation",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              MultiThumbSlider(
                  initalSliderValues: _totalBargainingRange,
                  valuesChanged: (List<double> values) {
                    setState(() {
                      _totalBargainingRange = values;
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
          Text("Entire Bargaining Arrangement: " + (_totalBargainingRange[3]-_totalBargainingRange[2] > 0 ?
          ((_totalBargainingRange[2]-_totalBargainingRange[3])*100*(-1)).toInt().toString() : "0")),
        ]),
      ]
    );
  }
}
