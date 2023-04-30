import 'dart:developer';

import 'package:flutter/widgets.dart';

import '../models/user_model.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    log("name is ${user.name}");
    notifyListeners();
  }
}
