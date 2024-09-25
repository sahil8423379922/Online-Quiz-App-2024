import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_quiz_app/auth/Login.dart';
import 'package:online_quiz_app/subscription/plan.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

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
                  child: Image.asset("assets/signup.png"),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Register',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Enter Details to Register',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 63, 63, 63)),
                ),
                const SizedBox(height: 30),

                // Form for Name input
                FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'Name',
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: "Enter your name",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            prefixIcon: Icon(Icons.people),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        // Form for Email input
                        SizedBox(
                          height: 58,
                          child: FormBuilderTextField(
                            name: 'Email',
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: "Enter your mail",
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
                        // Form for Password input
                        SizedBox(
                          height: 58,
                          child: FormBuilderTextField(
                            name: 'Password',
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: "Enter the password",
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                    icon: Icon(_isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            keyboardType: TextInputType.text,
                            obscureText: !_isPasswordVisible,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    )),

                // Button to submit the form
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(160, 39, 114, 253),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    _register();
                  },
                  child: const SizedBox(
                    height: 48,
                    width: 160,
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Navigate to Login Screen
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                  },
                  child: const Text(
                    "Already have an Account? Login",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // Get the values of the inputs
      final name = _formKey.currentState?.fields['Name']?.value ?? "";
      final email = _formKey.currentState?.fields['Email']?.value ?? "";
      final password = _formKey.currentState?.fields['Password']?.value ?? "";

      // Print the received values
      print("Name: $name");
      print("Email: $email");
      print("Password: $password");

      // Validate input fields
      if (name.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter the Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

        return;
      } else if (email.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

        return;
      } else if (password.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please Enter The Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      // Print the received values
      print("Name: $name");
      print("Email: $email");
      print("Password: $password");

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        User? user = credential.user;
        if (user != null) {
          print(user);
          print(user.displayName);
          print("Email Received =${user.email}");
          // Show success toast
          Fluttertoast.showToast(
            msg: "Register successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          addData(name, email);
          // Navigate to the Plan screen with user data
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Plan(user: user),
          ));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
            msg: 'The password provided is too weak.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
            msg: 'The account already exists for that email.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(
          msg: 'An unexpected error occurred.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please fill in all fields.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> addData(String name, String email) async {
    // Use 'set' to specify the document ID as the user's email
    await firestore.collection('users').doc(email).set({
      'name': name,
      'email': email,
    });
  }
}
