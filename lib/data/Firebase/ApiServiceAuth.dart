import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future Login({@required String username, @required String password}) async {
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password);
      User user = authResult.user;
      print(' verificado?  ');
      print(user.email);
      print(user.getIdTokenResult());
      if (user.email.isNotEmpty) {
        setLoading(false);
      }
      return user;
    } on SocketException {
      setMessage("No internet ");
      setLoading(true);
    } catch (e) {
      setLoading(true);
      print('error ');
      setMessage(e.message);
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
