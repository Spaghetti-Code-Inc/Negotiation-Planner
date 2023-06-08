
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PlanSummary.dart';

import '../Utils.dart';
import '../main.dart';

class CpsRubrik extends StatefulWidget {
  CpsRubrik({super.key});

  @override
  State<StatefulWidget> createState() => _CpsRubrikState();

  //TODO: Set these to the actual current Negotiation value
  int target = 0;
  int BATNA = 0;
  int resistance = 0;
}

class _CpsRubrikState extends State<CpsRubrik> {
  bool iconOne = false;
  bool iconTwo = false;
  bool iconThree = false;

  TextEditingController cpTargetController = new TextEditingController();
  TextEditingController cpBATNAController = new TextEditingController();
  TextEditingController cpResistanceController = new TextEditingController();

  List<int> points = List.filled(currentNegotiation.issues.keys.length, 0);

  @override
  Widget build(BuildContext context) {
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

                            /// Evenly Distribute Button
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: FilledButton(
                                onPressed: () {
                                  EvenlyDistribute();
                                  setState(() {});
                                },
                                child: Text("Distribute Evenly"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(Color(0xff0A0A5B)),
                                ),
                              ),
                            ),

                            /// List of the issues
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: currentNegotiation.issues.keys.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.only(bottom: 8),
                                  child: EnterValues(
                                    issueName: currentNegotiation.issues.keys.elementAt(index),
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
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                        text: newValue.text.replaceAll('.', ','),
                                      ))
                            ],
                            onChanged: (newVal) {
                              try {
                                setState(() {
                                  widget.target = int.parse(newVal);
                                });
                              } on FormatException {
                                if (newVal != "") {
                                  Utils.showSnackBar("Your target value needs to be an integer.");
                                  cpTargetController.text = "0";
                                }
                              }
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
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                      text: newValue.text.replaceAll('.', ','),
                                    ))
                          ],
                          onChanged: (newVal) {
                            try {
                              setState(() {
                                widget.BATNA = int.parse(newVal);
                              });
                            } on FormatException {
                              if (newVal != "") {
                                Utils.showSnackBar("Your BATNA value needs to be an integer.");
                                cpBATNAController.text = "";
                              }
                            }
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
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                      text: newValue.text.replaceAll('.', ','),
                                    ))
                          ],
                          onChanged: (newVal) {
                            try {
                              setState(() {
                                widget.resistance = int.parse(newVal);
                                if (newVal == "") {
                                  widget.resistance == 0;
                                }
                              });
                            } on FormatException {
                              if (newVal != "") {
                                Utils.showSnackBar("Your resistance value needs to be an integer.");
                              }
                            }
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

  bool Next() {
    // Check if all the issues add up to 100
    // Target is lower than resistance
    num added = 0;
    for (String current in currentNegotiation.cpIssues.keys) {
      added += currentNegotiation.cpIssues[current]["relativeValue"];
      currentNegotiation.cpIssues[current]["target"] = widget.target;
      currentNegotiation.cpIssues[current]["resistance"] = widget.resistance;

      print(currentNegotiation.cpIssues[current]["resistance"]);
    }
    if (added == 100) {
      if (widget.target != -1 || widget.resistance != -1 || widget.BATNA != -1) {
        if (widget.target < widget.resistance) {
          currentNegotiation.cpTarget = widget.target;
          currentNegotiation.cpBATNA = widget.BATNA;
          currentNegotiation.cpResistance = widget.resistance;

          return true;
        } else {
          Utils.showSnackBar("The CP target should be lower in points than the CP resistance.");
        }
      } else {
        Utils.showSnackBar("You must enter value for each field.");
      }
    } else {
      Utils.showSnackBar("The issue points must add to 100");
    }

    return false;
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

  String _getRegexString() => r'[0-9]';
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
    currentNegotiation.cpIssues[widget.issueName!] = {"relativeValue": widget.points[widget.index]};

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
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
              TextInputFormatter.withFunction((oldValue, newValue) => newValue.copyWith(
                    text: newValue.text.replaceAll('.', ','),
                  ))
            ],
            onChanged: (newVal) {
              currentNegotiation.cpIssues[widget.issueName!] = int.parse(newVal);
              widget.points[widget.index] = int.parse(newVal);
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Color(0xff000000), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Color(0xff000000), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
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
