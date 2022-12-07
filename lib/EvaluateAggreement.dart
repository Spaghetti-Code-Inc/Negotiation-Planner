///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

class EvaluateAggreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Evaluate Aggreement",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xffffffff),
          ),
        ),
        leading: Icon(
          Icons.sort,
          color: Color(0xffffffff),
          size: 24,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Icon(Icons.search, color: Color(0xffffffff), size: 24),
          ),
        ],
      ),
      drawer: FlutterVizDrawer(
        elevation: 16,
        headerColor: Color(0xff3ae844),
        profileImage: AssetImage("images/View-rece.jpg"),
        name: "Mr. Mister",
        nameStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          color: Color(0xffffffff),
        ),
        email: "whowhenwhere@gmail.com",
        emailStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xffffffff),
        ),
        drawerItems: flutterVizDrawerItems,
        iconColor: Color(0xff212435),
        iconSize: 24,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xff000000),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "ISSUE 1:",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(170, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(Icons.expand_more),
                            onPressed: () {},
                            color: Color(0xff212435),
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      onChanged: (value) {},
                      value: 0,
                      min: 0,
                      max: 10,
                      activeColor: Color(0xff000000),
                      inactiveColor: Color(0xff9e9e9e),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: Text(
                              "ISSUE 2:",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(170, 0, 0, 0),
                            child: IconButton(
                              icon: Icon(Icons.expand_more),
                              onPressed: () {},
                              color: Color(0xff212435),
                              iconSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      onChanged: (value) {},
                      value: 0,
                      min: 0,
                      max: 10,
                      activeColor: Color(0xff000000),
                      inactiveColor: Color(0xff9e9e9e),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                          child: Text(
                            "ISSUE 3:",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(170, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(Icons.expand_more),
                            onPressed: () {},
                            color: Color(0xff212435),
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      onChanged: (value) {},
                      value: 0,
                      min: 0,
                      max: 10,
                      activeColor: Color(0xff000000),
                      inactiveColor: Color(0xff9e9e9e),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Color(0xff4d4d4d),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Flag",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xffffffff),
                        height: 40,
                        minWidth: 140,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Color(0xffbfbfbf),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xff000000),
                        height: 40,
                        minWidth: 140,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Color(0xffbfbfbf),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Tradeoffs",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xff000000),
                        height: 40,
                        minWidth: 140,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Color(0xff4d4d4d),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Exit",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xffffffff),
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ),
                  ],
                ),
              ),
              LinearProgressIndicator(
                  backgroundColor: Color(0xff808080),
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xff3a57e8)),
                  value: 0.5,
                  minHeight: 3),
            ],
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
            color: Color(0xff212435),
            iconSize: 24,
          ),
        ],
      ),
    );
  }
}
