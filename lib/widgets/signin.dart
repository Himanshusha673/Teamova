import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

class SignIn extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  SignIn({super.key});

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      print(credential.toString());
      print(user.toString());
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: ElevatedButton(
            onPressed: _signInWithGoogle,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              backgroundColor: Colors.black,
            ),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    size: 30.0,
                    BoxIcons.bxl_google,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Google Sign In",
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
      ),
    );
  }
}
