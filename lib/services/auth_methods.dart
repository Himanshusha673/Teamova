import 'dart:developer';

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_builder/models/user_model.dart' as model;
import 'package:team_builder/services/storage_methods.dart';

// when user authetication completed then storing it to our firebase storage
class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    var data = model.UserModel.fromSnap(documentSnapshot);
    //debugPrint(data.description);

    return model.UserModel.fromSnap(documentSnapshot);
  }

  // Signing Up Use
  Future<String> signUpUserWithEmailPassword({
    required String name,
    required String email,
    required String password,
    required String phoneNo,
    required List skills,
    required bool isLeader,
    required String objective,
    required String description,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          phoneNo.isNotEmpty ||
          skills.isNotEmpty ||
          objective.isNotEmpty ||
          file.isNotEmpty) {
        if (password == null) {}
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('step1');
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        // String photoUrl = "null";
        print('step2');

        model.UserModel user = model.UserModel(
          isLeader: isLeader,
          skills: skills,
          objective: objective,
          name: name,
          email: email,
          uid: cred.user!.uid,
          phoneNo: phoneNo,
          description: description,
          photoUrl: photoUrl,
        );
        print('step3');

        // adding user in our firestore database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Signing Up Use
  Future<String> signUpUserWithGoogle({
    required List skills,
    required bool isLeader,
    required String objective,
    required String description,
    required Uint8List? file,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    String res = "Some error Occurred";
    log("i am in gooogle signup");
    try {
      if (skills.isNotEmpty || objective.isNotEmpty) {
        print('step1');
        if (file != null) {
          String photoUrl = await StorageMethods()
              .uploadImageToStorage('profilePics', file, false);
        }

        // String photoUrl = "null";
        print('step2');

        model.UserModel userModel = model.UserModel(
          isLeader: isLeader,
          skills: skills,
          objective: objective,
          name: user!.displayName!,
          email: user.email!,
          uid: user.uid,
          phoneNo: "no number",
          description: description,
          photoUrl: user.photoURL!,
        );
        print('step3');

        // adding user in our firestore database
        await _firestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<OAuthCredential> signInWithGoogle() async {
    log("i am in gooogle");
    // Initialize Firebase
    await Firebase.initializeApp();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the Google sign-in
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return credential;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }

    // Start the Google sign-in process

    // Sign in to Firebase with the credential
  }

  Future<void> signOut() async {
    log("calling sinout");
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null &&
        user.providerData.any((info) =>
            info.providerId == GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD)) {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
      await _auth.signOut();
    } else {
      await _auth.signOut();
    }
  }
}
