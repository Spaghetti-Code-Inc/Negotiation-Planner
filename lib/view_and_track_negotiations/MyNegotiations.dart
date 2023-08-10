import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/create_negotiation/StartNewNegotiation.dart';

import '../NegotiationDetails.dart';
import '../Utils.dart';
import 'TrackProgress.dart';
import 'ViewNegotiation.dart';

class MyNegotiations extends StatefulWidget {
  const MyNegotiations({Key? key}) : super(key: key);

  @override
  State<MyNegotiations> createState() => _MyNegotiationsState();
}

class _MyNegotiationsState extends State<MyNegotiations> {
  String? id = FirebaseAuth.instance.currentUser?.uid;
  Color navyBlue = Color(0xff0A0A5B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: navyBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "My Negotiations",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Colors.white,
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
          // Makes the stream fill 80% of the screen at most
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              shrinkWrap: true,
      children: [
                StreamBuilder(
                  // Gets the users collection with their negotiations.
                  stream: FirebaseFirestore.instance
                      .collection(FirebaseAuth.instance.currentUser!.uid)
                      .doc("data")
                      .collection("pinned")
                      .snapshots(),
                  builder: (context, snapshot) {
                    // If there is no negotiations to the user
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Add A New Negotiation'));
                    }
                    // Shows the users negotiations based, runs on the negotiation container widget
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot? docSnapshot =
                        snapshot.data?.docs[index];

                        return NegotiationContainer(
                          negotiation: docSnapshot, docIndex: index, pinned: true,);
                      },
                    );
                  },
                ),

                Divider(color: Colors.grey, thickness: 1,),

                StreamBuilder(
                  // Gets the users collection with their negotiations.
                  stream: FirebaseFirestore.instance
                      .collection(FirebaseAuth.instance.currentUser!.uid)
                      .doc("data")
                      .collection("regular")
                      .snapshots(),
                  builder: (context, snapshot) {
                    // If there is no negotiations to the user
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Add A New Negotiation'));
                    }
                    // Shows the users negotiations based, runs on the negotiation container widget
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot? docSnapshot =
                            snapshot.data?.docs[index];

                        return NegotiationContainer(
                            negotiation: docSnapshot, docIndex: index, pinned: false,);
                      },
                    );
                  },
                ),
              ]),
            ),

          Container(
              width: MediaQuery.of(context).size.width * .9,
              margin: EdgeInsets.only(bottom: 10),
              height: 40,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartNewNegotiation()));
                  },
                  child: Text("Prepare For New Negotiation"),
                  style: TextButton.styleFrom(
                    backgroundColor: navyBlue,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
              ),
          ),
        ],
      ),
    );
  }
}

class NegotiationContainer extends StatefulWidget {
  // Doc snapshot - has all doc data
  final DocumentSnapshot<Object?>? negotiation;
  // Which document the view represents
  final int docIndex;
  // User id of the doc
  final id = FirebaseAuth.instance.currentUser?.uid;

  final bool pinned;

  NegotiationContainer(
      {Key? key,
      required this.negotiation,
      required this.docIndex,
      required this.pinned})
      : super(key: key);
  _NegotiationContainerState createState() => _NegotiationContainerState();
}

class _NegotiationContainerState extends State<NegotiationContainer> {
  late Negotiation negotiationSnap =
      Negotiation.fromFirestore(widget.negotiation);
  late String docId = widget.negotiation!.id;

  var db = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid);


  @override
  Widget build(BuildContext context) {
    Color _bottomColor = Color(0xff0A0A5B);
    Color _mainColor = Colors.white;
    Color _topTextColor = Color(0xff000000);

    // List of issues, but the issues are still represented by a map
    List<dynamic> issueList = widget.negotiation?.get("issues");

    // Converts the issueList into a List<Issue>
    List<Issue> issues = [];
    issueList.forEach((map) => {issues.add(Issue.fromMap(map))});

    // Variable that holds the displayed names of top 3 issues
    List<String> names = Utils.findHighestValuedIssues(issues);

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: _mainColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 0.5,
            spreadRadius: 1.0,
          ), //BoxShadow//BoxShadow
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(children: [
              // Title
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.negotiation!["title"],
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: _topTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(right: 10),
                constraints: BoxConstraints(),
                onPressed: () {
                  if(widget.pinned) {
                    // delete old version
                    db.doc("data").collection("pinned")
                        .doc(widget.negotiation!.id).delete();

                    db
                        .doc("data").collection("regular")
                        .add(negotiationSnap.toFirestore());
                  } else {
                    // delete old version
                    db.doc("data").collection("regular")
                      .doc(widget.negotiation!.id).delete();

                    // Add new version to pinned
                    db
                        .doc("data").collection("pinned")
                        .add(negotiationSnap.toFirestore());
                  }
                },
                icon: Icon(
                  (widget.pinned) ? Icons.remove : Icons.add,
                  size: 28,
                ),

              ),
            ]),

            // Summary
            ShowSummary(
              summary: widget.negotiation!["summary"],
              color: _topTextColor,
            ),

            // Listed Issues
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Negotiation Issues: ",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: _topTextColor,
                  ),
                ),
              ),
            ),
            // Group of 3 most listed issues
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  names[0],
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: _topTextColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  names[1],
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: _topTextColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  names[2],
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: _topTextColor,
                  ),
                ),
              ),
            ),

            // View Rubric, Track Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // View Rubric
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewNegotiation(
                                    negotiation: negotiationSnap,
                                    docId: docId,
                                    pinned: widget.pinned,
                                  )));
                    },
                    color: _bottomColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                      ),
                    ),
                    textColor: Colors.white,
                    height: 45,
                    child: const Text(
                      "View Rubric",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                // White space between
                Container(
                  width: 1,
                ),
                // Track Progress
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackProgress(
                                  negotiation: negotiationSnap,
                                  docId: docId,
                                  pinned: widget.pinned,
                                )),
                      );
                    },
                    color: _bottomColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    textColor: Colors.white,
                    height: 45,
                    minWidth: 140,
                    child: const Text(
                      "Track Progress",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShowSummary extends StatelessWidget {
  final String? summary;
  final Color color;
  const ShowSummary({Key? key, required this.summary, required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (summary != "") {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            summary! + "\n",
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 14,
              color: color,
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
