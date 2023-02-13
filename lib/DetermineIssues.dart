///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:negotiation_tracker/StartNewNegotiation.dart';
import 'package:negotiation_tracker/WeightIssues.dart';

import 'main.dart';

class DetermineIssues extends StatefulWidget {
  const DetermineIssues({Key? key}) : super(key: key);

  @override
  _DetermineIssuesState createState() => _DetermineIssuesState();

}

class _DetermineIssuesState extends State<DetermineIssues> {
  bool iconColor = false;
  final _items = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _addIssues() {
    if (kDebugMode) {
      print('Add issues button clicked');
    }
    _items.insert(0, 'Issue ${_items.length + 1}');
    _key.currentState!.insertItem(0, duration: const Duration(milliseconds: 200));
    //meant to reset issue numbers inside text box in descending order
    for(int i = 0; i < _items.length; i++){
      if(_items[i].contains("Issue")){
        _items[i] = 'Issue ${i + 1}';
      }//end if
    }//end for
  }//end add issues

  void _removeIssue(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Color(0xFFDB7877),
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      );
    }, duration : const Duration(milliseconds: 200));
    _items.removeAt(index);
    //meant to reset issue numbers inside textbox in descending order
    for(int i = 0; i < _items.length; i++){
      if(_items[i].contains("Issue")){
        _items[i] = 'Issue ${i + 1}';
      }//end if
    }//end for
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),

      body: Column(

        children: [
          Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x7f000000), width: 1),
            ),
            child: Row(children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max, children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(48, 0, 0, 0),
                      child: Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Step 1/3",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                fontSize: 28,
                                color: Color(0xff000000),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(48, 8, 0, 0),
                      child: Text(
                        "Determine The Issues",
                        textAlign: TextAlign.start,
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
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    color: iconColor ? Colors.black : const Color(0xFF3B66B7),
                    onPressed: () {
                      setState(() {
                        iconColor = true;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('How to Determine Issues', textAlign: TextAlign.center,),
                          content: const Text(
                              'An issue is something the negotiators will try to reach an agreement on. '
                                  'Consider all the issues relevant to their negotiation. '
                                  'Be sure to include any issues that could make the deal better '
                                  'for you and/or your counterpart.'

                          ),

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
                    iconSize: 40,
                  )),
            ]),
          ),

          Expanded(
            child: AnimatedList(
                key: _key,
                initialItemCount: 0,
                padding: const EdgeInsets.all(10),
                itemBuilder: (_, index, animation) {
                  return SizeTransition(
                      key: UniqueKey(),
                      sizeFactor: animation,
                      child: Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 10,
                          color: const Color.fromRGBO(50, 50, 50, 100),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            title: TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: _items[index],
                              ),
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            /*title: Text(_items[index],
                                style:
                                const TextStyle(fontSize: 24, color: Colors.white)),*/
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFDB7877),
                              ),
                              onPressed: () => _removeIssue(index),
                            ),
                          )
                      )
                  );
                } // item builder
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(22),
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: const Color(0xff4d4d4d),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _addIssues,
                  child: const Text('Add Issues')
                ),
              ),
              NextBar(const WeightIssues()),
            ],
          )
        ]
      )
    );
  }
}

abstract class ListItem {
  Widget TextField();
}



