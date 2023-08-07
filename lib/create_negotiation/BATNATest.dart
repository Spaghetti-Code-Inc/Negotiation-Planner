import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MAX_LENGTHS.dart';
import 'RubricSummary.dart';
import '../main.dart';
import '../Utils.dart';

class BATNATest extends StatefulWidget {
  @override
  BATNATestState createState() => BATNATestState();
}

class BATNATestState extends State<BATNATest> {
  TextEditingController BATNA;

  BATNATestState() : BATNA = new TextEditingController(text: currentNegotiation.BATNA.toString());

  Widget build(BuildContext context) {
    if (currentNegotiation.BATNA == null) BATNA.text = "0";

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
                        Container(

                          padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                          child: Text(
                            "Test Drive: Your BATNA",
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
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all(color: Color(0xff0A0A5B))),
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
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: INTEGER_INPUTS,
                            onChanged: (newVal) {
                              currentNegotiation.BATNA = int.parse(newVal);
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
                              isDense: false,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Color(0xFF1E2027),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),

          /// Next and Back Bar
          PrepareNegotiationNextBar(
            Next: Next,
            NextPage: RubricSummary(),
          )
        ],
      ),
    );
  }

  bool Next() {
    try{
      currentNegotiation.BATNA = int.parse(BATNA.text);
    } catch (e){
      Utils.showSnackBar("You need to fill out BATNA value.");
      return false;
    }

    if (BATNA.text == "") {
      Utils.showSnackBar("You need to fill out BATNA value.");
      return false;
    } else {
      return true;
    }
  }

  innitBATNAandCurrentOffer() {
    if (currentNegotiation.BATNA != null) {
      BATNA.text = currentNegotiation.BATNA.toString();
    }
  }
}
