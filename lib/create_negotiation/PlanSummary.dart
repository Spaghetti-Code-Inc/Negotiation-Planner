import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/view_and_track_negotiations/MyNegotiations.dart';
import 'package:negotiation_tracker/view_and_track_negotiations/view_delivered_issue.dart';
import 'package:negotiation_tracker/view_and_track_negotiations/view_whole_negotiation.dart';

import '../NegotiationDetails.dart';
import '../main.dart';

class PlanSummary extends StatelessWidget {
  const PlanSummary({super.key});

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x54797979), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    "Plan Summary",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 28,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                /// Bookmarks icon - never found something to do with this
                // IconButton(
                //   icon: const Icon(Icons.bookmark_outline),
                //   onPressed: () {},
                //   color: const Color(0xff212435),
                //   iconSize: 24,
                // ),
              ],
            ),
          ),

          // Start of content on page
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "1. Bargaining Range for Entire Negotiation",
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
                    Container(
                      child: ViewNegotiationCurrent(
                        negotiation: currentNegotiation,
                        refresh: (){},
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "2. Bargaining Range for Each Issue",
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
                        ],
                      ),
                    ),


                    /// Contains The Issue Sliders
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: currentNegotiation.issues.length,
                      itemBuilder: (context, index) {
                        /// The current Issue that this builder mentions
                        Issue issueHere = currentNegotiation.issues[index];

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
                              ],
                            ),
                          ),

                          /// Issue Sliders
                          ViewCurrentIssues(
                            issue: issueHere,
                            refresh: (){},
                          ),
                        ]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Next and back buttons
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0x00ffffff),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x00ffffff), width: 0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: const Color(0xffffffff),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Color(0xff0A0A5B), width: 1),
                      ),
                      padding: const EdgeInsets.all(16),
                      textColor: const Color(0xff0A0A5B),
                      height: 40,
                      minWidth: 140,
                      child: const Icon(Icons.arrow_back)),
                ),
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                      onPressed: () async {

                        for (Issue each in currentNegotiation.issues){
                          each.currentValue = (each.relativeValue/2).truncate();
                        }

                        // Adds the current negotiation to the correct user
                        db
                            .collection(FirebaseAuth.instance.currentUser!.uid)
                            .add(currentNegotiation.toFirestore());

                        // Resets the current negotiation
                        currentNegotiation = Negotiation.fromNegotiation(
                            title: '', issues: [], target: -1, resistance: -1);

                        navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyNegotiations()),
                        );
                      },
                      color: const Color(0xffffffff),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Color(0xff0A0A5B), width: 1),
                      ),
                      padding: const EdgeInsets.all(16),
                      textColor: const Color(0xff0A0A5B),
                      height: 40,
                      minWidth: 140,
                      child: const Icon(Icons.arrow_forward)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
