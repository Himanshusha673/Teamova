import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../screens/aboutyourself.dart';
import 'circularIndiacator.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isLoading = false;

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      setState(() {
        isLoading = true;
      });

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (await _checkIfUserExists(user!.uid)) {
        log(credential.toString());
        log(user.uid.toString());
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    )));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Aboutyourself(
                      name: user.displayName,
                      email: user.email,
                      password: null,
                      phoneNo: "",
                      user: user,
                    )));
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<bool> _checkIfUserExists(String userId) async {
    // Get a reference to the user's document in Firestore
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // Check if the user's document exists in Firestore
    final doc = await userRef.get();
    return doc.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: ElevatedButton(
          onPressed: () async {
            await _signInWithGoogle(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            backgroundColor: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? const Center(
                        child: TeamCircularProgressIndicator(
                            teamIcon:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&shttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s',
                            size: 40.0,
                            color: Colors.black),
                      )
                    : Icon(
                        size: 30.0,
                        BoxIcons.bxl_google,
                      ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  "Continue With Google",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
