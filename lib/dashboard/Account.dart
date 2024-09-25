import 'dart:math';
import 'package:flutter/material.dart';
import 'package:online_quiz_app/constant.dart';
import '../auth/Login.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String uid = "";
  String imageid = "";
  String username = "";
  String email = "";

  String coinavailable = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //inputData();
    //fetchCoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Details",
        ),
        backgroundColor: appbar,
      ),
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            height: 110,
            width: 110,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                imageid,
                scale: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          username.toUpperCase(),
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          email,
          style: TextStyle(fontSize: 15, color: Colors.grey[500]),
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: MaterialButton(
            onPressed: () {
              //signOut();
            },
            child: Card(
                color: Color.fromARGB(255, 227, 227, 227),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 46, 46, 46)),
                  )),
                )),
          ),
        )
      ]),
    );
  }

  // void inputData() {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User? user = auth.currentUser;
  //   setState(() {
  //     uid = (user!.displayName).toString();
  //     imageid = (user.photoURL).toString();
  //     username = (user.displayName).toString();
  //     email = (user.email).toString();
  //   });

  //   print(imageid);
  // }

//  void signOut() {
//     FirebaseAuth.instance.signOut();
//     User? user = FirebaseAuth.instance.currentUser;
//     runApp(new MaterialApp(
//       home: SplashScreen(),
//     ));
//   }

  // void share() async {
  //   final appId = "com.example.extra_views";
  //   final box = context.findRenderObject() as RenderBox?;
  //   final url = "https://play.google.com/store/apps/details?id=$appId";
  //   await Share.share(
  //     "Extra Views\n" + url.toString(),
  //     subject: "Get More Reach and Views",
  //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  //   );
  // }

  // void send_coin_to_server(String coinavailable) {
  //   final ref = FirebaseDatabase.instance.ref();
  //   int avl = int.parse(coinavailable);
  //   int sum = avl + 50;

  //   ref.child("coin_database").child(uid).set(sum.toString());
  // }
}
