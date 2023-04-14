///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:negotiation_tracker/DetermineIssues.dart';
import 'package:negotiation_tracker/main.dart';

import 'NegotiationDetails.dart';

class StartNewNegotiation extends StatefulWidget{
  const StartNewNegotiation({super.key});

  State<StartNewNegotiation> createState() => _StartNewNegotiation();
}

class _StartNewNegotiation extends State<StartNewNegotiation>{
  final TitleController = TextEditingController();
  final SummaryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    currentNegotiation.summary = "";
    currentNegotiation.title = "";
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
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "This tool is designed to help you organize your plan for negotiation. ",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(14),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: const Color(0x4dffffff), width: 0),
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
                    // TITLE Text field
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: Color(0xff0A0A5B),
                        textInputAction: TextInputAction.next,
                        onChanged: (newVal) {
                          currentNegotiation = Negotiation.fromNegotiation(title: '', issues: {}, cpIssues: {}, cpTarget: -1, cpBATNA: -1, cpResistance: -1, target: -1, resistance: -1);
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
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                            const BorderSide(color: Color(0xff0A0A5B), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                            const BorderSide(color: Color(0xff0A0A5B), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
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
                          filled: true,
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
                padding: const EdgeInsets.all(14),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: const Color(0x4dffffff), width: 0),
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

                    // SUMMARY text field
                    TextField(
                      cursorColor: Color(0xff0A0A5B),
                      onChanged: (newVal) {
                        currentNegotiation = Negotiation.fromNegotiation(title: '', issues: {}, cpIssues: {}, cpTarget: -1, cpBATNA: -1, cpResistance: -1, target: -1, resistance: -1);
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
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Color(0xff0A0A5B), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Color(0xff0A0A5B), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
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
              Expanded(
                flex: 1,
                child: NextBar(DetermineIssues()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
