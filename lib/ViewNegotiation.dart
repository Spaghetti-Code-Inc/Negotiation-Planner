import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'NegotiationDetails.dart';
import 'ViewCurrentIssues.dart';
import 'ViewNegotiationCurrent.dart';

class ViewNegotiation extends StatefulWidget {
  DocumentSnapshot<Object?>? negotiation;
  ViewNegotiation({Key? key, required this.negotiation}) : super(key: key);

  @override
  State<ViewNegotiation> createState() => _ViewNegotiationState();
}

class _ViewNegotiationState extends State<ViewNegotiation> {
  bool editing = false;
  late Negotiation negotiationSnap = Negotiation.fromFirestore(widget.negotiation);
  late Negotiation lastSnap = Negotiation.fromFirestore(widget.negotiation);


  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;

    print(negotiationSnap.toString());

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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bargaining Range for Entire Negotiation",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),

                  // Widget changed the negotiationSnap whenever editing mode is on
                  ViewNegotiationCurrent(
                    negotiation: negotiationSnap,
                    editing: editing,
                  ),

                  Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bargaining Range for Each Issue",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    height: negotiationSnap.cpIssues.keys.length * 100,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: negotiationSnap.cpIssues.keys.length,
                      prototypeItem: ViewCurrentIssues(
                          issueName: negotiationSnap.cpIssues.keys.elementAt(0),
                          negotiation: negotiationSnap),
                      itemBuilder: (context, index) {
                        return ViewCurrentIssues(
                            issueName:
                                negotiationSnap.issues.keys.elementAt(index),
                            negotiation: negotiationSnap);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 40,
                    // If editing is not being done, show the edit button
                    // Else show the save or discard options
                    child: !editing
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                editing = !editing;
                              });
                            },
                            child: Text("Edit Negotiation"),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff838383),
                              foregroundColor: Colors.white,
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      editing = !editing;
                                    });

                                    negotiationSnap = Negotiation(
                                      BATNA: lastSnap.BATNA,
                                      cpBATNA: lastSnap.cpBATNA,
                                      cpIssues: lastSnap.cpIssues,
                                      cpResistance: lastSnap.cpResistance,
                                      cpTarget: lastSnap.cpTarget,
                                      currentOffer: lastSnap.currentOffer,
                                      id: lastSnap.id,
                                      issues: lastSnap.issues,
                                      resistance: lastSnap.resistance,
                                      summary: lastSnap.summary,
                                      target: lastSnap.target,
                                      title: lastSnap.title,
                                    );

                                  },
                                  child: Text("Discard Edits"),
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff838383),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      editing = !editing;
                                    });
                                    db.collection("users").doc(negotiationSnap.id)
                                      .collection("Negotiations").doc(widget.negotiation?.id)
                                      .set(negotiationSnap.toFirestore());

                                    lastSnap = Negotiation(
                                      BATNA: negotiationSnap.BATNA,
                                      cpBATNA: negotiationSnap.cpBATNA,
                                      cpIssues: negotiationSnap.cpIssues,
                                      cpResistance: negotiationSnap.cpResistance,
                                      cpTarget: negotiationSnap.cpTarget,
                                      currentOffer: negotiationSnap.currentOffer,
                                      id: negotiationSnap.id,
                                      issues: negotiationSnap.issues,
                                      resistance: negotiationSnap.resistance,
                                      summary: negotiationSnap.summary,
                                      target: negotiationSnap.target,
                                      title: negotiationSnap.title,
                                    );
                                  },


                                  child: Text("Save Edits"),
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff838383),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  // TODO: Show the letter evaluation updating on the change of ths slider

                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
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
            ),
          ),
        ],
      ),
    );
  }
}

class WholeBargainSliders extends StatelessWidget {
  final int index;
  final double value;
  const WholeBargainSliders(
      {Key? key, required this.index, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
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

//TODO: Make sure that CP Resistance is higher than its target

// Red with value on top
class CPSlider extends StatelessWidget {
  final double value;
  final String name;
  const CPSlider({Key? key, required this.value, required this.name})
      : super(key: key);

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
class UserSlider extends StatelessWidget {
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
