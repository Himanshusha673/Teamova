import 'dart:developer';

import 'package:flutter/widgets.dart';

import '../models/user_model.dart';
import '../services/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    try {
      UserModel userDetails = await _authMethods.getUserDetails();

      _user = userDetails;
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  UserModel get getUser =>
      _user ??
      const UserModel(
          photoUrl: "",
          name: "random",
          email: "test@gmail.com",
          uid: "uid",
          phoneNo: "no number",
          skills: [],
          isLeader: true,
          objective: "",
          description: "");
}

final userDetails = UserProvider();
