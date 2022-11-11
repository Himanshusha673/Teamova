import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String uid;
  final String phoneNo;

  const User({
    required this.name,
    required this.email,
    required this.uid,
    required this.phoneNo,
  });

  static User fromSnap(snap) {
    //converting jason from firebase in snap  to User form feilds
    var snapshot = snap.data() as Map<String, dynamic>;
    debugPrint(snapshot.toString());

    return User(
      name: snapshot["name"],
      email: snapshot["email"],
      uid: snapshot["uid"],
      phoneNo: snapshot["phoneNo"],
    );
  }

//file for converting user fields to json for uplodaing on firebase
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "phoneNo": phoneNo,
      };
}
