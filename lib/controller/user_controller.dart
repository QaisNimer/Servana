import 'package:flutter/material.dart';
import '../model/user_model.dart';

class UserController extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }

  void updateUser({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
    String? imageUrl,
  }) {
    if (_user != null) {
      _user = _user!.copyWith(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        imageUrl: imageUrl,
      );
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
