// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:negotiation_tracker/Start.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Negotiation Planner',
    home: Start(),
  ));
}

// Header for all "Prepare A New Negotiation" pages
class PrepareBar extends StatelessWidget implements PreferredSizeWidget {
  const PrepareBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF3B66B7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      title: const Text(
        "Prepare A New Negotiation",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          color: Color(0xffffffff),
        ),
      ),
      leading: const Icon(
        Icons.arrow_back,
        color: Color(0xffffffff),
        size: 24,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
}

// Bar that sits at bottom of "Prepare A New Negotiation" Pages
class NextBar extends StatelessWidget {
  Widget nextPage;

  NextBar(this.nextPage, {super.key});

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0x1fffffff),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.zero,
        border: Border.all(color: const Color(0x4dffffff), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color(0xff4d4d4d),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Color(0xff808080), width: 1),
              ),
              padding: const EdgeInsets.all(16),
              textColor: const Color(0xffffffff),
              height: 40,
              minWidth: 140,
              child: const Text(
                "Back",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              },
              color: const Color(0xff4d4d4d),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Color(0xff808080), width: 1),
              ),
              padding: const EdgeInsets.all(16),
              textColor: const Color(0xffffffff),
              height: 40,
              minWidth: 140,
              child: const Text(
                "Next",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



