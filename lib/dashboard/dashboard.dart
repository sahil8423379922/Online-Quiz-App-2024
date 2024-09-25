import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_quiz_app/constant.dart';
import 'package:online_quiz_app/dashboard/Account.dart';
import 'package:online_quiz_app/dashboard/livequiz.dart';
import 'package:online_quiz_app/dashboard/mocktest.dart';
import 'package:online_quiz_app/subscription/locked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/Login.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var username = "User";
  var useremail = 'example@gmail.com';
  var subscriptionstatus = '';
  var subscriptiondate = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchuserdetails();
    fetchsubscription();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchuserdetails() async {
    var email = widget.user.email;
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('users').doc(email).get();

      if (docSnapshot.exists) {
        // If the document exists, you can access its data
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        String name = data['name'];
        String email = data['email'];

        setState(() {
          username = data['name'];
          useremail = email;
        });

        // Print or use the fetched data
        print('Name: $name, Email: $email');
      } else {
        // Document does not exist
        print('No user found with email: $email');
      }
    } catch (e) {
      // Handle any errors that may occur
      print('Error fetching data: $e');
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => {exit(0)},
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbar, // AppBar background color
          title: Text("Hi, ${username}"),
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
          backgroundColor: Color.fromARGB(255, 255, 245, 245),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: appbar,
                  child: DrawerHeader(
                      child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/sample_image.jpg'),
                                  //child: Image.network(imageid),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        username,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        useremail,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Account(),
                          ));
                        });
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey[150],
                      ),
                      subtitle: Text("User Account Details"),
                      leading: Icon(
                        Icons.person_outline,
                        size: 28,
                        color: Colors.grey[150],
                      ),
                      title: Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "arial",
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListTile(
                      onTap: () {
                        var url = Uri.parse(
                            "https://sites.google.com/view/extraviewsprivacypolicy/home");
                        launchUrl(url);
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey[150],
                      ),
                      subtitle: Text("Policy and Privacy"),
                      leading: Icon(
                        Icons.privacy_tip_outlined,
                        size: 28,
                        color: Colors.grey[150],
                      ),
                      title: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "arial",
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListTile(
                      onTap: () {
                        var url = Uri.parse(
                            "https://sites.google.com/view/extraviewstermsandcondition/home");
                        launchUrl(url);
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey[150],
                      ),
                      subtitle: Text("Know more"),
                      leading: Icon(
                        Icons.info_outline,
                        size: 28,
                        color: Colors.grey[150],
                      ),
                      title: Text(
                        "Terms and Condition",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "arial",
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListTile(
                      onTap: () {
                        try {
                          launch("market://details?id=" +
                              "com.experttechtechnology.extraviews");
                        } on PlatformException catch (e) {
                          launch(
                              "https://play.google.com/store/apps/details?id=" +
                                  "com.experttechtechnology.extraviews");
                        } finally {
                          launch(
                              "https://play.google.com/store/apps/details?id=" +
                                  "com.experttechtechnology.extraviews");
                        }
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey[150],
                      ),
                      subtitle: Text("Rating on Playstore"),
                      leading: Icon(
                        Icons.star_border_outlined,
                        size: 28,
                        color: Colors.grey[150],
                      ),
                      title: Text(
                        "Rate US",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "arial",
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListTile(
                      onTap: () {
                        Random random = new Random();
                        int randomNumber = random.nextInt(100);
                        // DynamicLinkProvider()
                        //     .createlink(uid + randomNumber.toString())
                        //     .then((value) => {
                        //           Share.share(
                        //               "To Get free Youtube subscribers and watchtime use Extra Views:\nSub4Sub - 1Vs10 App.\n\nUse my referral link to get 1000 coins as login bonous.\n\nAppLink:\n" +
                        //                   value)
                        //         });
                        // share();
                        //send_coin_to_server(coinavailable);
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey[150],
                      ),
                      subtitle: Text("Share"),
                      leading: Icon(
                        Icons.share_outlined,
                        size: 28,
                        color: Colors.grey[150],
                      ),
                      title: Text(
                        "Share",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "arial",
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListTile(
                      onTap: () {
                        signOut();
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey[150],
                      ),
                      subtitle: Text("Logout From Account"),
                      leading: Icon(
                        Icons.logout_outlined,
                        size: 28,
                        color: Colors.grey[150],
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "arial",
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListTile(
                      onTap: () {
                        _onWillPop();
                      },
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey[150],
                      ),
                      subtitle: Text("Exit From App"),
                      leading: Icon(
                        Icons.exit_to_app,
                        size: 28,
                        color: Colors.grey[150],
                      ),
                      title: Text(
                        "Exit",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "arial",
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            LiveQuiz(subscription: subscriptionstatus, user: widget.user),
            subscriptionstatus == 'paid'
                ? MockTest()
                : Locked(user: widget.user)
          ],
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
      ),
    );
  }

  Future<void> signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut(); // Sign out from Firebase
      // Redirect to the Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Handle any errors here
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error signing out: $e")),
      );
    }
  }

  Future<void> fetchsubscription() async {
    var email = widget.user.email;
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('subscription').doc(email).get();

      if (docSnapshot.exists) {
        // If the document exists, you can access its data
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        String status = data['status'];

        //Timestamp date = data['date'];
        //DateTime dateTime = date.toDate();

        setState(() {
          subscriptionstatus = status;
          //subscriptiondate = date;
        });

        // Print or use the fetched data
        print('Status: $status');
      } else {
        // Document does not exist
        print('No user found with email: $email');
      }
    } catch (e) {
      // Handle any errors that may occur
      print('Error fetching data: $e');
    }
  }
}
