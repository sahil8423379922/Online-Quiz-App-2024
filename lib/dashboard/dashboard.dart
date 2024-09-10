import 'package:flutter/material.dart';
import 'package:online_quiz_app/constant.dart';
import 'package:online_quiz_app/dashboard/livequiz.dart';
import 'package:online_quiz_app/dashboard/mocktest.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar, // AppBar background color
        title: const Text("Hi, Sahil Jaiswal"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/sample_image.jpg'),
              radius: 20,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: const [Text("$appName")],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [LiveQuiz(), MockTest()],
      ),
      bottomNavigationBar: Container(
        color: appbar, // TabBar background color
        child: Stack(
          children: [
            TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: indicatiorColor, // Tab indicator color (upward)
                    width: 4.0, // Thickness of the indicator
                  ),
                ),
              ),
              labelColor: Colors.white, // Active tab text/icon color
              // Inactive tab text/icon color
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.quiz),
                      SizedBox(
                        width: 8,
                      ), // Space between the icon and text
                      Text('Quiz'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.edit_document),
                      SizedBox(
                        width: 8,
                      ), // Space between the icon and text
                      Text('Mock Test'),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned Divider between the two tabs
            Positioned(
              left: MediaQuery.of(context).size.width / 2 -
                  0.5, // Center the divider
              top: 8,
              bottom: 8,
              child: Container(
                width: 1,
                color:
                    const Color.fromARGB(255, 180, 179, 179), // Divider color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
