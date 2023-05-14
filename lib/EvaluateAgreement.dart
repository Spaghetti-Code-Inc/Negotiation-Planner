import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'NegotiationDetails.dart';
import 'ViewNegotiation.dart';
import 'main.dart';


class EvaluateAgreement extends StatefulWidget {
  DocumentSnapshot<Object?>? negotiation;
  String docId;
  EvaluateAgreement({Key? key, required this.negotiation, required this.docId}) : super(key: key);

  @override
  State<EvaluateAgreement> createState() => _EvaluateAgreementState();
}

class _EvaluateAgreementState extends State<EvaluateAgreement> {
  late Negotiation negotiationSnap = Negotiation.fromFirestore(widget.negotiation);
  bool working = false;

  // Booleans to check whether or not the issue is being edited
  late var issueEdits = Map.fromIterable(negotiationSnap.issues.keys, value: (i) => false);
  // Values used to keep track of where slider was before editing
  late var lastIssueVals = Map.fromIterable(negotiationSnap.issues.keys, value: (i) => 0.0);
  // Values the sliders are changing
  late var issueVals = Map.fromIterable(
    negotiationSnap.issues.keys,
    value: (i){
      if(negotiationSnap.issues[i]["currentAgreement"].runtimeType != double){
        negotiationSnap.issues[i]["currentAgreement"] = 50.0;
        return 50.0;
      }
      else return negotiationSnap.issues[i]["currentAgreement"];
    }
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TopBar(negotiation: negotiationSnap, id: widget.docId, snapshot: widget.negotiation),
      body: SingleChildScrollView(
        child: Column(children: [
          // Track Progress Text
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 12),
            padding: EdgeInsets.only(),
            child:
                Text("Track Progress", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          ),

          // Divider
          Divider(
            thickness: 3,
            color: Colors.black,
          ),

          // Padding between divider and issues
          Container(margin: EdgeInsets.only(bottom: 15)),

          // Sliders changing issue values
          Container(
            height: negotiationSnap.cpIssues.keys.length * 80,
            child: ListView.builder(
              itemCount: negotiationSnap.cpIssues.keys.length,
              itemBuilder: (context, index) {
                var issueName = negotiationSnap.issues.keys.elementAt(index);
                return EvaluateSlider(negotiation: negotiationSnap, index: index, editing: issueEdits[issueName]!, handleEdits: handleEdits, issueValues: issueVals,);
              },
            ),
          ),

          // Contains "Total User and Counterpart Values"
          Container(
            width: MediaQuery.of(context).size.width*.85,
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


          // Header for entire negotiation value for user
          Container(
            width: MediaQuery.of(context).size.width*.85,
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

          // Slider for Entire Negotiation Value
          Container(
              width: MediaQuery.of(context).size.width * .95,
              child: Slider(
                activeColor: Colors.blue,
                inactiveColor: Colors.red,
                value: .5,
                onChanged: (double value) {
                  value = value;
                },
              )),

          // Header for entire negotiation value for Counter part
          Container(
            width: MediaQuery.of(context).size.width*.85,
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

          // Slider for Entire Negotiation Value
          Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width * .95,
              child: Slider(
                activeColor: Colors.red,
                inactiveColor: Colors.blue,
                value: .5,
                onChanged: (double value) {
                  value = value;
                },
              )),

          // Calculate Current Negotiation Value
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Calculate"),
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
  handleEdits(String name, bool save){

    /// Switches state of the issue that sent edit
    setState(() {
      issueEdits[name] = !issueEdits[name]!;
    });

    /// Means user just pressed discard or save
    if(!issueEdits[name]!){
      // Discard
      if(!save){
        // Resets the issue value because they were discarded
        setState(() {
          issueVals[name] = lastIssueVals[name];
        });
      }
      // Save
      else{
        // Give negotiationSnap the values from the sliders
        negotiationSnap.issues[name]["currentAgreement"] = issueVals[name];

        // Upload the negotiation snap
        FirebaseFirestore.instance
            .collection("users")
            .doc(negotiationSnap.id)
            .collection("Negotiations")
            .doc(widget.negotiation?.id)
            .set(negotiationSnap.toFirestore());
      }
    }
    /// Means user just pressed 'edit'
    else {
      // Makes a copy of where the issue values were before editing
      lastIssueVals[name] = issueVals[name];
    }

  }

  // So the update agreement - flag and save/discard buttons - can reset the page
  refresh() {
    setState(() {});
  }
}


/// Produces slider that changes the value of the "currentAgreement"
class EvaluateSlider extends StatefulWidget {
  Negotiation negotiation;
  int index;
  bool editing;
  Function handleEdits;
  var issueValues;

  EvaluateSlider({Key? key, required this.negotiation, required this.index, required this.editing, required this.handleEdits, required this.issueValues}) : super(key: key);

  @override
  State<EvaluateSlider> createState() => _EvaluateSliderState();
}
class _EvaluateSliderState extends State<EvaluateSlider> {
  late String issueName = widget.negotiation.issues.keys.elementAt(widget.index);
  late Map issues = widget.negotiation.issues[issueName];

  @override
  Widget build(BuildContext context) {
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
                ButtonAddonTrackProgress(editing: widget.editing, handleEdits: widget.handleEdits, name: issueName,),

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
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ),
          Slider(
            min: 0.0,
            max: 100.0,
            inactiveColor: Colors.red,
            value: widget.issueValues[issueName],
            divisions: 100,
            label: '${widget.issueValues[issueName].round()}',
            onChanged: (value) {
              if (widget.editing) {
                setState(() {
                  widget.issueValues[issueName] = value;
                });
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
  String name;

  ButtonAddonTrackProgress({Key? key, required this.editing, required this.handleEdits, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Edit Issue Button
    if(!editing){
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
          onPressed: () { handleEdits(name, false); },
          padding: EdgeInsets.all(0),
        ),
      );
    }
    else{
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
            onPressed: () { handleEdits(name, false); },
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
            onPressed: () { handleEdits(name, true); },
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
  String id;

  TopBar({Key? key, required this.negotiation, required this.id, required this.snapshot})
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
        icon: Icon(Icons.format_list_bulleted_sharp, size: 24),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewNegotiation(negotiation: snapshot)));
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
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(negotiation.id)
                          .collection("Negotiations")
                          .doc(id)
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
    );
  } //widget

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
