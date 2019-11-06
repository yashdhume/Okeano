import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  // wrapping the firebase calls
  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }


  // wrappinhg the firebase calls
  Future createUser(
      {String name,
        String email,
        String password}) async {
    var r = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    var u = r.user;
    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = '$name';
    return await u.updateProfile(info);
  }
  Future getUserData() async{
    FirebaseUser user = await _auth.currentUser();
    print(user.displayName);
    return user;
  }
    // wrappinhg the firebase calls
  Future<AuthResult> loginUser({String email, String password}) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}