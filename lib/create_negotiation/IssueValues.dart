
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negotiation_tracker/create_negotiation/UnderStantRubrc.dart';

import '../Utils.dart';
import '../main.dart';

class IssueValues extends StatefulWidget {
  const IssueValues({super.key});

  State<IssueValues> createState() => _IssueValuesState();
}

class _IssueValuesState extends State<IssueValues> {
  bool iconColor = false;
  List<String>? _issueNames =
      currentNegotiation.issues.keys.toList(growable: true);

  List<List<TextEditingController>> _controllers = [];

  @override
  Widget build(BuildContext context) {
    int? length = _issueNames?.length;
    for (int i = 0; i < length!; i++) {
      _controllers.add([]);
      // 6 because that is the number of settlement opportunists
      for (int j = 0; j < 6; j++) {
        _controllers[i].add(TextEditingController());
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                itemCount: currentNegotiation.issues.keys.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: EnterValues(
                        issueName: currentNegotiation.issues.keys
                            .elementAt(index),
                        ctrl: _controllers[index],
                      ),
                      height: 445);
                }),
          ),

          /// Next and Back Bar
          PrepareNegotiationNextBar(Next: Next, NextPage: UnderStantRubrc()),


        ],
      ),
    );
  }

  bool Next(){
    bool moveOn = true;
    int length = currentNegotiation.issues.keys.length;
    // Checks if all values are in right format
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < 6; j++) {
        try {
          int greater = int.parse(_controllers[i][j].text);
          int less;

          // Checks to make sure lower is not off out of bounds
          if (j + 1 == 6) {
            less = greater;
          } else {
            less = int.parse(_controllers[i][j + 1].text);
          }

          if (greater < less) {
            moveOn = false;
            Utils.showSnackBar(
                "One of your issues does not have the right order of value.");
          }
        } on FormatException catch (e) {
          print(i.toString() + ", " + j.toString());
          print(e);
          Utils.showSnackBar(
              "One of your values is not an integer.");
          moveOn = false;
        }
      }
      // Checks if any value is too big
      if (int.parse(_controllers[i][0].text) > 100) {
        Utils.showSnackBar(
            "One of your A+ settlement values exceeds the points possible.");
        moveOn = false;
      }
    }

    // If data is in right format
    if (moveOn) {
      // Length is the length of "issueNames" keys
      for (int i = 0; i < length; i++) {
        // Puts value in for all the possible settlements
        currentNegotiation.issues[_issueNames![i]]
            ?.putIfAbsent(
            "A+", () => int.parse(_controllers[i][0].text));
        currentNegotiation.issues[_issueNames![i]]
            ?.putIfAbsent("A", () => int.parse(_controllers[i][1].text));
        currentNegotiation.issues[_issueNames![i]]
            ?.putIfAbsent("B", () => int.parse(_controllers[i][2].text));
        currentNegotiation.issues[_issueNames![i]]
            ?.putIfAbsent("C", () => int.parse(_controllers[i][3].text));
        currentNegotiation.issues[_issueNames![i]]
            ?.putIfAbsent("D", () => int.parse(_controllers[i][4].text));
        currentNegotiation.issues[_issueNames![i]]
            ?.putIfAbsent("F", () => int.parse(_controllers[i][5].text));
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
  final List<TextEditingController> ctrl;
  const EnterValues({Key? key, required this.issueName, required this.ctrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Keeps the A+ settlement at the max possible points
    ctrl[0].text = "100";
    ctrl[5].text = "0";
    return Column(
      children: [
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: FilledButton(
                      onPressed: () { EvenlyDistribute(); },
                      child: Text("Distribute Evenly"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff0A0A5B)),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                //"This represents the most you can reasonably justify and will be your opening offer.",
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          showDialog(context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'A+ Settlement'
                                ),
                                content: const Text(
                                  "This represents the most you can reasonably "
                                      "justify and will be your opening offer."
                                ),
                              )
                          );
                        },
                        style: TextButton.styleFrom(foregroundColor: Color(0xff0A0A5B)),

                        child: Text("A+ Settlement"),

                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFF),
                        shape: BoxShape.rectangle,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                        text: newValue.text
                                            .replaceAll('.', ','),
                                      ))
                            ],
                            controller: ctrl[0],
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
                  ],
                ),
                Divider(),
                Row(
                  //"This represents the settlement you will strive to obtain or beat. (Also known as your target on the issue)"
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          showDialog(context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                    'A Settlement'
                                ),
                                content: const Text(
                                    "This represents the settlement you will strive to obtain or beat. (Also known as your target on the issue)"
                                ),
                              )
                          );
                        },
                        style: TextButton.styleFrom(foregroundColor: Color(0xff0A0A5B)),

                        child: Text("A Settlement"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFF),
                        shape: BoxShape.rectangle,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                    text: newValue.text
                                        .replaceAll('.', ','),
                                  ))
                            ],
                            controller: ctrl[1],
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
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          showDialog(context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                    'B Settlement'
                                ),
                                content: const Text(
                                    "This represents an acceptable settlement to you."
                                ),
                              )
                          );
                        },
                        style: TextButton.styleFrom(foregroundColor: Color(0xff0A0A5B)),

                        child: Text("B Settlement"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFF),
                        shape: BoxShape.rectangle,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                    text: newValue.text
                                        .replaceAll('.', ','),
                                  ))
                            ],
                            controller: ctrl[2],
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
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          showDialog(context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'C Settlement'
                              ),
                              content: const Text(
                              "This represents an okay settlement for you."
                              ),
                            )
                          );
                        },
                        style: TextButton.styleFrom(foregroundColor: Color(0xff0A0A5B)),

                      child: Text("C Settlement"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFF),
                        shape: BoxShape.rectangle,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                    text: newValue.text
                                        .replaceAll('.', ','),
                                  ))
                            ],
                            controller: ctrl[3],
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
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          showDialog(context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                    'D Settlement'
                                ),
                                content: const Text(
                                    "This represents a negative settlement for you."
                                ),
                              )
                          );
                        },
                        style: TextButton.styleFrom(foregroundColor: Color(0xff0A0A5B)),

                        child: Text("D Settlement"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFF),
                        shape: BoxShape.rectangle,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                    text: newValue.text
                                        .replaceAll('.', ','),
                                  ))
                            ],
                            controller: ctrl[4],
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
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          showDialog(context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                    'F Settlement'
                                ),
                                content: const Text(
                                    "This represents a negative settlement for you. Your F deal should be the least amount of points possible."
                                ),
                              )
                          );
                        },
                        style: TextButton.styleFrom(foregroundColor: Color(0xff0A0A5B)),

                        child: Text("F Settlement"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFF),
                        shape: BoxShape.rectangle,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(_getRegexString())),
                              TextInputFormatter.withFunction(
                                      (oldValue, newValue) => newValue.copyWith(
                                    text: newValue.text
                                        .replaceAll('.', ','),
                                  ))
                            ],
                            controller: ctrl[5],
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  EvenlyDistribute(){
    int length = 5;

    // Gets how much the pts should change by in each step
    int total = int.parse(ctrl[0].text);
    int step = (total/length).round();

    for(int i = 1; i < length; i++){
      ctrl[i].text = (total-step*i).toString();
    }
  }

  String _getRegexString() => r'[0-9]';
}