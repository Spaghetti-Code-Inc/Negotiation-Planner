///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:negotiation_tracker/UnderStantRubrc.dart';

import 'main.dart';

class IssueValues extends StatelessWidget {
  const IssueValues({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    "Step 3/3",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      fontSize: 28,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: Text(
                    "Establish the possibilities for each issue and their value to you",
                    textAlign: TextAlign.center,
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
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Text(
              "Identify possible outcomes on each and allocate a number of points for several potential settlement on each issue. You should base your range on norms, industry standards market data, etc.",
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
          Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xff1E2027),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Issue One: 'Name'",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Max Points",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
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
                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width *
                              0.7000000000000001,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0x55000000),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                            border:
                                Border.all(color: const Color(0x4d9e9e9e), width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Text(
                              "What would be your A+ settlement on this issue? This represents the most you can reasonably justify and will be your opening offer.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0x53000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: TextEditingController(),
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width *
                              0.7000000000000001,
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color(0x1f000000),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                            border:
                                Border.all(color: const Color(0x4d9e9e9e), width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Text(
                              "What would be your A settlement on this issue? This represents the settlement you will strive to obtain or beat.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: 200,
                            height: 90,
                            decoration: BoxDecoration(
                              color: const Color(0x1f000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: TextEditingController(),
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width *
                              0.7000000000000001,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x55000000),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                            border:
                                Border.all(color: const Color(0x4d9e9e9e), width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Text(
                              "What would be your B settlement on this issue?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0x55000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: TextEditingController(),
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width *
                              0.7000000000000001,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x1f000000),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                            border:
                                Border.all(color: const Color(0x4d9e9e9e), width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Text(
                              "What would be your C settlement on this issue?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0x1f000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: TextEditingController(),
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width *
                              0.7000000000000001,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x54000000),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                            border:
                                Border.all(color: const Color(0x4d9e9e9e), width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Text(
                              "What would be your D settlement on this issue?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0x53000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                controller: TextEditingController(),
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
                                  labelText: "Pts.",
                                  labelStyle: const TextStyle(
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
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width *
                              0.7000000000000001,
                          height: 65,
                          decoration: BoxDecoration(
                            color: const Color(0x1f000000),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                            border:
                                Border.all(color: const Color(0x4d9e9e9e), width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "What would be your least acceptable settlement on this issue?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            width: 200,
                            height: 65,
                            decoration: BoxDecoration(
                              color: const Color(0x1f000000),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.zero,
                              border: Border.all(
                                  color: const Color(0x4d9e9e9e), width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: TextEditingController(),
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          NextBar(UnderStantRubrc()),
        ],
      ),
    );
  }
}
