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

class PrepareBar extends StatelessWidget implements PreferredSizeWidget{
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


