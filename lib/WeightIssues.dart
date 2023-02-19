///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:negotiation_tracker/IssueValues.dart';
import 'package:negotiation_tracker/Utils.dart';
import 'main.dart';

class WeightIssues extends StatefulWidget {
  const WeightIssues({super.key});

  State<WeightIssues> createState() => _WeightIssuesState();
}

class _WeightIssuesState extends State<WeightIssues> {
  bool iconColor = false;

  List<String>? _issueNames =
      currentNegotiation.issues["issueNames"]?.keys.toList(growable: true);

  List<TextEditingController> _controllers = [TextEditingController()];

  int totalVal = 0;
  int total(){
    int total = 0;
    for(TextEditingController cont in _controllers){
      try{
        total += int.parse(cont.text);
      } on FormatException catch (_){};

    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    int? length = _issueNames?.length;
    for(int i = 0; i < length!; i++){
      _controllers.add(new TextEditingController());
    }

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
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x7f000000), width: 1),
            ),
            child: Row(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 0, 0, 0),
                    child: Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Step 2/3",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          fontSize: 28,
                          color: Color(0xff000000),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 8, 0, 0),
                    child: Text(
                      "Weight The Issues",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ],
              )),
              Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    color: iconColor ? Colors.black : Color(0xFF3B66B7),
                    onPressed: () {
                      setState(() {
                        iconColor = true;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Weight The Issues'),
                          content: const Text(
                              'Allocate a number of points for each issue. Give a higher number'
                              ' of points to more important issues.'),
                          actions: [
                            TextButton(
                              child: const Text('Okay'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    iconSize: 40,
                  )),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0x9a000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                    border: Border.all(color: Color(0x4d9e9e9e), width: 0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Issues",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 25,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0x99000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Points",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 25,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child:           Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Total Points: " + totalVal.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  )
              ),
            ),
          ),



          Expanded(
            child: ListView.builder(
              itemCount: _issueNames?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            _issueNames![index],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      // Sets slight area between points and issue column
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        child: Center(
                            child: TextFormField(
                              onChanged: (newVal) {
                                totalVal = total();
                              } ,
                          keyboardType: TextInputType.number,
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            enabledBorder: (OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            )),
                          ),
                        )),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),

          // Start of bottom buttons
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
                    color: const Color(0xff4d4d4d),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Color(0xff808080), width: 1),
                    ),
                    padding: const EdgeInsets.all(16),
                    textColor: const Color(0xffffffff),
                    height: 40,
                    minWidth: 140,
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: () {
                      if(totalVal == 100){
                        // length represents _issueNames
                        for(int i = 0; i < length; i++){
                          print(_issueNames![i]);
                          currentNegotiation.issues["issueNames"]?[_issueNames![i]]?.putIfAbsent("relativeValue", () => _controllers[i].text);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => IssueValues()),
                        );
                      }
                      else{
                        Utils.showSnackBar("Total must equal exactly 100.");
                      }
                    },
                    color: const Color(0xff4d4d4d),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Color(0xff808080), width: 1),
                    ),
                    padding: const EdgeInsets.all(16),
                    textColor: const Color(0xffffffff),
                    height: 40,
                    minWidth: 140,
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
