///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import '../Utils.dart';

import '../main.dart';
import 'PlanSummary.dart';

class RubricSummary extends StatelessWidget {
  const RubricSummary({super.key});

  @override
  Widget build(BuildContext context) {
    var vals = Utils.findHighestValuedIssues(currentNegotiation.issues);


    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border:
                        Border.all(color: const Color(0x4d9e9e9e), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Rubric Summary",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                color: Color(0xFF1E2027),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Text(
                                "Based on your decisions on this tool, the most important issues to you are listed below.",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xFF1E2027),
                                ),
                              ),
                            ),

                            // Displays the important issues
                            DisplayImportantIssues(vals: vals),

                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Text(
                                "Be especially certain to have strong arguments to justify your preferred settlement on these issues (like relevant salary survey data, etc.)",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xFF1E2027),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                "Strive to reach an agreement that improves upon your current offer, using your BATNA as a helpful frame of reference. You should be able to negotiate an agreement that exceeds the value of your BATNA and comes as close as you can to (or even eceeding) your target. ",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xFF1E2027),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlanSummary()),
                          );
                          // For sending to counter part
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) =>
                          //       AlertDialog(
                          //         title: const Text('Counter Parts Rubric'),
                          //         content: const Text(
                          //             "Consider the issues you identified earlier. How do you "
                          //                 "think your counter part would assign points to these issues?"),
                          //         actions: [
                          //           TextButton(
                          //             child: const Text('Next', style: TextStyle(color: Color(0xff0A0A5B))),
                          //             onPressed: () {
                          //
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          // );
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
          ),
        ],
      ),
    );
  }
}

class DisplayImportantIssues extends StatelessWidget {
  final List<String> vals;
  const DisplayImportantIssues({Key? key, required this.vals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only 1 issue : Only use 1 line for display
    if (vals[1] == "") {
      return Column(
        children: [
          Text(
            "1. " + vals[0],
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff0A0A5B),
            ),
          ),
        ],
      );
    }
    // Only 2 issues: Only use 2 lines for display
    else if (vals[2] == "") {
      return Column(
        children: [
          Text(
            "1: " + vals[0],
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff0A0A5B),
            ),
          ),
          Text(
            "2: " + vals[1],
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff0A0A5B),
            ),
          ),
        ],
      );
    }
    // All 3 main issues being used: Use 3 lines for display
    else {
      return Column(
        children: [
          Text(
            "1. " + vals[0],
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff0A0A5B),
            ),
          ),
          Text(
            "2: " + vals[1],
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff0A0A5B),
            ),
          ),
          Text(
            "3: " + vals[2],
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff0A0A5B),
            ),
          ),
        ],
      );
    }
  }
}
