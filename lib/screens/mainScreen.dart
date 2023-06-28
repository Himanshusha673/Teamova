import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import 'aboutyourself.dart';
import 'login.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return myStreamBuuilder();
  }

  Future<bool> _checkIfUserExists(String userId) async {
    // Get a reference to the user's document in Firestore
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // Check if the user's document exists in Firestore
    final doc = await userRef.get();
    return doc.exists;
  }

  Widget myStreamBuuilder() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final User? user = snapshot.data;
            log("in main");
            if (user != null &&
                user.providerData.any((info) =>
                    info.providerId ==
                    GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD)) {
              return FutureBuilder<bool>(
                future: _checkIfUserExists(user.uid),
                builder: (context, snap) {
                  log("in future");

                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snap.hasData && snap.data == true) {
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else {
                    return Aboutyourself(
                      name: user.displayName,
                      email: user.email,
                      password: null,
                      phoneNo: "",
                      user: user,
                    );
                  }
                },
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const LogInPage();
      },
    );
  }
}
