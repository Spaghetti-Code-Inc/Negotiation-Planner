///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/MyNegotiations.dart';
import 'package:negotiation_tracker/ViewCurrentIssues.dart';
import 'package:negotiation_tracker/ViewNegotiationCurrent.dart';

import 'NegotiationDetails.dart';
import 'main.dart';

class PlanSummary extends StatelessWidget {
  const PlanSummary({super.key});

  @override
  Widget build(BuildContext context) {
    print(currentNegotiation.toString());
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
                IconButton(
                  icon: const Icon(Icons.bookmark_outline),
                  onPressed: () {},
                  color: const Color(0xff212435),
                  iconSize: 24,
                ),
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
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 128,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "1. Tradeoffs",
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: TextField(
                              controller: TextEditingController(),
                              obscureText: false,
                              textAlign: TextAlign.start,
                              maxLines: 5,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(color: Color(0xff000000), width: 1),
                                ),
                                hintText: "Enter Pros/Cons",
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                                filled: false,
                                fillColor: const Color(0xfff2f2f3),
                                isDense: false,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                              ),
                            ),
                          ),
                        ],
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
                    Container(
                      height: currentNegotiation.cpIssues.keys.length * 110,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: currentNegotiation.cpIssues.keys.length,
                        prototypeItem: ViewCurrentIssues(
                          issueName: currentNegotiation.cpIssues.keys.elementAt(0),
                          negotiation: currentNegotiation,
                          editing: false,
                          comesFromMyNegotiations: false,
                        ),
                        itemBuilder: (context, index) {
                          return ViewCurrentIssues(
                            issueName: currentNegotiation.cpIssues.keys.elementAt(index),
                            negotiation: currentNegotiation,
                            editing: false,
                            comesFromMyNegotiations: false,
                          );
                        },
                      ),
                    ),
                    Text(
                      "3. Bargaining Range for Entire Negotiation",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff000000),
                      ),
                    ),
                    Container(
                      child: ViewNegotiationCurrent(
                        negotiation: currentNegotiation,
                        editing: false,
                      ),
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
                        // Sets the user id to the negotiation instance
                        currentNegotiation.id = FirebaseAuth.instance.currentUser?.uid;

                        // Adds the current negotiation to the correct user
                        db
                            .collection("users")
                            .doc(currentNegotiation.id)
                            .collection("Negotiations")
                            .add(currentNegotiation.toFirestore());

                        // Resets the current negotiation
                        currentNegotiation = Negotiation.fromNegotiation(
                            title: '',
                            issues: {},
                            cpIssues: {},
                            cpBATNA: -1,
                            cpResistance: -1,
                            cpTarget: -1,
                            target: -1,
                            resistance: -1);

                        navigatorKey.currentState!.popUntil((route) => route.isFirst);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyNegotiations()),
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
