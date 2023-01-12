///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'dart:developer';

import 'package:flutter/material.dart';

import 'NegotiationDetails.dart';

class MyNegotiations extends StatelessWidget {
  const MyNegotiations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff000000),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "My Negotiations",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xffffffff),
          ),
        ),
        leading: const Icon(
          Icons.sort,
          color: Color(0xffffffff),
          size: 24,
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Negotiation>>(
            future: DatabaseHelper.instance.getNegotiations(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Negotiation>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Add A New Negotiation'));
              }
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListView(
                    children: snapshot.data!.map((negotiation) {
                      return NegotiationContainer(negotiation: negotiation);
                    }).toList(),
                  ));
            }),
      ),
    );
  }
}

class NegotiationContainer extends StatefulWidget {
  final Negotiation negotiation;
  const NegotiationContainer({Key? key, required this.negotiation})
      : super(key: key);

  _NegotiationContainerState createState() => _NegotiationContainerState();
}

class _NegotiationContainerState extends State<NegotiationContainer> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(
            top: (isHover) ? 18 : 20, bottom: !(isHover) ? 18 : 20,
            right: (isHover) ? 20: 30, left: !(isHover) ? 20: 30),
        child: InkWell(
          child: Container(
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0x1f000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.negotiation.title,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "This is where the summary of the negotiation goes. ",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Most important issue",
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Second important issue",
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Third issue",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {},
                          color: const Color(0xff838383),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          textColor: const Color(0xffffffff),
                          height: 45,
                          minWidth: 140,
                          child: const Text(
                            "View",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () {},
                          color: const Color(0xff838383),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          textColor: const Color(0xffffffff),
                          height: 45,
                          minWidth: 140,
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
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
          onTap: () {},
          onHover: (val) {
            setState(() {
              isHover = val;
            });
            log(val.toString());
          },
          /*val--->true when user brings in mouse
         val---> false when brings out his mouse*/
        ));
  }
}
