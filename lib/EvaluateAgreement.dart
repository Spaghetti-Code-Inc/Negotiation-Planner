///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MyNegotiations.dart';
import 'NegotiationDetails.dart';
import 'main.dart';

bool _editing = false;
List<int> _values = [0];


class EvaluateAgreement extends StatefulWidget {
  Negotiation negotiation;
  String docId;
  EvaluateAgreement({Key? key, required this.negotiation, required this.docId}) : super(key: key);

  @override
  State<EvaluateAgreement> createState() => _EvaluateAgreementState();
}

class _EvaluateAgreementState extends State<EvaluateAgreement> {
  late Negotiation negotiationSnap = widget.negotiation;
  bool working = false;

  @override
  Widget build(BuildContext context) {
    print("refresh");

    return Scaffold(
      appBar: PrepareBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            height: negotiationSnap.cpIssues.keys.length * 200,
            child: ListView.builder(
              itemCount: negotiationSnap.cpIssues.keys.length,
              itemBuilder: (context, index) {
                return EvaluateSlider(
                    negotiation: negotiationSnap, index: index);
              },
            ),
          ),

          // Flag, Save/Discard buttons
          UpdateAgreement(negotiation: negotiationSnap, refresh: refresh, docId: widget.docId),

          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: 40,
            child: TextButton(
              onPressed: () {

                Navigator.pop(context);
              },
              child: Text("Tradeoffs"),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff838383),
                foregroundColor: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * .9,
            height: 40,
            child: TextButton(
              onPressed: () {
                navigatorKey.currentState!.popUntil((route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyNegotiations()),
                );
              },
              child: Text("Exit Negotiation"),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff838383),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // So the update agreement - flag and save/discard buttons - can reset the page
  refresh(){
    setState(() {});
  }
}

// Update the Values Buttons
class UpdateAgreement extends StatefulWidget {
  final Function() refresh;
  String docId;
  Negotiation negotiation;
  UpdateAgreement({Key? key, required this.negotiation, required this.refresh, required this.docId}) : super(key: key);

  @override
  State<UpdateAgreement> createState() => _UpdateAgreementState();
}

class _UpdateAgreementState extends State<UpdateAgreement> {
  @override
  Widget build(BuildContext context) {
    if (!_editing) {
      return Container(
        width: MediaQuery.of(context).size.width * .9,
        margin: EdgeInsets.only(bottom: 10),
        height: 40,
        child: TextButton(
          onPressed: () {
            setState(() {
              for(String name in widget.negotiation.issues.keys){
                int adding = widget.negotiation.issues[name]["currentAgreement"].truncate();
                print(adding);
                _values.add(adding);
              }

              _editing = !_editing;
            });
          },
          child: Text("Flag"),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xff838383),
            foregroundColor: Colors.white,
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10, right: 5),
              height: 40,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    int i = 0;
                    for(String name in widget.negotiation.issues.keys){
                      widget.negotiation.issues[name]["currentAgreement"] = _values.elementAt(i);
                      i++;
                    }

                    _editing = !_editing;
                    widget.refresh();
                  });
                },
                child: Text("Discard"),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff838383),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 5),
              height: 40,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _editing = !_editing;
                    _values.clear();
                  });

                  FirebaseFirestore.instance.collection("users").doc(widget.negotiation.id)
                      .collection("Negotiations").doc(widget.docId)
                      .set(widget.negotiation.toFirestore());


                  super.setState(() {});
                },
                child: Text("Save"),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff838383),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      );
    }
  }
}

// Produces slider that changes the value of the "currentAgreement"
class EvaluateSlider extends StatefulWidget {
  Negotiation negotiation;
  int index;

  EvaluateSlider({Key? key, required this.negotiation, required this.index})
      : super(key: key);

  @override
  State<EvaluateSlider> createState() => _EvaluateSliderState();
}

class _EvaluateSliderState extends State<EvaluateSlider> {
  late String issueName =
      widget.negotiation.issues.keys.elementAt(widget.index);
  late Map issues = widget.negotiation.issues[issueName];

  @override
  Widget build(BuildContext context) {

    if (issues["currentAgreement"] == null) {
      issues["currentAgreement"] = 50.0;
    }
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  issueName +
                      ": " +
                      issues["currentAgreement"].truncate().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    fontSize: 22,
                    color: Color(0xff000000),
                  )),
            ),
            alignment: Alignment.bottomLeft,
          ),
          Slider(
            min: 0.0,
            max: 100.0,
            inactiveColor: Colors.red,
            value: issues["currentAgreement"]*1.0,
            divisions: 100,
            label: '${issues["currentAgreement"].round()}',
            onChanged: (value) {
              if (_editing) {
                setState(() {
                  issues["currentAgreement"] = value;
                });
              }
            },
          ),
        ]));
  }
}

