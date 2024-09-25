import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_quiz_app/auth/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_quiz_app/dashboard/dashboard.dart'; // Import fluttertoast

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent the UI from moving up
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 240,
                  width: 240,
                  child: Image.asset("assets/login.png"),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Login',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Enter Details to Login',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 63, 63, 63)),
                ),
                const SizedBox(height: 30),

                // FormBuilder should wrap all fields
                FormBuilder(
                  key: _formKey, // One key for the entire form
                  child: Column(
                    children: [
                      // Email field
                      SizedBox(
                        height: 58,
                        child: FormBuilderTextField(
                          name: 'Email',
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            prefixIcon: Icon(Icons.mail),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Password field
                      SizedBox(
                        height: 58,
                        child: FormBuilderTextField(
                          name:
                              'pass', // Match with the name in your _login function
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true, // Hide the password input
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(160, 39, 114, 253),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    _login();
                  },
                  child: const SizedBox(
                    height: 48,
                    width: 160,
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Sign Up Redirect
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ));
                  },
                  child: const Text(
                    "Don't have an account? Signup",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Login function

  Future<void> _login() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var email = "";
      var password = "";
      // Get values of email and password

      final e = _formKey.currentState?.fields['Email']?.value;
      final p = _formKey.currentState?.fields['pass']?.value;
      if (e == null) {
        email = "";
      } else {
        email = e;
      }

      if (p == null) {
        password = "";
      } else {
        password = p;
      }

      if (email.isEmpty || password.isEmpty) {
        // Show toast if email or password is empty
        Fluttertoast.showToast(
          msg: "Email or Password cannot be empty", // Toast message
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // Toast position
          backgroundColor: Colors.red, // Background color
          textColor: Colors.white, // Text color
        );
      } else {
        // Both email and password are filled
        print("Email Received: $email");
        print("Password Received: $password");

        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          // If successful, you can access the user's information
          User? user = credential.user;
          if (user != null) {
            Fluttertoast.showToast(
              msg: "Login successful!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Dashboard(user: user),
            ));
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            Fluttertoast.showToast(
              msg: "No user found for that email.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          } else if (e.code == 'wrong-password') {
            Fluttertoast.showToast(
              msg: "Wrong password provided for that user.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
            print('Wrong password provided for that user.');
          }
        }

        // Perform login logic here
      }
    } else {
      // Show toast if form validation fails
      Fluttertoast.showToast(
        msg: "Validation failed. Please enter valid details.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
