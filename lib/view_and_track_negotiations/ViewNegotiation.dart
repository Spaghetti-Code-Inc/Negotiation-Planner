import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/view_negotiation_infobuttons.dart';

import 'TrackProgress.dart';
import '../NegotiationDetails.dart';
import '../Utils.dart';
import 'view_delivered_issue.dart';
import 'view_whole_negotiation.dart';

class ViewNegotiation extends StatefulWidget {
  DocumentSnapshot<Object?>? negotiation;
  List lastNegotiationVals = [4];

  ViewNegotiation({Key? key, required this.negotiation}) : super(key: key);

  @override
  State<ViewNegotiation> createState() => _ViewNegotiationState();
}

class _ViewNegotiationState extends State<ViewNegotiation> {
  bool _wholeNegotiationEditing = false;
  late Negotiation negotiationSnap =
      Negotiation.fromFirestore(widget.negotiation);
  late String docId = widget.negotiation!.id;

  // Keeps track of old value for issue
  late List<List<int>> issueVals = List.filled(
      negotiationSnap.issues.length, List.filled(5, 0),
      growable: false);
  // Keeps track if the issue is being edited or not
  late List<bool> issueEdits =
      List.filled(negotiationSnap.issues.length, false, growable: false);

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
          icon: Icon(Icons.delete_outline_outlined),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                    'Are you sure you\'d like to delete the negotiation?'),
                actions: [
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      String? id = FirebaseAuth.instance.currentUser?.uid;
                      db.collection(id!).doc(widget.negotiation?.id).delete();
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
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check_box_outlined, size: 24),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              String? name = widget.negotiation?.id;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TrackProgress(negotiation: widget.negotiation)),
              );
            },
          ),
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
                          index: -1,
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: negotiationSnap.issues.length,
                    itemBuilder: (context, index) {
                      /// The current Issue that this builder mentions
                      Issue issueHere = negotiationSnap.issues[index];

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
                                  issueHere.name +
                                      ": Weight = " +
                                      issueHere.relativeValue.toString(),
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
                                editing: issueEdits[index],
                                index: index,
                                updateEdit: updateEdit,
                                showInfo: showInfo,
                              ),
                            ],
                          ),
                        ),

                        /// Issue Sliders
                        ViewCurrentIssues(
                          issue: issueHere,
                          editing: issueEdits[index],
                        ),
                      ]);
                    },
                  ),

                ]),
              ),
            ),
          ),


          /// Exit the negotiation button
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: 40,
            margin: EdgeInsets.only(bottom: 20),
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
        ],
      ),
    );
  }

  /// Defines what the height of the list view widget should be
  determineListViewHeight() {
    double total = 0.0;
    for (int i = 0; i < issueEdits.length; i++) {
      if (issueEdits[i])
        total += 210;
      else
        total += 120;
    }

    return total;
  }

  /// Uploads the negotiationSnap to Firestore - Used in updateEdit
  uploadNegotiationSnap(int index) {
    // Set document from negotiation snap
    int totalUser = 0;

    // Checks if the weight totals are right
    // Checks if resistance and target are in line for cp and user
    for (Issue issue in negotiationSnap.issues) {
      totalUser += issue.relativeValue;
    }

    if (totalUser == 100) {
      String? id = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore.instance
          .collection(id!)
          .doc(docId)
          .set(negotiationSnap.toFirestore());
    } else {
      if (index == -1) {
        setState(() {
          _wholeNegotiationEditing = !_wholeNegotiationEditing;
        });
      } else {
        setState(() {
          issueEdits[index] = true;
        });
      }

      if (totalUser != 100) {
        Utils.showSnackBar("Your weights for user must add to 100.");
      }
    }
  }

  /// Defines what 'edit' button presses should do according to name given
  updateEdit(int index, bool save) {
    if (index == -1) {
      setState(() {
        _wholeNegotiationEditing = !_wholeNegotiationEditing;
      });

      // If it is false, then user just pressed to end the editing resulting in discard or save
      if (!_wholeNegotiationEditing) {
        if (!save) {
          negotiationSnap.resistance = widget.lastNegotiationVals[0];
          negotiationSnap.target = widget.lastNegotiationVals[1];
        }
        // Uploads the save to firestore
        else {
          uploadNegotiationSnap(index);
        }
      } else {
        widget.lastNegotiationVals = [
          negotiationSnap.resistance,
          negotiationSnap.target
        ];
      }

      return;
    }

    /// Changes edit state of whichever issue sent this
    setState(() {
      issueEdits[index] = !issueEdits[index];
    });

    /// Issue referred to in the following logic
    Issue thisIssue = negotiationSnap.issues[index];

    /// Means user just pressed discard or save. This set it to stop editing.
    if (!issueEdits[index]) {
      /// Discarded edits
      if (!save) {
        thisIssue.issueVals["A"][0] = issueVals[index][4];
        thisIssue.issueVals["B"][0] = issueVals[index][3];
        thisIssue.issueVals["C"][0] = issueVals[index][2];
        thisIssue.issueVals["D"][0] = issueVals[index][1];
        thisIssue.issueVals["F"][0] = issueVals[index][0];
      }

      /// User pressed save
      else {
        print(thisIssue.issueVals);
        uploadNegotiationSnap(index);
      }
    }

    /// User just pressed to start editing. Save the cur
    else {
      issueVals[index] = [0, 0, 0, 0, 0];
      issueVals[index][4] = thisIssue.issueVals["A"][0]!;
      issueVals[index][3] = thisIssue.issueVals["B"][0]!;
      issueVals[index][2] = thisIssue.issueVals["C"][0]!;
      issueVals[index][1] = thisIssue.issueVals["D"][0]!;
      issueVals[index][0] = thisIssue.issueVals["F"][0]!;
    }
  }

  /// Pass along info button call
  showInfo(int index) {
    if (index == -1) {
      Map<String, int> values = {
        "target": negotiationSnap.target,
        "resistance": negotiationSnap.resistance,
        // "cpTarget": negotiationSnap.cpTarget,
        "cpResistance": negotiationSnap.resistance,
      };
      showInfoRubric(context, negotiationSnap.issues[index].name, values);
    } else {
      Issue thisIssue = negotiationSnap.issues[index];
      // Create the correct map to send to the info button
      Map<String, int> values = {
        "target": thisIssue.issueVals["A"]!,
        "resistance": thisIssue.issueVals["D"]!,
      };

      showInfoRubric(context, negotiationSnap.issues[index].name, values);
    }
  }
}

/// Contains edit functions for each slider
class ButtonAddons extends StatelessWidget {
  Function updateEdit;
  Function showInfo;
  bool editing;
  int index;

  ButtonAddons(
      {Key? key,
      required this.updateEdit,
      required this.editing,
      required this.index,
      required this.showInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              updateEdit(index, false);
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
              showInfo(index);
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
              updateEdit(index, false);
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
              updateEdit(index, true);
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
