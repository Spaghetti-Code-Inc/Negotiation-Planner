import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/view_negotiation_infobuttons.dart';

import 'EvaluateAgreement.dart';
import 'NegotiationDetails.dart';
import 'Utils.dart';
import 'ViewCurrentIssues.dart';
import 'ViewNegotiationCurrent.dart';

class ViewNegotiation extends StatefulWidget {
  DocumentSnapshot<Object?>? negotiation;
  List lastNegotiationVals = [4];

  ViewNegotiation({Key? key, required this.negotiation}) : super(key: key);

  @override
  State<ViewNegotiation> createState() => _ViewNegotiationState();
}

class _ViewNegotiationState extends State<ViewNegotiation> {
  bool _wholeNegotiationEditing = false;
  late Negotiation negotiationSnap = Negotiation.fromFirestore(widget.negotiation);

  late var issueVals = Map.fromIterable(negotiationSnap.issues.keys);

  late var issueEdits = Map.fromIterable(negotiationSnap.issues.keys, value: (i) => false);

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
                  /// Contains the "Whole Negotiation Rubric"
                  Container(
                    width: MediaQuery.of(context).size.width * .85,
                    child: Row(
                      children: [
                        /// Text
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

                        /// Edit Issue / Info Buttons
                        ButtonAddons(
                          updateEdit: updateEdit,
                          editing: _wholeNegotiationEditing,
                          issueName: "whole",
                          showInfo: showInfo,
                        ),
                      ],
                    ),
                  ),

                  /// Sliders for the Whole Negotiation
                  ViewNegotiationCurrent(
                    negotiation: negotiationSnap,
                    editing: _wholeNegotiationEditing,
                  ),

                  /// Contains "Bargaining Range for Individual Issues"
                  Container(
                    width: MediaQuery.of(context).size.width * .85,
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

                  /// Contains The Issue Sliders
                  Container(
                    height: determineListViewHeight(),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: negotiationSnap.cpIssues.keys.length,
                      itemBuilder: (context, index) {

                        String issueName = negotiationSnap.issues.keys.elementAt(index);

                        /// Builds out Issue header (name, info) and then the slider
                        return Column(children: [
                          /// Header for issue slider
                          Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Row(
                              children: [
                                /// Issue Name Text
                                Expanded(
                                  child: Text(
                                    issueName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 22,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),

                                /// Buttons on right side
                                ButtonAddons(
                                  editing: issueEdits[issueName]!,
                                  issueName: issueName,
                                  updateEdit: updateEdit,
                                  showInfo: showInfo,
                                ),
                              ],
                            ),
                          ),
                          /// Issue Sliders
                          ViewCurrentIssues(
                            issueName: issueName,
                            negotiation: negotiationSnap,
                            editing: issueEdits[issueName]!,
                            comesFromMyNegotiations: true,
                          ),
                        ]);
                      },
                    ),
                  ),

                  /// Exit the negotiation button
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

  /// Defines what the height of the list view widget should be
  determineListViewHeight(){
    double total = 0.0;
    for(int i = 0; i < issueEdits.length; i++){
      if(issueEdits.values.elementAt(i)) total += 210;
      else total += 120;
    }

    return total;
  }

  /// Uploads the negotiationSnap to Firestore - Used in updateEdit
  uploadNegotiationSnap(String uploadFrom){
    // Set document from negotiation snap
    int totalUser = 0;
    int totalCp = 0;

    bool tarAndResUS = true;
    bool tarAndResCP = true;

    // Checks if the weight totals are right
    // Checks if resistance and target are right
    for (String name in negotiationSnap.issues.keys) {
      totalUser += int.parse(negotiationSnap.issues[name]["relativeValue"].toString());
      totalCp += int.parse(negotiationSnap.cpIssues[name]["relativeValue"].toString());

      if (negotiationSnap.issues[name]["A"] <= negotiationSnap.issues[name]["D"]) {
        tarAndResUS = false;
      } else if (negotiationSnap.cpIssues[name]["target"] >=
          negotiationSnap.cpIssues[name]["resistance"]) {
        tarAndResCP = false;
      }
    }

    if (totalUser == 100 && totalCp == 100 && tarAndResUS && tarAndResCP) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(negotiationSnap.id)
          .collection("Negotiations")
          .doc(widget.negotiation?.id)
          .set(negotiationSnap.toFirestore());
    } else {

      if(uploadFrom == "whole"){
        setState(() {
          _wholeNegotiationEditing = !_wholeNegotiationEditing;
        });
      }
      else{
        setState((){
          issueEdits[uploadFrom] = true;
        });
      }

      if (!tarAndResUS) {
        Utils.showSnackBar(
            "Your targets must be greater than your resistance for all user issues.");
      } else if (!tarAndResCP) {
        Utils.showSnackBar(
            "Your targets must be less than your resistance for all counterpart issues.");
      } else if (totalUser != 100 && totalCp != 100) {
        Utils.showSnackBar("Your weights for both user and counter part must add to 100.");
      } else if (totalUser != 100) {
        Utils.showSnackBar("Your weights for user must add to 100.");
      } else {
        Utils.showSnackBar("Your weights for counter part must add to 100");
      }
    }
  }

  /// Defines what 'edit' button presses should do according to name given
  updateEdit(String name, bool save) {
    //TODO change name for "whole" to something random
    if (name == "whole") {
      setState(() {
        _wholeNegotiationEditing = !_wholeNegotiationEditing;
      });

      // If it is false, then user just pressed to end the editing resulting in discard or save
      if (!_wholeNegotiationEditing) {
        if (!save) {
          negotiationSnap.cpTarget = widget.lastNegotiationVals[0];
          negotiationSnap.resistance = widget.lastNegotiationVals[1];
          negotiationSnap.cpResistance = widget.lastNegotiationVals[2];
          negotiationSnap.target = widget.lastNegotiationVals[3];
        }
        // Uploads the save to firestore
        else {
          uploadNegotiationSnap(name);
        }
      } else {
        widget.lastNegotiationVals = [
          negotiationSnap.cpTarget,
          negotiationSnap.resistance,
          negotiationSnap.cpResistance,
          negotiationSnap.target
        ];
      }

      return;
    }

    /// Changes edit state of whichever issue sent this
    setState(() {
      issueEdits[name] = !issueEdits[name]!;
    });

    /// Means user just pressed discard or save. This set it to stop editing.
    if (!issueEdits[name]!) {
      // User discarded most recent edits
      if (!save) {
        negotiationSnap.issues[name]["A"] = issueVals[name]![0];
        negotiationSnap.issues[name]["D"] = issueVals[name]![1];
        negotiationSnap.cpIssues[name]["target"] = issueVals[name]![2];
        negotiationSnap.cpIssues[name]["resistance"] = issueVals[name]![3];
      }
      // User pressed save
      else {
        uploadNegotiationSnap(name);
      }
    }
    /// User just pressed to start editing. Save the current state.
    else {
      issueVals[name] = [0, 0, 0, 0];
      issueVals[name]![0] = negotiationSnap.issues[name]["A"];
      issueVals[name]![1] = negotiationSnap.issues[name]["D"];
      issueVals[name]![2] = negotiationSnap.cpIssues[name]["target"];
      issueVals[name]![3] = negotiationSnap.cpIssues[name]["resistance"];
    }
  }

  /// Pass along info button call
  // TODO: Should change "Whole Negotiation" to something more secure
  showInfo(String name){
    if(name == "whole"){
      Map<String, int> values = {
        "target": negotiationSnap.target,
        "resistance": negotiationSnap.resistance,
        "cpTarget": negotiationSnap.cpTarget,
        "cpResistance": negotiationSnap.resistance,
      };
      showInfoRubric(context, name,  values);
    }
    else{
      print(issueVals[name].toString());
      // Create the correct map to send to the info button
      Map<String, int> values = {
        "target": negotiationSnap.issues[name]["A"],
        "resistance": negotiationSnap.issues[name]["D"],
        "cpTarget": negotiationSnap.cpIssues[name]["target"],
        "cpResistance": negotiationSnap.cpIssues[name]["resistance"],
      };

      showInfoRubric(context, name, values);
    }
  }
}

/// Contains edit functions for each slider
class ButtonAddons extends StatelessWidget {
  Function updateEdit;
  Function showInfo;
  bool editing;
  String issueName;

  ButtonAddons({Key? key, required this.updateEdit, required this.editing, required this.issueName, required this.showInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(editing);
    if (!editing) {
      return Row(children: [
        /// Just Edit Button
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
            onPressed: () {
              print(issueName);
              updateEdit(issueName, false);
            },
            padding: EdgeInsets.all(0),
          ),
        ),

        /// Info Button
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
            onPressed: () {
              showInfo(issueName);
            },
            padding: EdgeInsets.all(0),
          ),
        ),
      ]);
    } else {
      return Row(children: [
        /// Cancel Edit
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
              Icons.close,
              size: 24,
            ),
            onPressed: () {
              updateEdit(issueName, false);
            },
            padding: EdgeInsets.all(0),
          ),
        ),

        /// Save Edit
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
              Icons.save_alt,
              size: 24,
            ),
            onPressed: () {
              updateEdit(issueName, true);
            },
            padding: EdgeInsets.all(0),
          ),
        ),

        /// Info Button, when currently saving
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
            onPressed: () {
              Utils.showSnackBar("You must exit edit mode to see issue info.");
            },
            padding: EdgeInsets.all(0),
          ),
        ),
      ]);
    }
  }
}

class WholeNegotiationSliders extends StatelessWidget {
  final int index;
  final double value;
  const WholeNegotiationSliders({Key? key, required this.index, required this.value})
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
