import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_quiz_app/constant.dart';

import 'dynamicrowscreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbar,
          title: Text("Hi, Sahil Jaiswal"),
          actions: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/sample_image.jpg'),
                radius: 20,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(children: [
            DrawerHeader(
                child: Column(
              children: [Text("$appName")],
            ))
          ]),
        ),
        body: DynamicRowScreen());
  }
}
