import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:managents/models/authentication/user.dart';

class Authentication with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  bool _isLogin = false;

  bool get isUserlogin => _isLogin;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserApp> Login(
      {@required String username, @required String password}) async {
    UserApp userApp = UserApp();
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password);
      User user = authResult.user;
      print(' verificado?  ');
      print(user.email);
      print(user.getIdTokenResult());
      if (user.email.isNotEmpty) {
        setLoading(false);
        userApp.email = user.email.toString();
        userApp.uid = user.uid;
        userApp.name = user.displayName ?? user.email.toString().split("@")[0];
      }
      return userApp;
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

  // Esta logueado?
  Future<UserApp> isSignedIn() async {
    final currentUser = firebaseAuth.currentUser;
    await currentUser.reload();
    UserApp userApp = UserApp();
    print(currentUser.providerData);
    if (currentUser != null) {
      print('loged');

      userApp.email = currentUser.email.toString();
      userApp.uid = currentUser.uid;
      userApp.name =
          currentUser.displayName ?? currentUser.email.toString().split("@")[0];
      setIslogin(true);
    } else {
      print('no loged');
      setIslogin(false);
    }
    notifyListeners();
    return userApp;
    //return currentUser != null;
  }

  Future logout() async {
    await firebaseAuth.signOut();
    setIslogin(false);
    notifyListeners();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setIslogin(val) {
    _isLogin = val;
    notifyListeners();
  }

  Stream<User> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
