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
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Text(
                  "This tool is designed to help you organize your plan for negotiation. ",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              // TITLE Text field
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorColor: Color(0xff3e4b8c),
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
                      const BorderSide(color: Color(0xff3e4b8c), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                      const BorderSide(color: Color(0xff3e4b8c), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide:
                      const BorderSide(color: Color(0xff3e4b8c), width: 1),
                    ),
                    labelText: "Negotiation Title",
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff3e4b8c),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff2f2f3),
                    isDense: false,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0x1fffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: const Color(0x4dffffff), width: 0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                      child: Text(
                        "Give a summary of what your negotiation is about. ",
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
                    // SUMMARY text field
                    TextField(
                      cursorColor: Color(0xff3e4b8c),
                      onChanged: (newVal) {
                        currentNegotiation = Negotiation.fromNegotiation(title: '', issues: {}, cpIssues: {}, cpTarget: -1, cpBATNA: -1, cpResistance: -1, target: -1, resistance: -1);
                        currentNegotiation.title = TitleController.text;
                        currentNegotiation.summary = newVal;
                      },
                      controller: SummaryController,
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: 3,
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
                          const BorderSide(color: Color(0xff3e4b8c), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Color(0xff3e4b8c), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                          const BorderSide(color: Color(0xff3e4b8c), width: 1),
                        ),
                        labelText: "Summary",
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff3e4b8c),
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
