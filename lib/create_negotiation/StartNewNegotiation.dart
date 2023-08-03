
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utils.dart';
import 'DetermineIssues.dart';
import 'package:negotiation_tracker/main.dart';

import '../NegotiationDetails.dart';
import 'MAX_LENGTHS.dart';

class StartNewNegotiation extends StatefulWidget{
  const StartNewNegotiation({super.key});

  State<StartNewNegotiation> createState() => _StartNewNegotiation();
}

class _StartNewNegotiation extends State<StartNewNegotiation>{
  final TitleController = TextEditingController();
  final SummaryController = TextEditingController();

  bool topTextVisible = true;

  @override
  void initState() {
    /// Initializing many current negotiation values
    currentNegotiation.summary = "";
    currentNegotiation.title = "";
    currentNegotiation.BATNA = 0;
    currentNegotiation.currentOffer = 0;
    currentNegotiation.target = 0;
    currentNegotiation.resistance = 0;
    // currentNegotiation.cpTarget = 0;
    // currentNegotiation.cpBATNA = 0;
    // currentNegotiation.cpResistance = 0;
    super.initState();
  }

  void dispose(){
    TitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children:[

              if(topTextVisible) Row(
                children: [
                  Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                    child: Text(
                      "This tool is designed to help you organize your plan for negotiation. ",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  ),
                  IconButton(
                      onPressed: () => removeText(),
                      icon: Icon(Icons.close),
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 32),

                  )
                ],
              ),

              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4.0),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                    /// TITLE Text field
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(MAX_TITLE_LENGTH),
                        ],
                        cursorColor: Color(0xff0A0A5B),
                        textInputAction: TextInputAction.next,
                        onChanged: (newVal) {
                          currentNegotiation = Negotiation.fromNegotiation(title: '', issues: [], target: -1, resistance: -1);
                          currentNegotiation.summary = SummaryController.text;
                          currentNegotiation.title = newVal;
                        },
                        controller: TitleController,
                        obscureText: false,
                        textAlign: TextAlign.left,
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
                            borderSide:
                            const BorderSide(color: Color(0xff0A0A5B), width: 1),
                          ),
                          labelText: "Negotiation Title",
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff0A0A5B),
                          ),
                          filled: false,
                          fillColor: const Color(0xfff2f2f3),
                          isDense: false,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: const Color(0xffffffff), width: 0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    /// SUMMARY text field
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(MAX_SUMMARY_LENGTH),
                      ],
                      cursorColor: Color(0xff0A0A5B),
                      onChanged: (newVal) {
                        currentNegotiation = Negotiation.fromNegotiation(title: '', issues: [], target: -1, resistance: -1);
                        currentNegotiation.title = TitleController.text;
                        currentNegotiation.summary = newVal;
                      },
                      controller: SummaryController,
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: 9,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Color(0xff0A0A5B), width: 1),
                        ),

                        hintText: "Give a summary of the negotiation. Include what you are bargaining for, your goals, and other important details.",

                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff0A0A5B),
                        ),


                        filled: false,
                        fillColor: const Color(0xfff2f2f3),
                        isDense: true,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PrepareNegotiationNextBar(Next: Next, NextPage: DetermineIssues()),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool Next(){
    if (currentNegotiation.title == ""){
      Utils.showSnackBar("Please enter value for the negotiations title and summary.");
      return false;
    }

    return true;
  }

  removeText() {
    topTextVisible = false;
    setState(() {});
  }
}
