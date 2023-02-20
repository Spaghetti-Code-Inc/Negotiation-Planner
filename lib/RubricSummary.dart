///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:negotiation_tracker/CpsRubrik.dart';

import 'main.dart';

class RubricSummary extends StatelessWidget {
  const RubricSummary({super.key});

  @override
  Widget build(BuildContext context) {

    //TODO What to do if there are not 3 issues

    // Find the 3 most important issues
    List<String>? _issueNames =
      currentNegotiation.issues["issueNames"]?.keys.toList(growable: true);

    List<int> _issueImportance = [];


    int? length = _issueNames?.length;
    for(int i = 0; i < length!; i++){
      _issueImportance.add(int.parse(currentNegotiation.issues["issueNames"]![_issueNames![i]]["relativeValue"]));
      print(_issueImportance[i]);
    }

    int max1 = 0;
    int max2 = 0;
    int max3 = 0;

    for(int i = 0; i < length; i++){
      if(_issueImportance[i] > _issueImportance[max1]) max1 = i;
    }
    for(int i = 0; i < length; i++){
      if(_issueImportance[i] > _issueImportance[max2] && i != max1) max2 = i;
    }
    for(int i = 0; i < length; i++){
      if(_issueImportance[i] > _issueImportance[max3] && i != max1 && i != max2) max3 = i;
    }

    print(max1.toString() + ", " + max2.toString() + ", " + max3.toString());


    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: const PrepareBar(),
        body: Column(children: [
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
                    color: const Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border:
                        Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
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
                              fontSize: 28,
                              color: Color(0xff000000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              "Based on your decisions on this tool, the 3 most important issues to you are listed below.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Text(
                            _issueNames![max1],
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            _issueNames[max2],
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            _issueNames[max3],
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Be especially certain to have strong arguments to justify your preferred settlement on these issues (like relevant salary survey data, etc.)",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xff000000),
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
                                fontSize: 18,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ])
    );
  }
}
