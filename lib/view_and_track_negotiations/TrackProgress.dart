import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  bool working = false;
  late String docId = widget.negotiation!.id;

  // Keeps track of new value for issue, .5 because that is half way in the slider
  late List<double> issueVals = [];
  // Keeps track of old value for issue, .5 because that is half way in the slider
  late List<double> lastIssueVals = [];
  // Keeps track if the issue is being edited or not
  late List<bool> issueEdits = List.filled(negotiationSnap.issues.length, false, growable: false);

  @override
  void initState() {
    for (int i = 0; i < negotiationSnap.issues.length; i++) {
      issueVals.add(negotiationSnap.issues[i].currentValue!);
      lastIssueVals.add(negotiationSnap.issues[i].currentValue!);
    }
  }

  late var totalValues = {"userValue": 0.0, "cpValue": 0.0};

  @override
  Widget build(BuildContext context) {
    /// Builds the values for the slider that shows the entire negotiation values
    /// And builds the values for the current issueVals
    totalValues["userValue"] = 0.0;
    totalValues["cpValue"] = 0.0;
    for (int i = 0; i < negotiationSnap.issues.length; i++) {
      Issue thisIssue = negotiationSnap.issues[i];

      /// Calculates total values for user and cp based based on percentage of relative value filled
      totalValues["userValue"] =
          issueVals[i] * thisIssue.relativeValue * .0001 + totalValues["userValue"]!;
      totalValues["cpValue"] = (100 - issueVals[i]) * 0 * .0001 + totalValues["cpValue"]!;
    }

    return Scaffold(
      appBar: TopBar(negotiation: negotiationSnap, docId: docId, snapshot: widget.negotiation),
      body: SingleChildScrollView(
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

          /// Sliders changing issue values
          Container(
            height: negotiationSnap.issues.length * 80,
            child: ListView.builder(
              itemCount: negotiationSnap.issues.length,
              itemBuilder: (context, index) {
                return EvaluateSlider(
                  negotiation: negotiationSnap,
                  index: index,
                  editing: issueEdits[index],
                  handleEdits: handleEdits,
                  issueValues: issueVals,
                  totalValues: totalValues,
                  reloadFullPage: () => setState(() {}),
                );
              },
            ),
          ),

          /// Contains "Total User and Counterpart Values"
          Container(
            width: MediaQuery.of(context).size.width * .85,
            padding: EdgeInsets.only(top: 25, bottom: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Total User and Counterpart Values",
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

          /// Slider for Entire Negotiation Value
          Container(
            width: MediaQuery.of(context).size.width * .95,
            child: Slider(
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
              value: double.parse(totalValues["userValue"].toString()),
              onChanged: (double value) {
                value = value;
              },
            ),
          ),

          /// Header for entire negotiation value for Counter part
          Container(
            width: MediaQuery.of(context).size.width * .85,
            margin: EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Counter Parts Total Value",
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

          /// Slider for Entire Negotiation Value Counterpart
          Container(
            margin: EdgeInsets.only(bottom: 30),
            width: MediaQuery.of(context).size.width * .95,
            child: Slider(
              activeColor: Colors.red,
              inactiveColor: Colors.blue,
              value: double.parse(totalValues["cpValue"].toString()),
              onChanged: (double value) {
                value = value;
              },
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * .9,
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                  "Calculate: " + (totalValues["userValue"]! + totalValues["cpValue"]!).toString()),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff838383),
                foregroundColor: Colors.white,
              ),
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
    );
  }

  /// Performs function of any 'edit', 'save', or 'discard' press
  handleEdits(int index, bool save) {
    /// Switches state of the issue that sent edit
    setState(() {
      issueEdits[index] = !issueEdits[index];
    });

    /// Means user just pressed discard or save
    if (!issueEdits[index]) {
      // Discard
      if (!save) {
        // Resets the issue value because they were discarded
        setState(() {
          issueVals[index] = lastIssueVals[index];
        });
      }
      // Save
      else {
        // Give negotiationSnap the values from the sliders
        negotiationSnap.issues[index].currentValue = issueVals[index];

        // Upload the negotiation snap
        String? id = FirebaseAuth.instance.currentUser?.uid;
        FirebaseFirestore.instance.collection(id!).doc(docId).set(negotiationSnap.toFirestore());
      }
    }

    /// Means user just pressed 'edit'
    else {
      // Makes a copy of where the issue values were before editing
      lastIssueVals[index] = issueVals[index];
    }

    /// Builds the values for the slider that shows the entire negotiation values
    totalValues["userValue"] = 0.0;
    totalValues["cpValue"] = 0.0;
    for (int i = 0; i < negotiationSnap.issues.length; i++) {
      Issue thisIssue = negotiationSnap.issues[i];

      totalValues["userValue"] =
          issueVals[i] * thisIssue.relativeValue * .0001 + totalValues["userValue"]!;
      totalValues["cpValue"] = (100 - issueVals[i]) * 0 * .0001 + totalValues["cpValue"]!;
    }
  }

  // So the update agreement - flag and save/discard buttons - can reset the page
  refresh() {
    print(currentNegotiation);
    setState(() {});
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

/// Produces slider that changes the value of the "currentAgreement"
class EvaluateSlider extends StatefulWidget {
  Negotiation negotiation;
  int index;
  bool editing;
  Function handleEdits;
  Function reloadFullPage;
  Map<String, double> totalValues;
  var issueValues;

  EvaluateSlider(
      {Key? key,
      required this.negotiation,
      required this.index,
      required this.editing,
      required this.handleEdits,
      required this.issueValues,
      required this.totalValues,
      required this.reloadFullPage})
      : super(key: key);

  @override
  State<EvaluateSlider> createState() => _EvaluateSliderState();
}

class _EvaluateSliderState extends State<EvaluateSlider> {
  late Issue issues = widget.negotiation.issues[widget.index];
  late String issueName = issues.name;

  @override
  Widget build(BuildContext context) {
    /// Builds the values for the slider that shows the entire negotiation values
    widget.totalValues["userValue"] = 0.0;
    widget.totalValues["cpValue"] = 0.0;
    for (int i = 0; i < widget.negotiation.issues.length; i++) {
      Issue thisIssue = widget.negotiation.issues[i];

      widget.totalValues["userValue"] = widget.issueValues[i] * thisIssue.relativeValue * .0001 +
          widget.totalValues["userValue"]!;
      widget.totalValues["cpValue"] =
          (100 - widget.issueValues[i]) * 0 * .0001 + widget.totalValues["cpValue"]!;
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width * .85,
            // Header Bar above issue slider
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

                /// Edit, Discard, Save
                ButtonAddonTrackProgress(
                    editing: widget.editing, handleEdits: widget.handleEdits, index: widget.index),

                /// Info Button
                SliderInfo(
                    issueName: issueName,
                    sliderValue: widget.issueValues[widget.index],
                    negotiationSnap: widget.negotiation),
              ],
            ),
          ),
          Slider(
            min: 0.0,
            max: 100.0,
            inactiveColor: Colors.red,
            value: widget.issueValues[widget.index],
            divisions: 100,
            label: '${widget.issueValues[widget.index].round()}',
            onChanged: (value) {
              if (widget.editing) {
                setState(() {
                  widget.issueValues[widget.index] = value;
                });
                widget.reloadFullPage();
              }
            },
          ),
        ]));
  }
}

/// Controls the edit, save, discard buttons for each issue
class ButtonAddonTrackProgress extends StatelessWidget {
  bool editing;
  Function handleEdits;
  int index;

  ButtonAddonTrackProgress(
      {Key? key, required this.editing, required this.handleEdits, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Edit Issue Button
    if (!editing) {
      return Container(
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
            handleEdits(index, false);
          },
          padding: EdgeInsets.all(0),
        ),
      );
    } else {
      return Row(children: [
        /// Discard
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
              handleEdits(index, false);
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
              handleEdits(index, true);
            },
            padding: EdgeInsets.all(0),
          ),
        ),
      ]);
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
