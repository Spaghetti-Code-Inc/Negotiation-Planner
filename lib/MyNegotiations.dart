///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/StartNewNegotiation.dart';

import 'Start.dart';

class MyNegotiations extends StatefulWidget {
  const MyNegotiations({Key? key}) : super(key: key);

  @override
  State<MyNegotiations> createState() => _MyNegotiationsState();
}

class _MyNegotiationsState extends State<MyNegotiations> {
  String? id = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          elevation: 4,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff000000),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            "My Negotiations",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xffffffff),
            ),
          ),
          leading: const Icon(
            Icons.sort,
            color: Color(0xffffffff),
            size: 24,
          ),
        ),
        // TODO: Find out how to set issues
        body: Column(
          children: [
            // Makes the stream fill 80% of the screen at most
            Container(
              height: .80 * MediaQuery.of(context).size.height,
              child: StreamBuilder(
                // Gets the users collection with their negotiations.
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(id)
                    .collection('Negotiations')
                    .snapshots(),
                builder: (context, snapshot) {
                  // If there is no negotiations to the user
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Add A New Negotiation'));
                  }
                  // Shows the users negotiations based, runs on the negotiation container widget
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot? docSnapshot =
                          snapshot.data?.docs[index];

                      return NegotiationContainer(
                          negotiation: docSnapshot, docIndex: index);
                    },
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*.9,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StartNewNegotiation())
                  );
                },
                child: Text("Prepare For New Negotiation"),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff838383),
                  primary: Colors.white,
                )

              )
            )

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

  NegotiationContainer(
      {Key? key, required this.negotiation, required this.docIndex})
      : super(key: key);
  _NegotiationContainerState createState() => _NegotiationContainerState();
}

class _NegotiationContainerState extends State<NegotiationContainer> {

  bool isHover = false;
  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(
            top: (isHover) ? 18 : 20,
            bottom: !(isHover) ? 18 : 20,
            right: (isHover) ? 20 : 30,
            left: !(isHover) ? 20 : 30),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.negotiation!["title"],
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.negotiation!["summary"],
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Most important issue",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Second important issue",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Third issue",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {},
                          color: const Color(0xff838383),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          textColor: const Color(0xffffffff),
                          height: 45,
                          minWidth: 140,
                          child: const Text(
                            "View",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {
                            // Deletes the document
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.id)
                                .collection('Negotiations')
                                .doc(widget.negotiation?.id)
                                .delete();
                          },
                          color: const Color(0xff838383),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          textColor: const Color(0xffffffff),
                          height: 45,
                          minWidth: 140,
                          child: const Text(
                            "Delete",
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
          ),
          onTap: () {},
          onHover: (val) {
            setState(() {
              isHover = val;
            });
            log(val.toString());
          },
          /*val--->true when user brings in mouse
         val---> false when brings out his mouse*/
        ));
  }
}
