///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negotiation_tracker/PlanSummary.dart';

import 'Utils.dart';
import 'main.dart';

// TODO: Make total points equal 100
// TODO: Counterparts resistance is greater than target
class CpsRubrik extends StatefulWidget{
  const CpsRubrik({super.key});

  @override
  State<StatefulWidget> createState() => _CpsRubrikState();
}

class _CpsRubrikState extends State<CpsRubrik> {

  bool iconOne = false;
  bool iconTwo = false;
  bool iconThree = false;

  TextEditingController cpTargetController = new TextEditingController();
  TextEditingController cpBATNAController = new TextEditingController();
  TextEditingController cpResistanceController = new TextEditingController();


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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
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
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0x1fffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: Align(
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
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentNegotiation.issues["issueNames"]?.keys.length,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                  padding: EdgeInsetsDirectional.only(bottom: 8),
                                  child: EnterValues(
                                    issueName: currentNegotiation.issues["issueNames"]?.keys.elementAt(index)
                                  )
                              );
                            }
                          ),
                       ],
                      ),
                    ],
                  ),
                ),


                Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0x1fffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                    border: Border.all(color: const Color(0x4dffffff), width: 0),
                  ),
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
                                      content: const Text("This is your best guess at what your counterparts target value is."),
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
                            FilteringTextInputFormatter.allow(
                                RegExp(_getRegexString())),
                            TextInputFormatter.withFunction(
                                    (oldValue, newValue) => newValue.copyWith(
                                  text:
                                  newValue.text.replaceAll('.', ','),
                                ))
                          ],
                          onChanged: (newVal){
                            try{
                              currentNegotiation.cpTarget = int.parse(newVal);
                            } on FormatException catch (e){
                              if(newVal != ""){
                                Utils.showSnackBar("Your target value needs to be an integer.");
                                cpTargetController.text = "";
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
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff000000), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff000000), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide:
                                  const BorderSide(color: Color(0xff000000), width: 1),
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
                                      content: const Text("This is your best guess at what your Counterparts BATNA is."),
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
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "(Enter 0 if no BATNA exists)",
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
                          FilteringTextInputFormatter.allow(
                              RegExp(_getRegexString())),
                          TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                text:
                                newValue.text.replaceAll('.', ','),
                              ))
                        ],
                        onChanged: (newVal){
                          try{
                            currentNegotiation.cpBATNA = int.parse(newVal);
                          } on FormatException catch (e){
                            if(newVal != ""){
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
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                const BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                const BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                const BorderSide(color: Color(0xff000000), width: 1),
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
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
                                    content: const Text("This is your best guess at what your counterparts resistance point is."),
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
                          FilteringTextInputFormatter.allow(
                              RegExp(_getRegexString())),
                          TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                text:
                                newValue.text.replaceAll('.', ','),
                              ))
                        ],
                        onChanged: (newVal){
                          try{
                            currentNegotiation.cpResistance = int.parse(newVal);
                          } on FormatException catch (e){
                            if(newVal != ""){
                              Utils.showSnackBar("Your resistance value needs to be an integer.");
                              cpResistanceController.text = "";
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
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                const BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                const BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                const BorderSide(color: Color(0xff000000), width: 1),
                          ),
                          hintText: "Resistance point",
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
              ],
            ),
          ),
        ),
      NextBar(const PlanSummary()),
    ]));
  }
  String _getRegexString() => r'[0-9]';
}

class EnterValues extends StatelessWidget{
  final String? issueName;
  final ctrl = TextEditingController();

  EnterValues({required this.issueName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            issueName!,
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
              FilteringTextInputFormatter.allow(
                  RegExp(_getRegexString())),
              TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                    text:
                    newValue.text.replaceAll('.', ','),
                  ))
            ],
            onChanged: (newVal) {
              currentNegotiation.cpIssues[issueName] = int.parse(newVal);
            },
            controller: ctrl,
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
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 12),
            ),
          ),
        ),
      ],
    );

  }

  String _getRegexString() => r'[0-9]';
}
