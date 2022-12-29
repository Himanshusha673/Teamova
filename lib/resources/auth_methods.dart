import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_builder/models/user_model.dart' as model;
import 'package:team_builder/resources/storage_methods.dart';

// when user authetication completed then storing it to our firebase storage
class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    var data = model.User.fromSnap(documentSnapshot);
    //debugPrint(data.description);

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up Use
  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required String phoneNo,
    required List skills,
    required bool isLeader,
    required String objective,
    required String description,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          phoneNo.isNotEmpty ||
          skills.isNotEmpty ||
          objective.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        model.User user = model.User(
            isLeader: isLeader,
            skills: skills,
            objective: objective,
            name: name,
            email: email,
            uid: cred.user!.uid,
            phoneNo: phoneNo,
            description: description);

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

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
