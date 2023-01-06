///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcfcfcf),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffcfcfcf),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "SETTINGS",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            color: Color(0xff000000),
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Color(0xff212435),
          size: 24,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network("https://picsum.photos/250?image=13",
                      fit: BoxFit.cover),
                ),
                const ListTile(
                  tileColor: Color(0x00000000),
                  title: Text(
                    "John Doe",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    "San Francisco, CA",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  dense: false,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  selected: false,
                  selectedTileColor: Color(0x42000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xff000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(45.0),
                    border:
                        Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                    color: const Color(0xffffffff),
                    iconSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            padding: const EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: const Color(0x6c000000),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
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
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {},
                        color: const Color(0xffffffff),
                        iconSize: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text(
                          "Notifications",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                          color: const Color(0xffffffff),
                          iconSize: 24,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "General",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person),
                          onPressed: () {},
                          color: const Color(0xffffffff),
                          iconSize: 24,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "Account",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {},
                          color: const Color(0xffffffff),
                          iconSize: 24,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "Privacy",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {},
                          color: const Color(0xffffffff),
                          iconSize: 24,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "Block",
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.help),
                          onPressed: () {},
                          color: const Color(0xffffffff),
                          iconSize: 24,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "Help",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
