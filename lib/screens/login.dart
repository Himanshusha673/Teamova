import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:team_builder/screens/forgot_password.dart';
import 'package:team_builder/screens/signup.dart';
import 'package:team_builder/utils/colors.dart';

import '../services/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/circularIndiacator.dart';
import 'aboutyourself.dart';
import 'package:sign_button/sign_button.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _logState();
}

class _logState extends State<LogInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  // void _googleSignIn() async {
  //   try {
  //     final googleSignIn = GoogleSignIn();
  //     final signInAccount = await googleSignIn.signIn();

  //     final googleAccountAuthentication = await signInAccount!.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAccountAuthentication.accessToken,
  //         idToken: googleAccountAuthentication.idToken);

  //     await FirebaseAuth.instance.signInWithCredential(credential);

  //     if (FirebaseAuth.instance.currentUser != null) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //             builder: (context) => const ResponsiveLayout(
  //               mobileScreenLayout: MobileScreenLayout(),
  //               webScreenLayout: WebScreenLayout(),
  //             ),
  //           ),
  //           (route) => false);
  //       print('Google Authentication Successful');
  //       print('${FirebaseAuth.instance.currentUser!.displayName} signed in.');
  //       // setState(() {
  //       //   isLoggedIn = true;
  //       //   name = FirebaseAuth.instance.currentUser!.displayName;
  //       // });
  //     } else {
  //       print('Unable to sign in');
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  //  Future<void> _updateUserData(User user) async {
  //   // Get a reference to the users collection in Firestore
  //   final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

  //   // Update the user's data in Firestore
  //   return userRef.set({
  //     'name': user.displayName,
  //     'email': user.email,
  //     'photoURL': user.photoURL,
  //   });
  // }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addUserToFirestore(User user) async {
    // Create a new user document in Firestore
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    // Set the data for the new user document
    await userRef.set({
      'displayName': user.displayName,
      'email': user.email,
      'photoURL': user.photoURL,
    });
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: Container(
                height: 10,
                width: 10,
                child: const TeamCircularProgressIndicator(
                    teamIcon:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&shttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s',
                    size: 64.0,
                    color: Colors.black),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Stack(
                      children: [
                        const Image(
                          image: AssetImage('images/login.png'),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.transparent,
                                child: SizedBox(
                                  // width: MediaQuery.of(context).size.width,
                                  // height: MediaQuery.of(context).size.height,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "images/TeamovaLogo.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined),
                                  labelText: 'Email',
                                  hintText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint_outlined),
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            ForgotPasswordScreen()),
                                      ),
                                    );
                                  },
                                  child: GestureDetector(
                                    child: const Text(
                                      "Forget Password ?", // TODO : Fix feature
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((context) => Registration()),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        loginUser();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        backgroundColor: Colors.black,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Center(
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SignInButton(
                                buttonType: ButtonType.google,
                                buttonSize: ButtonSize.large,
                                onPressed: () async {
                                  User? user = _auth.currentUser;
                                  if (user == null) {
                                    // User is not signed in, start the sign-in process
                                    OAuthCredential credential =
                                        await AuthMethods().signInWithGoogle();
                                    UserCredential userCredential = await _auth
                                        .signInWithCredential(credential);

                                    // UserCredential userCredential =
                                    //     await _auth.signInWithCustomToken(
                                    //         credential.token.toString());
                                    log(credential.toString());
                                    user = userCredential.user;

                                    log(user.toString());
                                  }
                                  // try {
                                  //   User? user = _auth.currentUser;
                                  //   if (user == null) {
                                  //     // User is not signed in, start the sign-in process
                                  //     UserCredential userCredential =
                                  //         await AuthMethods()
                                  //             .signInWithGoogle();
                                  //     user = userCredential.user;
                                  //   }
                                  //   log(user.toString());

                                  //   print(
                                  //       'User signed in: ${user!.displayName}');

                                  //   // Check if the user's data exists in Firestore
                                  //   bool userExists =
                                  //       await _checkIfUserExists(user.uid);
                                  //   if (userExists) {
                                  //     Navigator.of(context).pushAndRemoveUntil(
                                  //         MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               const ResponsiveLayout(
                                  //             mobileScreenLayout:
                                  //                 MobileScreenLayout(),
                                  //             webScreenLayout:
                                  //                 WebScreenLayout(),
                                  //           ),
                                  //         ),
                                  //         (route) => false);

                                  //     print(
                                  //         'User data exists in Firestore, logging in...');
                                  //   } else {
                                  //     Navigator.of(context)
                                  //         .pushReplacement(MaterialPageRoute(
                                  //       builder: (context) => Aboutyourself(
                                  //         email: _emailController.text,
                                  //         password: _passwordController.text,
                                  //         name: user!.displayName,
                                  //         phoneNo: '',
                                  //       ),
                                  //     ));

                                  //     print(
                                  //         'User data does not exist in Firestore, creating account...');

                                  //     // Add the new user to Firestore
                                  //     // await _addUserToFirestore(user);
                                  //   }
                                  // } catch (e) {
                                  //   print('Sign-in error: $e');
                                  // }
                                }, // !TODO : Google sign in
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.copyright,
                                  color: Colors.red, size: 16.0),
                              SizedBox(width: 4.0),
                              Text(
                                ' 2023 Teamova. All rights reserved.',
                                style: TextStyle(fontSize: 14),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
