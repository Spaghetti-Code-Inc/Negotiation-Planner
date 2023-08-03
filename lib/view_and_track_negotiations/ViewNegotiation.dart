import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/view_and_track_negotiations/view_negotiation_infobuttons.dart';

import 'TrackProgress.dart';
import '../NegotiationDetails.dart';
import 'view_delivered_issue.dart';
import 'view_whole_negotiation.dart';


Map<int, String> alphabet = {0: "A", 1: "B", 2: "C", 3:"D", 4:"F"};



class ViewNegotiation extends StatefulWidget {
  Negotiation negotiation;
  String docId;
  // Keep track of the "Whole Negotiation" values
  late List lastNegotiationVals = [0, negotiation.resistance, negotiation.target, 100];

  ViewNegotiation({Key? key, required this.negotiation, required this.docId}) : super(key: key);

  @override
  State<ViewNegotiation> createState() => _ViewNegotiationState();
}

class _ViewNegotiationState extends State<ViewNegotiation> {
  late Negotiation negotiationSnap = widget.negotiation;

  // Keeps track of old value for issue
  late List<List<int>> issueVals = [];

  bool editing = false;

  @override
  void initState() {
    for (int i = 0; i < negotiationSnap.issues.length; i++){

      issueVals.add([]);

      Map<String, dynamic> issue = negotiationSnap.issues[i].issueVals;

      for(int j = 0; j < 5; j++){
        String letter = alphabet[j]!;
        issueVals[i].add(issue[letter][0]);
      }
    }
  }

  Color navyBlue = Color(0xff0A0A5B);

  @override
  Widget build(BuildContext context) {

    editing = false;
    for (int i = 0; i < negotiationSnap.issues.length; i++){
      Map<String, dynamic> issue = negotiationSnap.issues[i].issueVals;

      for(int j = 0; j < 5; j++){
        String letter = alphabet[j]!;
        if(issueVals[i][j].toString() != issue[letter][0].toString()) {
          editing = true;
        }
      }
    }
    if(!editing){

      if(widget.lastNegotiationVals[1] != negotiationSnap.resistance) editing = true;
      if(widget.lastNegotiationVals[2] != negotiationSnap.target) editing = true;
    }


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
                      db.collection(id!).doc(widget.negotiation.id).delete();
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

              if(editing){
                checkSwitch(context, negotiationSnap, widget.docId);
              } else {
                Navigator.pop(context);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      TrackProgress(negotiation: negotiationSnap, docId: widget.docId,)),
                );
              }
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
                            "Overall Negotiation",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  /// Sliders for the Whole Negotiation
                  ViewNegotiationCurrent(
                    negotiation: negotiationSnap,
                    refresh: refresh,
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
                                  issueHere.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 22,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),

                              /// Buttons on right side
                              // ButtonAddons(
                              //   editing: issueEdits[index],
                              //   index: index,
                              //   updateEdit: updateEdit,
                              //   showInfo: showInfo,
                              // ),
                            ],
                          ),
                        ),

                        /// Issue Sliders
                        ViewCurrentIssues(
                          issue: issueHere,
                          refresh: refresh,
                        ),
                      ]);
                    },
                  ),

                ]),
              ),
            ),
          ),


          ViewSaveDiscardRubric(
            negotiationSnap: negotiationSnap,
            lastVals: issueVals,
            editing: editing,
            refresh: refresh,
            save: save,
            lastFullVals: widget.lastNegotiationVals,
          ),


          /// Exit the negotiation button
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: 40,
            margin: EdgeInsets.only(bottom: 20),
            child: TextButton(
              onPressed: () {
                if(editing) checkExit(context);
                else Navigator.pop((context));
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

  checkSwitch(context, negotiation, docId){
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("You have unsaved values, are you sure you want to exit?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No")
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TrackProgress(negotiation: negotiation, docId: docId,)));

            },
            child: Text("Yes"),
          ),
        ],
      ),

    );
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

  refresh(){
    setState(() {});
  }

  save() {
    String? id = FirebaseAuth.instance.currentUser?.uid;

    FirebaseFirestore.instance
        .collection(id!)
        .doc(widget.docId)
        .set(negotiationSnap.toFirestore());
  }
}

class ViewSaveDiscardRubric extends StatefulWidget {
  bool editing;
  Function save;
  Function refresh;

  List<List> lastVals;
  List lastFullVals;
  Negotiation negotiationSnap;

  ViewSaveDiscardRubric({Key? key, required this.editing, required this.lastFullVals, required this.save, required this.refresh,
    required this.lastVals, required this.negotiationSnap,
  }) : super(key: key);

  @override
  State<ViewSaveDiscardRubric> createState() => _ViewSaveDiscardRubricState();
}

class _ViewSaveDiscardRubricState extends State<ViewSaveDiscardRubric> {
  @override
  Widget build(BuildContext context) {
    if(widget.editing){
      return Container(
        width: MediaQuery.of(context).size.width * .9,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10, right: 5),
                height: 40,
                child: TextButton(
                  onPressed: () {
                    for (int i = 0; i < widget.negotiationSnap.issues.length; i++){
                      Map<String, dynamic> issue = widget.negotiationSnap.issues[i].issueVals;

                      for(int j = 0; j < 5; j++){
                        String letter = alphabet[j]!;
                        issue[letter][0] = widget.lastVals[i][j];
                      }
                    }

                    widget.negotiationSnap.resistance = widget.lastFullVals[1];
                    widget.negotiationSnap.target = widget.lastFullVals[2];

                    widget.refresh();
                  },
                  child: Text(
                      "Discard Values"
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: navyBlue,
                    foregroundColor: Colors.white,
                    elevation: 5,
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
                    for (int i = 0; i < widget.negotiationSnap.issues.length; i++){
                      Map<String, dynamic> issue = widget.negotiationSnap.issues[i].issueVals;

                      for(int j = 0; j < 5; j++){
                        String letter = alphabet[j]!;
                        widget.lastVals[i][j] = issue[letter][0];
                      }
                    }

                    widget.lastFullVals[1] = widget.negotiationSnap.resistance;
                    widget.lastFullVals[2] = widget.negotiationSnap.target;

                    widget.save();
                    widget.refresh();
                  },
                  child: Text(
                      "Save Values"
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: navyBlue,
                    foregroundColor: Colors.white,
                    elevation: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Container(
        width: MediaQuery.of(context).size.width*.9,
        margin: EdgeInsets.only(bottom: 10, right: 5),
        height: 40,
        child: TextButton(
          onPressed: () {
            print("Show Calculate Screen");
          },
          child: Text(
              "View Total Negotiation"
          ),
          style: TextButton.styleFrom(
            backgroundColor: navyBlue,
            foregroundColor: Colors.white,
            elevation: 5,
          ),
        ),
      );
    }
  }
}
