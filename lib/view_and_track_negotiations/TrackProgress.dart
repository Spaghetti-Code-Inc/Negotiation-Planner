import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/multi_thumb_slider/multi_thumb_slider.dart';
import 'package:negotiation_tracker/view_and_track_negotiations/track_progress_sliders.dart';
import 'package:negotiation_tracker/view_negotiation_infobuttons.dart';

import '../NegotiationDetails.dart';
import 'ViewNegotiation.dart';
import '../main.dart';

class TrackProgress extends StatefulWidget {
  DocumentSnapshot<Object?>? negotiation;

  TrackProgress({Key? key, required this.negotiation}) : super(key: key);

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress> {
  late Negotiation negotiationSnap = Negotiation.fromFirestore(widget.negotiation);
  late String docId = widget.negotiation!.id;

  // Keeps track of new value for issue, .5 because that is half way in the slider
  late List<double> issueVals = [];
  // Keeps track of old value for issue, .5 because that is half way in the slider
  late List<double> lastIssueVals = [];

  bool editing = false;


  @override
  void initState() {
    for (int i = 0; i < negotiationSnap.issues.length; i++) {
      // Checks if initiated value is too high
      if(negotiationSnap.issues[i].currentValue! >= negotiationSnap.issues[i].relativeValue){
        issueVals.add(negotiationSnap.issues[i].relativeValue/2);
        lastIssueVals.add(negotiationSnap.issues[i].relativeValue/2);
      } else {
        issueVals.add(negotiationSnap.issues[i].currentValue!);
        lastIssueVals.add(negotiationSnap.issues[i].currentValue!);
      }

    }
  }

  late var totalValues = {"userValue": 0.0, "cpValue": 0.0};

  @override
  Widget build(BuildContext context) {
    /// Builds the values for the slider that shows the entire negotiation values
    /// And builds the values for the current issueVals
    totalValues["userValue"] = 0.0;
    totalValues["cpValue"] = 0.0;
    editing = false;

    for (int i = 0; i < negotiationSnap.issues.length; i++) {
      Issue thisIssue = negotiationSnap.issues[i];
      /// Calculates total values for user and cp based based on percentage of relative value filled
      totalValues["userValue"] = issueVals[i] * thisIssue.relativeValue * .0001 + totalValues["userValue"]!;
      totalValues["cpValue"] = (100 - issueVals[i]) * 0 * .0001 + totalValues["cpValue"]!;

      /// checks if the issue is currently being edited or not
      if(issueVals[i] != lastIssueVals[i]) editing = true;
    }

    return Scaffold(
      appBar: TopBar(negotiation: negotiationSnap, docId: docId, snapshot: widget.negotiation),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                /// Track Progress Text
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 12),
                  padding: EdgeInsets.only(),
                  child:
                      Text("Track Progress", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                ),
                /// Divider
                Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
                /// Padding between divider and issues
                Container(margin: EdgeInsets.only(bottom: 15)),

                /// Contains "Bargaining Range for Individual Issues"
                Container(
                  width: MediaQuery.of(context).size.width * .85,
                  padding: EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Current Value for Individual Issues",
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

                /// New Sliders
                Container(
                  width: MediaQuery.of(context).size.width*.85,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: negotiationSnap.issues.length,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index){
                      Issue here = negotiationSnap.issues[index];
                      return TrackSliderProgress(
                        issue: here,
                        vals: issueVals,
                        index: index,
                        refresh: refresh,
                      );
                    },
                  )
                ),

                /// Contains "Total User and Counterpart Values"
                Container(
                  width: MediaQuery.of(context).size.width * .85,
                  padding: EdgeInsets.only(top: 25, bottom: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Overall Negotiation Rating",
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

                /// Header for entire negotiation value for user
                Container(
                  width: MediaQuery.of(context).size.width * .85,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Your Total Value",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 22,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),

                      /// Info Button
                      TotalValueInfo(
                        userValue: totalValues["userValue"]!,
                        counterPartValue: totalValues["cpValue"]!,
                        negotiation: negotiationSnap,
                      )
                    ],
                  ),
                ),


                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: MultiThumbSlider(
                    valuesChanged: (List<double> values) {},
                    initalSliderValues: [0, double.parse(totalValues["userValue"].toString()), 1],
                    thumbBuilder: (BuildContext context, int index, double value) {
                      return IssueThumbs(index: index, letter: "T", value: value, multiplier: .01);
                    },
                    height: 70,
                  )
                ),
              ]),
            ),
          ),

          ViewSaveDiscard(
            negotiationSnap: negotiationSnap,
            lastIssueVals: lastIssueVals,
            issueVals: issueVals,
            editing: editing,
            refresh: refresh,
            save: save,
          ),

          // Exit the negotiation button
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

  // So the update agreement - flag and save/discard buttons - can reset the page
  refresh() {
    setState(() {});
  }

  save() {
    String? id = FirebaseAuth.instance.currentUser?.uid;

    FirebaseFirestore.instance
        .collection(id!)
        .doc(docId)
        .set(negotiationSnap.toFirestore());
  }
}

/// Editable slider info
class SliderInfo extends StatelessWidget {
  double sliderValue;
  String issueName;
  Negotiation negotiationSnap;

  SliderInfo(
      {Key? key,
      required this.sliderValue,
      required this.issueName,
      required this.negotiationSnap});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          showInfoTrackProgress(context, issueName, sliderValue, negotiationSnap);
        },
        padding: EdgeInsets.all(0),
      ),
    );
  }
}

/// Total Value slider info
class TotalValueInfo extends StatelessWidget {
  double userValue;
  double counterPartValue;
  Negotiation negotiation;

  TotalValueInfo(
      {Key? key,
      required this.userValue,
      required this.counterPartValue,
      required this.negotiation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          showTotalInfoTrackProgress(context, userValue, counterPartValue, negotiation);
        },
        padding: EdgeInsets.all(0),
      ),
    );
  }
}

/// Keep track of save, reset, and calculate button
class ViewSaveDiscard extends StatefulWidget {

  Negotiation negotiationSnap;
  bool editing;
  List<double> issueVals;
  List<double> lastIssueVals;
  Function refresh;
  Function save;

  ViewSaveDiscard({Key? key, required this.refresh, required this.save, required this.negotiationSnap, required this.editing, required this.issueVals, required this.lastIssueVals}) : super(key: key);

  @override
  State<ViewSaveDiscard> createState() => _ViewSaveDiscardState();
}

class _ViewSaveDiscardState extends State<ViewSaveDiscard> {
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
                    for(int i = 0; i < widget.issueVals.length; i++){
                      widget.issueVals[i] = widget.lastIssueVals[i];
                    }
                    setState(() {
                      widget.editing = false;
                    });

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
                    for(int i = 0; i < widget.negotiationSnap.issues.length; i++){
                      widget.negotiationSnap.issues[i].currentValue = widget.issueVals[i];
                      widget.lastIssueVals[i] = widget.issueVals[i];
                    }

                    setState(() {
                      widget.editing = false;
                    });

                    widget.save();
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

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  DocumentSnapshot<Object?>? snapshot;
  Negotiation negotiation;
  String docId;

  TopBar({Key? key, required this.negotiation, required this.docId, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      centerTitle: true,
      backgroundColor: const Color(0xff0A0A5B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      title: Text(
        negotiation.title,
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
              title: const Text('Are you sure you\'d like to delete the negotiation?'),
              actions: [
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    String? id = FirebaseAuth.instance.currentUser?.uid;
                    FirebaseFirestore.instance.collection(id!).doc(docId).delete();
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
          icon: Icon(Icons.format_list_bulleted_sharp, size: 24),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewNegotiation(negotiation: snapshot)));
          },
        ),
      ],
    );
  } //widget

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
