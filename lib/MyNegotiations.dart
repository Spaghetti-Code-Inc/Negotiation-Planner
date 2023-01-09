///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

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
            color: Color(0xff000000),
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Color(0xff212435),
          size: 24,
        ),
        actions: const [
          Icon(Icons.search, color: Color(0xff212435), size: 24),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Negotiation>>(
            future: DatabaseHelper.instance.getNegotiations(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Negotiation>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Add A New Negotiation'));
              }
              return ListView(
                children: snapshot.data!.map((negotiation) {
                  return Center(
                      child: ListTile(
                    title: Text(negotiation.title),
                  ));
                }).toList(),
              );
            }),
      ),
    );
  }
}
