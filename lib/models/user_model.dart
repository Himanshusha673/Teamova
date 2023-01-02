import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String uid;
  final String phoneNo;
  final String description;
  final bool isLeader;
  final String photoUrl;
  final List skills;
  final String objective;

  const User({
    required this.photoUrl,
    required this.name,
    required this.email,
    required this.uid,
    required this.phoneNo,
    required this.skills,
    required this.isLeader,
    required this.objective,
    required this.description,
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
      skills: snapshot["skills"],
      isLeader: snapshot["isLeader"],
      objective: snapshot["objective"],
      description: snapshot["description"],
      photoUrl: snapshot["photoUrl"],
    );
  }

//file for converting user fields to json for uplodaing on firebase
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "phoneNo": phoneNo,
        "skills": skills,
        "isLeader": isLeader,
        "objective": objective,
        "description": description,
        "photoUrl": photoUrl,
      };
}
