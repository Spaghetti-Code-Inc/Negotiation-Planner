///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/StartNewNegotiation.dart';

import 'EvaluateAgreement.dart';
import 'NegotiationDetails.dart';
import 'ViewNegotiation.dart';

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
                  Navigator.popUntil(context, (route) => true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StartNewNegotiation())
                  );
                },
                child: Text("Prepare For New Negotiation"),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff838383),
                  foregroundColor: Colors.white,
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

    Color _bottomColor = Color(0xff0A0A5B);
    Color _mainColor = Colors.white;
    Color _topTextColor = Color(0xff000000);

    Map<String, dynamic> issueField = widget.negotiation?.get("issues");

    // Find the 3 most important issues
    List<String>? _issueNames =
    issueField.keys.toList(growable: true);

    List<int> _issueImportance = [];

    int? length = _issueNames.length;
    for(int i = 0; i < length; i++){
      _issueImportance.add(int.parse(issueField[_issueNames[i]]["relativeValue"]));
    }

    List<String> vals = ["", "", ""];

    // If only 1 issue
    if(_issueNames.length == 1){
      vals[0] = _issueNames[0];
    }
    // If two issues
    else if(_issueNames.length == 2){
      if(_issueImportance[0] > _issueImportance[1]){
        vals[0] = _issueNames[0];
        vals[1] = _issueNames[1];
      }
      else{
        vals[0] = _issueNames[1];
        vals[1] = _issueNames[0];
      }
    }
    // If 3 or more issues
    else{
      int max1 = 0;
      int max2 = 0;
      int max3 = 0;
      // Finds the highest three values
      for(int i = 0; i < length; i++){
        if(_issueImportance[i] > max1) {
          if(max1 > max2){
            if(max2 > max3){
              max3 = max2;
              vals[2] = vals[1];
            }
            max2 = max1;
            vals[1] = vals[0];
          }
          max1 = _issueImportance[i];
          vals[0] = _issueNames[i];
        }
        else if(_issueImportance[i] > max2){
          if(max2 > max3){
            max3 = max2;
            vals[2] = vals[1];
          }
          max2 = _issueImportance[i];
          vals[1] = _issueNames[i];
        }
        else if (_issueImportance[i] > max3){
          max3 = _issueImportance[i];
          vals[2] = _issueNames[i];
        }
      }
    }

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
              color: _mainColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),

              boxShadow: [
                BoxShadow(
                  color: _bottomColor,
                  offset: const Offset(
                    3.0,
                    3.0,
                  ),
                  blurRadius: 5.0,
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
                  Padding(
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.negotiation!["summary"] + "\n",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        vals[0],
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
                        vals[1],
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
                        vals[2],
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewNegotiation(negotiation: widget.negotiation))
                            );
                          },
                          color: _bottomColor,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          textColor: const Color(0xffffffff),
                          height: 45,
                          minWidth: 140,
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
                      Container(width: 1,),
                      // Track Progress
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {
                            String name = widget.negotiation!.id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EvaluateAgreement(
                                      negotiation: widget.negotiation, docId: name)),
                            );
                          },
                          color: _bottomColor,
                          elevation: 0,
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