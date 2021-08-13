import 'package:managents/models/authentication/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _user;
  String _token;
  UserApp _userModel;
  //User(this._user, this._password, this._token);
  get user {
    return _user;
  }

  set user(String user) {
    this._user = user;
    notifyListeners();
  }

  get password {
    return _user;
  }

  get token {
    return _token;
  }

  set token(String token) {
    this._token = token;
    notifyListeners();
  }

  get userEnabled {
    return _userModel;
  }

  set userEnabled(UserApp user) {
    this._userModel = _userModel;
    notifyListeners();
  }
}
