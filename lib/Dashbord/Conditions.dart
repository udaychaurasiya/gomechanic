// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gomechanic/Dashbord/DileveyImages.dart';
import 'package:gomechanic/Dashbord/PickImages.dart';

class Conditions extends StatefulWidget {
  const Conditions({Key? key}) : super(key: key);

  @override
  State<Conditions> createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Conditions"),
            bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('Pick Images',
                        style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child: Text('Delivery Images',
                        style: TextStyle(color: Colors.white)),
                  ),
                ]),
          ),
          body: const TabBarView(
            children: [PickImages(bookingId: '', status: '',), ReadyDeliverImage(bookingId: '', status: '',)],
          )
    ),
    );
  }
}
