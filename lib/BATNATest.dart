///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negotiation_tracker/RubricSummary.dart';
import 'package:negotiation_tracker/main.dart';

import 'Utils.dart';

//TODO: If you go back the values should still save
class BATNATest extends StatefulWidget {
  @override
  BATNATestState createState() => BATNATestState();
}

class BATNATestState extends State<BATNATest> {

  @override

  //drop down menu variables

  bool dropDownOne = true;
  IconData dropDownOneIcon = Icons.arrow_drop_down;

  bool dropDownTwo = true;
  IconData dropDownTwoIcon = Icons.arrow_drop_down;

  //BATNATestState({super.key});

  TextEditingController BATNA = new TextEditingController();
  TextEditingController CurrentOffer = new TextEditingController();

  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      appBar: PrepareBar(),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                  child: const Text(
                                    "Test Drive #1: Your BATNA",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                            ),

                            IconButton(
                                onPressed: () {

                                  setState(() {

                                    dropDownOne = !dropDownOne;

                                    if (dropDownOne) {
                                      dropDownOneIcon = Icons.arrow_drop_down;
                                    }
                                    else {
                                      dropDownOneIcon = Icons.arrow_drop_up;
                                    }

                                  });

                                },
                                icon: Icon(dropDownOneIcon),
                                color: Color(0xff0A0A5B)
                            )
                          ]
                        ),


                        AnimatedContainer(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff0A0A5B))
                          ),
                          duration: const Duration(milliseconds: 700),
                          height: dropDownOne ? 0 : 360.0,
                          curve: Curves.fastOutSlowIn,
                          child: Text(
                            "Think about your Best Alternative to a Negotiated Agreement (BATNA). \n"
                                "If your BATNA is another offer. Use this rubric to value that offer. \n"
                                "Your BATNA could also reflect a completely different opportunity. \n"
                                "Pick a number (based on your scoring system if possible) that reflects the value of your BATNA to you.",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,

                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              height: 1.2,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
                          child: Text(
                            "Out of 100 points, what is the value of your BATNA?",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 17,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ))
                            ],
                            onChanged: (newVal) {
                              try {
                                currentNegotiation.BATNA = int.parse(newVal);
                              } on FormatException catch (e) {
                                if (newVal != "") {
                                  Utils.showSnackBar(
                                      "Your BATNA value needs to be an integer.");
                                  BATNA.text = "";
                                }
                              }
                            },
                            controller: BATNA,
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
                              hintText: "Points",
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff2f2f3),
                              isDense: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Color(0xFF1E2027),
                        ),

                        Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    child: const Text(
                                      "Test Drive #2: Your Current Offer",
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                              ),

                              IconButton(
                                  onPressed: () {

                                    setState(() {

                                      dropDownTwo = !dropDownTwo;

                                      if (dropDownTwo) {
                                        dropDownTwoIcon = Icons.arrow_drop_down;
                                      }
                                      else {
                                        dropDownTwoIcon = Icons.arrow_drop_up;
                                      }

                                    });

                                  },
                                  icon: Icon(dropDownTwoIcon),
                                  color: Color(0xff0A0A5B)
                              )
                            ]
                        ),

                        AnimatedContainer(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff0A0A5B))
                          ),
                          duration: const Duration(milliseconds: 700),
                          height: dropDownTwo ? 0 : 135.0,
                          curve: Curves.fastOutSlowIn,
                          child: Text(
                            "Now use the scoring rubric to score the value of your current offer before negotiating! (Example: List price.)",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,

                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              height: 1.2,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Out of 100 points, what is the value of your current offer?",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 17,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 10),
                          child: TextField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                        text:
                                            newValue.text.replaceAll('.', ','),
                                      ))
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (newVal) {
                              try {
                                currentNegotiation.currentOffer =
                                    int.parse(newVal);
                              } on FormatException catch (e) {
                                if (newVal != "") {
                                  Utils.showSnackBar(
                                      "Your current offer value needs to be an integer.");
                                  CurrentOffer.text = "";
                                }
                              }
                            },
                            controller: CurrentOffer,
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
                              hintText: "Points",
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff2f2f3),
                              isDense: false,
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
          
          /// Next and Back Bar
          PrepareNegotiationNextBar(Next: Next, NextPage: RubricSummary())
        ],
      ),
    );
  }
  
  
  bool Next(){
    if(BATNA.text == "" || CurrentOffer.text == ""){
      Utils.showSnackBar("You need to fill out BATNA and Current Offer values.");
      return false;
    }
    else {
      return true;
    }
  }

  innitBATNAandCurrentOffer(){
    if(currentNegotiation.BATNA != null){
      BATNA.text = currentNegotiation.BATNA.toString();
    }
    else if(currentNegotiation.currentOffer != null){
      CurrentOffer.text = currentNegotiation.currentOffer.toString();
    }
  }
  String _getRegexString() => r'[0-9]';

}



