import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../NegotiationDetails.dart';
import 'IssueValues.dart';
import 'package:negotiation_tracker/Utils.dart';
import '../main.dart';
import 'MAX_LENGTHS.dart';

class WeightIssues extends StatefulWidget {
  const WeightIssues({super.key});

  State<WeightIssues> createState() => _WeightIssuesState();
}

class _WeightIssuesState extends State<WeightIssues> {
  bool iconColor = false;

  List<TextEditingController> _controllers = [TextEditingController()];

  int totalVal = 0;
  int length = currentNegotiation.issues.length;


  @override
  void initState(){
    for (int i = 0; i < length; i++) {
      _controllers.add(new TextEditingController());
      if(currentNegotiation.issues[i].relativeValue != -1){
        _controllers[i].text = currentNegotiation.issues[i].relativeValue.toString();
        if(_controllers[i].text == "0") _controllers[i].text = "";
      }
      else _controllers[i].text = "";
    }
    if(length == 1){
      _controllers[0].text = "100";
      totalVal = 100;
    }
    total();

    super.initState();
  }


  total() {
    int total = 0;
    for (TextEditingController cont in _controllers) {
      try {
        total += int.parse(cont.text);
      } on FormatException catch (e) {

      }

    }

    setState((){
      totalVal = total;
    });

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
          Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 0, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Step 2/3",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.normal,
                          fontSize: 22,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(48, 8, 0, 0),
                    child: Text(
                      "Weight The Issues",
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
                ],
              )),
              Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    color: iconColor ? Colors.black : Color(0xff0A0A5B),
                    onPressed: () {
                      setState(() {
                        iconColor = true;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Weight The Issues'),
                          content: const Text(
                              'Allocate a number of points for each issue. Give a higher number'
                              ' of points to more important issues.'),
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
                    iconSize: 40,
                  )),
            ]),
          ),

          Divider(thickness: 2, color: Colors.black,),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  padding: EdgeInsets.all(0),
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                    ),
                    border: Border.all(color: Color(0xff0A0A5B), width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Issues",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff0A0A5B),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                  padding: EdgeInsets.all(0),
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    border: Border.all(color: Color(0xff0A0A5B), width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Points",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff0A0A5B),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          /// Total Points and Distribute Evenly Buttons
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Total Points: " + totalVal.toString() + "/100",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
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

          Divider(thickness: 2, color: Colors.black),

          Expanded(
            child: ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {

                return Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            currentNegotiation.issues[index].name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      // Sets slight area between points and issue column
                      Container(
                        width: 70,
                      ),
                      Expanded(
                        child: Center(
                            child: TextFormField(
                              onChanged: (newVal) {
                                try{
                                  currentNegotiation.issues[index].relativeValue = int.parse(_controllers[index].text);
                                } catch (e){
                                  currentNegotiation.issues[index].relativeValue = 0;
                                }
                                total();
                              },
                              // Only allows digits 0-9, max length of 2
                              inputFormatters: INTEGER_INPUTS,
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              cursorColor: Color(0xff0A0A5B),
                              keyboardType: TextInputType.number,
                              controller: _controllers[index],

                              decoration: InputDecoration(
                                hintText: "0",
                                enabledBorder: (
                                  OutlineInputBorder(
                                    borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B)),
                                    borderRadius: BorderRadius.circular(20),
                                  )
                                ),
                                focusedBorder: (
                                  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(width: 3, color: Color(0xff0A0A5B))
                                  )
                                )

                              ),
                        )),
                      ),
                      //adds padding between input field and right side of screen
                      Container(
                        width: 10,
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),

          /// Next and back buttons
          PrepareNegotiationNextBar(Next: Next, NextPage: IssueValues())

        ],
      ),
    );
  }

  bool Next(){
    if (totalVal == 100) {
      // length represents _issueNames
      for (int i = 0; i < currentNegotiation.issues.length; i++) {
        currentNegotiation.issues[i].relativeValue = int.parse(_controllers[i].text);
      }

      return true;
    } else {
      Utils.showSnackBar("Total must equal exactly 100.");
      return false;
    }
  }

  EvenlyDistribute(){
    int length = currentNegotiation.issues.length;

    // How much each issue should be weighed
    int step = (100/length).truncate();
    // Home much extra points would be left over
    int extra = 100%(length*step);

    // Sets current negotiation and text values to the correct number
    for(int i = 0; i < length; i++){
      if(extra > 0){
        _controllers[i].text = (step+1).toString();
        extra--;
      } else {
        _controllers[i].text = (step).toString();
      }

      currentNegotiation.issues[i].relativeValue = step;
    }

    setState((){
      totalVal = 100;
    });
  }

}
