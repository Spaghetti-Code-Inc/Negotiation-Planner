import 'package:flutter/material.dart';
import 'package:negotiation_tracker/create_negotiation/Target_Resistance.dart';

import '../Utils.dart';
import '../main.dart';
import 'MAX_LENGTHS.dart';

class IssueValues extends StatefulWidget {
  const IssueValues({super.key});

  State<IssueValues> createState() => _IssueValuesState();
}

class _IssueValuesState extends State<IssueValues> {
  bool iconColor = false;
  List<List<TextEditingController>> _controllers = [];
  List<List<TextEditingController>> _realValues = [];

  List<String> letters = ["A", "B", "C", "D", "F"];

  @override
  void initState(){
    /// Loads the current issue values to the text editing controllers
    for(int i = 0; i < currentNegotiation.issues.length; i++){
      Map<String, dynamic> here = currentNegotiation.issues[i].issueVals;

      _controllers.add([]);
      _realValues.add([]);

      for(String letter in letters){

        if(here[letter] == null){
          here[letter] = [0, ""];
        }
        _controllers[i].add(new TextEditingController(text: here[letter][0].toString()));
        _realValues[i].add(new TextEditingController(text: here[letter][1]));
      }

      for(int j = 0; j < _controllers[i].length; j++){
        if(_controllers[i][j].text == "null") _controllers[i][j].text = "0";
        else if(_realValues[i][j].text == "null") _realValues[i][j].text = "0";
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// Header
          Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xffffff),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(48, 8, 0, 0),
                        child: Text(
                          "Step 3/3",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            fontSize: 22,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(48, 8, 0, 0),
                        child: Text(
                          "Assign the amount of points for each potential settlement",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ])),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: IconButton(
                      icon: const Icon(Icons.info_outline),
                      color: iconColor ? Colors.black : Color(0xff0A0A5B),
                      iconSize: 40,
                      onPressed: () {
                        setState(() {
                          iconColor = true;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                                'Set the possibilities for each issue.'),
                            content: const Text(
                                "Identify possible outcomes on each and allocate a "
                                "number of points for several potential settlement on each issue. "
                                "You should base your range on norms, industry standards market data, etc."),
                            actions: [
                              TextButton(
                                child: const Text('Okay'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Color(0xFF6DC090),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                ),
              ],
            ),
          ),
          /// List of issues
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: currentNegotiation.issues.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: EnterValues(
                        issueName: currentNegotiation.issues.elementAt(index).name,
                        ctrl: _controllers[index],
                        index: index,
                        realCtrl: _realValues[index],
                      ),
                      height: 390);
                }),
          ),

          /// Next and Back Bar
          PrepareNegotiationNextBar(Next: Next, NextPage: TargetResistance()),


        ],
      ),
    );
  }

  bool Next(){
    bool moveOn = true;
    int length = currentNegotiation.issues.length;
    // Checks if all values are in right format
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < 5; j++) {
        try {
          int greater = int.parse(_controllers[i][j].text);
          int less;

          // Checks to make sure lower is not off out of bounds
          if (j + 1 == 5) {
            less = greater;
          } else {
            less = int.parse(_controllers[i][j + 1].text);
          }

          if (greater < less) {
            moveOn = false;
            Utils.showSnackBar(
                "One of your issues does not have the right order of value.");
          }
        } on FormatException {
          Utils.showSnackBar(
              "One of your values is not an integer.");
          moveOn = false;
        }
      }
    }

    // If data is in right format
    if (moveOn) {
      // Length is the length of "issueNames" keys
      for (int i = 0; i < length; i++) {
        // Puts value in for all the possible settlements
        for(int j = 0; j < letters.length; j++){
          currentNegotiation.issues[i].issueVals[letters[j]][0] = int.parse(_controllers[i][j].text);
          currentNegotiation.issues[i].issueVals[letters[j]][1] = _realValues[i][j].text;
        }
      }

      return true;
    }
    else {
      return false;
    }
  }
}

class EnterValues extends StatelessWidget {
  final String? issueName;
  final int index;
  final List<TextEditingController> ctrl;
  final List<TextEditingController> realCtrl;
  EnterValues({Key? key, required this.issueName, required this.ctrl, required this.index, required this.realCtrl})
      : super(key: key);

  late final MaxPoints = currentNegotiation.issues[index].relativeValue;

  late final Map<String, dynamic> issueVals = currentNegotiation.issues[index].issueVals;


  @override
  Widget build(BuildContext context) {
    // Keeps the A+ settlement at the max possible points
    ctrl[0].text = MaxPoints.toString();
    ctrl[4].text = "0";

    issueVals["A"] = [MaxPoints, realCtrl[0].text];
    issueVals["B"] = [int.tryParse(ctrl[1].text), realCtrl[1].text];
    issueVals["C"] = [int.tryParse(ctrl[2].text), realCtrl[2].text];
    issueVals["D"] = [int.tryParse(ctrl[3].text), realCtrl[3].text];
    issueVals["F"] = [0, realCtrl[4].text];

    List<String> inputRowNames = ["A Settlement", "B Settlement", "C Settlement", "D Settlement", "F Settlement"];
    List<String> inputRowSummary = [
      "This represents the settlement you will strive to obtain or beat. (Also known as your target on the issue)",
      "This represents an acceptable settlement to you.",
      "This represents an okay settlement for you.",
      "This represents a negative settlement for you.",
      "This represents a negative settlement for you. Your F deal should be the least amount of points possible."
    ];


    return Column(
      children: [
        /// Header for issue
        Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xff1E2027),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  /// Issue Name
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              issueName!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: FilledButton(
                        onPressed: () { EvenlyDistribute(); },
                        child: Text("Distribute Evenly"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff0A0A5B)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column( children: [
              InputRow(name: inputRowNames[index], buttonText: inputRowSummary[index], points: ctrl[index], realWorldValue: realCtrl[index]),
              Divider(thickness: 1, color: Colors.black),
            ]);
          },

        ),
      ],
    );
  }

  EvenlyDistribute(){
    int length = 4;

    // Gets how much the pts should change by in each step
    int total = int.parse(ctrl[0].text);
    int step = (total/length).round();

    for(int i = 1; i < length; i++){
      ctrl[i].text = (total-step*i).toString();
    }
  }

}

class InputRow extends StatelessWidget {

  String name;
  String buttonText;
  TextEditingController realWorldValue;
  TextEditingController points;

  InputRow({Key? key, required this.name, required this.buttonText, required this.realWorldValue, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Row (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// A Settlement button
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: () {
                showDialog(context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        this.name,
                      ),
                      content: Text(
                        this.buttonText,
                      ),
                    )
                );
              },
              style: TextButton.styleFrom(foregroundColor: Color(0xff0A0A5B)),

              child: Text(this.name),
            ),
          ),

          /// Real World Value
          Expanded(
              flex: 1,
              child: Container(
                child: TextField(
                  controller: realWorldValue,
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
                      borderSide: const BorderSide(
                          color: Color(0xff000000), width: 1),
                    ),
                    labelText: "Real Value",
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff2f2f3),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                  ),
                ),
              )
          ),

          /// Pts
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
              width: MediaQuery.of(context).size.width * 0.2,
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFF),
                shape: BoxShape.rectangle,

              ),

              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: INTEGER_INPUTS,
                controller: points,
                obscureText: false,
                textAlign: TextAlign.start,
                maxLines: 1,
                enabled: !(name == "A Settlement" || name == "F Settlement"),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                        color: Color(0xff000000), width: 1),
                  ),
                  labelText: "Pts.",
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                  filled: true,
                  fillColor: const Color(0xfff2f2f3),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12),
                ),
              ),
            ),),
        ],
      );
  }
}

