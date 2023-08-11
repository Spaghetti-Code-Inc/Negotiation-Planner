import 'package:flutter/material.dart';
import 'BATNATest.dart';

import '../Utils.dart';
import '../main.dart';
import 'MAX_LENGTHS.dart';

class TargetResistance extends StatefulWidget {

  TargetResistance({super.key});

  @override
  State<TargetResistance> createState() => _TargetResistanceState();
}

class _TargetResistanceState extends State<TargetResistance> {

  bool iconColor = false;
  TextEditingController totalTarget = new TextEditingController();
  TextEditingController totalResistance = new TextEditingController();

  @override
  void initState() {
    totalTarget = new TextEditingController(text: currentNegotiation.target.toString());
    totalResistance = new TextEditingController(text: currentNegotiation.resistance.toString());

    if(currentNegotiation.target == -1 || currentNegotiation.target == 0) totalTarget.text = "";
    if(currentNegotiation.resistance == -1 || currentNegotiation.resistance == 0) totalResistance.text = "";

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                              child: Text(
                                "Target & Resistance",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 22,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.info_outline),
                              color: iconColor ? Colors.black : Color(0xff0A0A5B),
                              iconSize: 40,
                              onPressed: () {

                                iconColor = true;

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                        'Understanding your rubric'
                                    ),
                                    content: const Text(
                                        "If you were to receive an A on every deal you would score a 100 (a perfect score!)"
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Next'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Color(0xFF6DC090),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                title: const Text(
                                                    'Understanding your rubric'
                                                ),
                                                content: Text(
                                                    "If you were to get your A deal on the first issue and your least acceptable deal on the remaining issues, you would receive ${initPoints()} points."
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('Next'),
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Color(0xFF6DC090),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) => AlertDialog(
                                                            title: const Text(
                                                                'Understanding your rubric'
                                                            ),
                                                            content: Text(
                                                                "You might get a settlement on an issue that does not appear on your rubric, so you might need to estimate a reasonable value."
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                child: const Text('Next'),
                                                                style: TextButton.styleFrom(
                                                                  foregroundColor: Color(0xFF6DC090),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) => AlertDialog(
                                                                        title: const Text(
                                                                            'Example'
                                                                        ),
                                                                        content: Text(
                                                                            "Let’s say A deal on salary is \$50,000, and you gave that a value of 75 points. You get an offer of \$47,500 in salary, even though this value is not in the chart. The point to remember when using this tool is to pick numbers for your scoring system that reflect various levels of importance to you."
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                            child: const Text('Done'),
                                                                            style: TextButton.styleFrom(
                                                                              foregroundColor: Color(0xFF6DC090),
                                                                            ),
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                          ),
                                                                        ],
                                                                      )
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          )
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ]
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0x00000000),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          "Across all of the issues: What is the total number of points you wish to set as your goal for negotiation?",
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
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0x00000000),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text(
                          "This is your target",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0x00000000),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          inputFormatters: INTEGER_INPUTS,
                          keyboardType: TextInputType.number,
                          onChanged: (newVal) {
                            currentNegotiation.target = double.parse(newVal);
                          },
                          controller: totalTarget,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            labelText: "Points",
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
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0x00000000),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          "What is the least total number of points you wish to set as your goal for negotiation?",
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
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0x00000000),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Text(
                          "This is your resistance point",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0x00000000),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                              child: TextFormField(
                                inputFormatters: INTEGER_INPUTS,
                                keyboardType: TextInputType.number,
                                onChanged: (newVal) {
                                  if(newVal == "") currentNegotiation.resistance = 0;
                                  currentNegotiation.resistance = double.parse(newVal);

                                },
                                controller: totalResistance,
                                obscureText: false,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  color: Color(0xff000000),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: const BorderSide(
                                        color: Color(0xff000000), width: 1),
                                  ),

                                  labelText: "Points",
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          /// Next and Back bar
          PrepareNegotiationNextBar(Next: Next, NextPage: BATNATest())


        ],
      ),
    );
  }


  bool Next(){
    if(totalTarget.text == "" || totalResistance.text == ""){
      Utils.showSnackBar("You need to fill out target and resistance values.");
    }
    else if(int.parse(totalTarget.text) <= int.parse(totalResistance.text)){
      Utils.showSnackBar("Your target value must be higher than your resistance value.");
    }
    else if(int.parse(totalTarget.text) > 100){
      Utils.showSnackBar("Your target can not exceed 100.");
    }
    else if(int.parse(totalResistance.text) < 0){
      Utils.showSnackBar("Your resistance can not be below 0.");
    } else if(currentNegotiation.resistance == -1){
      currentNegotiation.resistance = 0;
    }
    else{
      return true;
    }

    return false;
  }

  // Calculates the score for a A+ deal on your first issue but your least acceptable deal on the rest
  static int initPoints(){
    num counter = 0;

    bool firstRun = true;
    for(int i = 0; i < currentNegotiation.issues.length; i++){
      if(!firstRun){
        counter += int.parse(currentNegotiation.issues[i].issueVals["D"][0].toString());
      }
      else{
        counter += 1.0*currentNegotiation.issues[i].relativeValue;
        firstRun = false;
      }
    }
    return counter.toInt();
  }
}



