import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'EvaluateAgreement.dart';
import 'NegotiationDetails.dart';
import 'Utils.dart';
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
  late Negotiation lastSnap;

  Color navyBlue = Color(0xff0A0A5B);

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: navyBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          negotiationSnap.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xffffffff),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.check_box_outlined, size: 24),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
            String? name = widget.negotiation?.id;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EvaluateAgreement(negotiation: widget.negotiation, docId: name!)),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline_outlined),
            onPressed: () {
              print("pressed");
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are you sure you\'d like to delete the negotiation?'),
                  actions: [
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        db
                            .collection("users")
                            .doc(negotiationSnap.id)
                            .collection("Negotiations")
                            .doc(widget.negotiation?.id)
                            .delete();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Negotiation Rubric Text
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 12),
            padding: EdgeInsets.only(),
            child: Text("Negotiation Rubric",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          ),
          // Divider
          Divider(
            thickness: 3,
            color: Colors.black,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(children: [
                  // Contains the "Whole Negotiation Rubric"
                  Container(
                    width: MediaQuery.of(context).size.width * .85,
                    child: Row(
                      children: [
                        // Issue Name Text
                        Expanded(
                          child: Text(
                            "Whole Negotiation",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),

                        // Edit Issue Button
                        Container(
                          width: 32,
                          height: 32,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: navyBlue),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.transparent,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 24,
                            ),
                            onPressed: () {},
                            padding: EdgeInsets.all(0),
                          ),
                        ),

                        // Info Button
                        Container(
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
                            onPressed: () {},
                            padding: EdgeInsets.all(0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Sliders for the Whole Negotiation
                  ViewNegotiationCurrent(
                    negotiation: negotiationSnap,
                    editing: editing,
                  ),

                  // Contains "Bargaining Range for Individual Issues"
                  Container(
                    width: MediaQuery.of(context).size.width*.85,
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Bargaining Range for Individual Issues",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),

                  // Contains The Issue Sliders
                  Container(
                    height: (editing)
                        ? negotiationSnap.cpIssues.keys.length * 220
                        : negotiationSnap.cpIssues.keys.length * 120,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: negotiationSnap.cpIssues.keys.length,
                      prototypeItem: ViewCurrentIssues(
                        issueName: negotiationSnap.cpIssues.keys.elementAt(0),
                        negotiation: negotiationSnap,
                        editing: editing,
                        comesFromMyNegotiations: true,
                      ),
                      itemBuilder: (context, index) {
                        return ViewCurrentIssues(
                          issueName: negotiationSnap.issues.keys.elementAt(index),
                          negotiation: negotiationSnap,
                          editing: editing,
                          comesFromMyNegotiations: true,
                        );
                      },
                    ),
                  ),

                  // Contains the edit (discard/save) button
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

                              lastSnap = Negotiation.fromFirestore(widget.negotiation);
                            },
                            child: Text("Edit Negotiation"),
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff838383),
                              foregroundColor: Colors.white,
                            ),
                          )
                        : Row(
                            children: [
                              // Discard Button
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      editing = !editing;
                                      negotiationSnap = lastSnap;
                                    });
                                  },
                                  child: Text("Discard Edits"),
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff838383),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              // Save Button
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    // Set document from negotiation snap
                                    int totalUser = 0;
                                    int totalCp = 0;

                                    bool tarAndResUS = true;
                                    bool tarAndResCP = true;

                                    // Checks if the weight totals are right
                                    // Checks if resistance and target are right
                                    for (String name in negotiationSnap.issues.keys) {
                                      totalUser += int.parse(
                                          negotiationSnap.issues[name]["relativeValue"].toString());
                                      totalCp += int.parse(negotiationSnap.cpIssues[name]
                                              ["relativeValue"]
                                          .toString());

                                      if (negotiationSnap.issues[name]["A"] <=
                                          negotiationSnap.issues[name]["D"]) {
                                        tarAndResUS = false;
                                      } else if (negotiationSnap.cpIssues[name]["target"] >=
                                          negotiationSnap.cpIssues[name]["resistance"]) {
                                        tarAndResCP = false;
                                      }
                                    }

                                    if (totalUser == 100 &&
                                        totalCp == 100 &&
                                        tarAndResUS &&
                                        tarAndResCP) {
                                      setState(() {
                                        editing = !editing;
                                      });

                                      db
                                          .collection("users")
                                          .doc(negotiationSnap.id)
                                          .collection("Negotiations")
                                          .doc(widget.negotiation?.id)
                                          .set(negotiationSnap.toFirestore());
                                    } else {
                                      if (!tarAndResUS) {
                                        Utils.showSnackBar(
                                            "Your targets must be greater than your resistance for all user issues.");
                                      } else if (!tarAndResCP) {
                                        Utils.showSnackBar(
                                            "Your targets must be less than your resistance for all counterpart issues.");
                                      } else if (totalUser != 100 && totalCp != 100) {
                                        Utils.showSnackBar(
                                            "Your weights for both user and counter part must add to 100.");
                                      } else if (totalUser != 100) {
                                        Utils.showSnackBar(
                                            "Your weights for user must add to 100.");
                                      } else {
                                        Utils.showSnackBar(
                                            "Your weights for counter part must add to 100");
                                      }
                                    }
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

                  // Exit the negotiation button
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop((context));
                      },
                      child: Text("Exit Negotiation"),
                      style: TextButton.styleFrom(
                        backgroundColor: navyBlue,
                        foregroundColor: Colors.white,
                        elevation: 5,
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
  const WholeBargainSliders({Key? key, required this.index, required this.value}) : super(key: key);

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
      // Never going to send
      default:
        return FrontBackSlider(front: true);
    }
  }
}

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

class ShowTitle extends StatelessWidget {
  const ShowTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
