
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../NegotiationDetails.dart';
import 'MAX_LENGTHS.dart';
import 'PlanSummary.dart';

import '../Utils.dart';
import '../main.dart';

class CpsRubrik extends StatefulWidget {
  CpsRubrik({super.key});

  @override
  State<StatefulWidget> createState() => _CpsRubrikState();

  int target = 0;
  int BATNA = 0;
  int resistance = 0;
}

class _CpsRubrikState extends State<CpsRubrik> {
  bool iconOne = false;
  bool iconTwo = false;
  bool iconThree = false;

  TextEditingController cpTargetController;
  TextEditingController cpBATNAController;
  TextEditingController cpResistanceController;

  _CpsRubrikState()
      : cpTargetController = new TextEditingController(text: currentNegotiation.cpTarget.toString()),
        cpBATNAController = new TextEditingController(text: currentNegotiation.cpBATNA.toString()),
        cpResistanceController = new TextEditingController(text: currentNegotiation.cpResistance.toString());

  List<int> points = List.filled(currentNegotiation.issues.length, 0);


  @override
  Widget build(BuildContext context) {
    if(points.length == 1) points[0] = 100;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Gray title bar
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0x1f000000),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "What possible outcomes do you think your counterpart would envision for each issue?",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Padding for all page content
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            /// Counterpart's Perceived Rubric Text
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Counterpart's Perceived Rubric",
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

                            /// Evenly Distribute Button and Showing Points
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Total Points: ${totalPoints().toString()} /100",
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 10),
                                  child: FilledButton(
                                    onPressed: () {
                                      EvenlyDistribute();
                                      setState(() {});
                                    },
                                    child: Text("Distribute Evenly"),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff0A0A5B)),
                                    ),

                                  ),
                                ),

                              ],
                            ),

                            /// List of the issues
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: currentNegotiation.issues.length,
                              itemBuilder: (BuildContext context, int index) {
                                String name = currentNegotiation.issues[index].name;

                                currentNegotiation.issues[index].cpResistance = widget.resistance;
                                currentNegotiation.issues[index].cpTarget = widget.target;

                                return Padding(
                                  padding: EdgeInsetsDirectional.only(bottom: 8),
                                  child: EnterValues(
                                    issueName: name,
                                    index: index,
                                    points: points,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Counter Parts Target
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Your counterpart's suspected target.",
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
                                IconButton(
                                  icon: const Icon(Icons.info_outline),
                                  color: iconOne ? Colors.black : Color(0xFF3B66B7),
                                  onPressed: () {
                                    setState(() {
                                      iconOne = true;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Counterparts Suspected Target'),
                                        content: const Text(
                                            "This is your best guess at what your counterparts target value is. \n \n"
                                            "This value should be lower than your suspected resistance because his 'target'"
                                            "is a lower score for you"),
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
                                  iconSize: 24,
                                )
                              ],
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: INTEGER_INPUTS,
                            onChanged: (newVal) {
                              setState(() {
                                widget.target = int.parse(newVal);
                                currentNegotiation.cpTarget = int.parse(newVal);
                              });
                            },
                            controller: cpTargetController,
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(color: Color(0xff000000), width: 1),
                              ),
                              hintText: "Target",
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff2f2f3),
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Counter Parts BATNA
                  Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0x1fffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: const Color(0x4dffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Your counterpart's BATNA?",
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
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.info_outline),
                                  color: iconTwo ? Colors.black : Color(0xFF3B66B7),
                                  onPressed: () {
                                    setState(() {
                                      iconTwo = true;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Counterparts BATNA'),
                                        content: const Text(
                                            "This is your best guess at what your Counterparts BATNA is."),
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
                                  iconSize: 24,
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "(Enter 0 if no BATNA is known)",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: INTEGER_INPUTS,
                          onChanged: (newVal) {
                            currentNegotiation.cpBATNA = int.parse(newVal);

                            setState(() {
                              widget.BATNA = int.parse(newVal);
                            });
                          },
                          controller: cpBATNAController,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(color: Color(0xff000000), width: 1),
                            ),
                            hintText: "BATNA",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: const Color(0xfff2f2f3),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Counter Parts resistance
                  Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0x1fffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: const Color(0x4dffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Your counterpart's suspected resistance point.",
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
                              IconButton(
                                icon: const Icon(Icons.info_outline),
                                color: iconThree ? Colors.black : Color(0xFF3B66B7),
                                onPressed: () {
                                  setState(() {
                                    iconThree = true;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Counterparts suspected resistance point.'),
                                      content: const Text(
                                          "This is your best guess at what your counterparts resistance point is. \n \n"
                                          "This value should be higher than your suspected target because a higher resistance"
                                          "for him means more value for you."),
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
                                iconSize: 24,
                              )
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: INTEGER_INPUTS,
                          onChanged: (newVal) {
                            setState(() {
                              widget.resistance = int.parse(newVal);
                              currentNegotiation.cpResistance = int.parse(newVal);
                            });
                          },
                          controller: cpResistanceController,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(color: Color(0xff000000), width: 1),
                            ),
                            hintText: "Resistance Point",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: const Color(0xfff2f2f3),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PrepareNegotiationNextBar(Next: Next, NextPage: PlanSummary()),
        ],
      ),
    );
  }

  int totalPoints() {
    int total = 0;

    for(int each in points){
      total+=each;
    }

    return total;
  }

  bool Next() {
    // Check if all the issues add up to 100
    // Target is lower than resistance
    num added = 0;
    for (int i = 0; i < currentNegotiation.issues.length; i++) {
      added += points[i];
    }
    if (added != 100) {
      Utils.showSnackBar("The issue points must add to 100");
      return false;
    }
    if (widget.target == -1 || widget.resistance == -1 || widget.BATNA == -1) {
      Utils.showSnackBar("You must enter value for each field.");
      return false;

    }
    if(widget.target >= widget.resistance) {
      Utils.showSnackBar("The CP target should be lower in points than the CP resistance.");
      return false;

    }

    currentNegotiation.cpTarget = widget.target;
    currentNegotiation.cpBATNA = widget.BATNA;
    currentNegotiation.cpResistance = widget.resistance;


    // Sets the relative value vs other cp Issues, the issue target, and the issue resistance
    for(int i = 0; i < currentNegotiation.issues.length; i++){
      currentNegotiation.issues[i].cpRelativeValue = points[i];
      currentNegotiation.issues[i].cpResistance = currentNegotiation.cpResistance;
      currentNegotiation.issues[i].cpTarget = currentNegotiation.cpTarget;

    }

    return true;

  }

  EvenlyDistribute() {
    int length = points.length;

    int step = (100 / length).round();
    int count = 0;
    for (int i = 1; i < length; i++) {
      points[i - 1] = step;
      count += step;
    }

    // Last issue gains 1 if the rounding takes the usual split to 99
    points[length - 1] = (100 - count);
  }
}

class EnterValues extends StatefulWidget {
  final String? issueName;
  final TextEditingController ctrl = TextEditingController();
  final int index;
  final List<int> points;

  EnterValues({required this.issueName, required this.index, required this.points});

  @override
  State<EnterValues> createState() => _EnterValuesState();
}

class _EnterValuesState extends State<EnterValues> {
  @override
  Widget build(BuildContext context) {
    widget.ctrl.text = widget.points[widget.index].toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            widget.issueName!,
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: Color(0xff000000),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: INTEGER_INPUTS,
            onChanged: (newVal) {
              widget.points[widget.index] = int.parse(newVal);
              currentNegotiation.issues[widget.index].cpResistance = int.parse(newVal);
              print(currentNegotiation.issues);
            },
            controller: widget.ctrl,
            obscureText: false,
            textAlign: TextAlign.start,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 14,
              color: Color(0xff000000),
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Color(0xff000000), width: 1),
              ),
              hintText: "Points",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xff000000),
              ),
              filled: true,
              fillColor: const Color(0xfff2f2f3),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }

  String _getRegexString() => r'[0-9]';
}
