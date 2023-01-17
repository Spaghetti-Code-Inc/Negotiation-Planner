///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:math';

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

  final _items = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _addIssues() {
    print('Add issues button clicked');
    _items.insert(0, 'Issue ${_items.length + 1}');
    _key.currentState!.insertItem(0, duration: const Duration(milliseconds: 200));
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: const PrepareBar(),

      body: Column(

        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text('How to Determine Issues'),
                      content: const Text(
                          'An issue is something the negotiators will try to reach an agreement on. Consider all the issues relevant to their negotiation. Be sure to include any issues that could make the deal better for you and/or your counterpart.'
                      ),
                      actions: [
                        TextButton(

                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                          const Text('OK',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),

                        ),
                      ]
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4d4d4d),
              ),
              child: const Text('How to Determine Issues'),
            ),
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
                          color: const Color(0xff4d4d4d),
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
          Container(
            child: Column(
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
          )
        ]
      )
    );
  }
}

abstract class ListItem {
  Widget TextField();
}

