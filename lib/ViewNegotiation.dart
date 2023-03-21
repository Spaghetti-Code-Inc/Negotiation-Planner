import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

import 'NegotiationDetails.dart';

class ViewNegotiation extends StatefulWidget {
  final DocumentSnapshot<Object?>? negotiation;

  ViewNegotiation({Key? key, required this.negotiation}) : super(key: key);

  @override
  State<ViewNegotiation> createState() => _ViewNegotiationState();
}

class _ViewNegotiationState extends State<ViewNegotiation> {
  late List<double> _issueState = [
    0,
    widget.negotiation?.get("cpTarget") * .01,
    widget.negotiation?.get("resistance") * .01,
    widget.negotiation?.get("cpResistance") * .01,
    widget.negotiation?.get("target") * .01,
    100,
  ];

  @override
  Widget build(BuildContext context) {
    print(_issueState);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff000000),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          widget.negotiation?.get("title"),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xffffffff),
          ),
        ),
        leading: const Icon(
          Icons.sort,
          color: Color(0xffffffff),
          size: 24,
        ),
      ),
      body: Column(
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
                    initalSliderValues: _issueState,
                    valuesChanged: (List<double> values) {
                      setState(() {
                        _issueState = values;
                      });
                    },
                    overdragBehaviour: ThumbOverdragBehaviour.move,
                    // Optional: Lock behaviour of the first an last thumb.
                    // Defaults to ThumbLockBehaviour.stop
                    lockBehaviour: ThumbLockBehaviour.both,
                    thumbBuilder:
                        (BuildContext context, int index, double value) {
                      return Column(children: [
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          width: 7.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: (index % 2 == 0) ? Colors.blue : Colors.red,
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
                    },
                    // Optional: Background widget of the slider.
                    // Optional: Height of the Widget. Defaults to 48.
                    height: 70,
                    // Optional: MultiThumbSliderController can be used to control the slider after build. E.g adding/removing thumbs, get current values, move thumb, etc.
                    controller: MultiThumbSliderController()),
              ])),

          Column(children: [
            Text("CP Target: " + (_issueState[0]*100).toInt().toString()),
            Text("Your Resistance: " + (_issueState[1]*100).toInt().toString()),
            Text("CP Resistance: " + (_issueState[2]*100).toInt().toString()),
            Text("Your Target: " + (_issueState[3]*100).toInt().toString()),
          ]),

          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Prepare For New Negotiation"),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff838383),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
