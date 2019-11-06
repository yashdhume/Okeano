import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class ViewModel extends Model {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String userName="";
  String emailId="";
  String userUuid="";
  void getUser() {
    firebaseAuth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) {
      userName = user.email;
      emailId = user.email;
      userUuid = user.uid;
      notifyListeners();
    });
    notifyListeners();
    print(emailId);
  }

  Future<http.Response> sendRequest(String product) {
    return http.get(
        'http://vincentssecretspot.tk/okeano/search.php?product=' + product);
  }

  String searchQuery = "";

  void updateSearchQuery(String value) {
    searchQuery = value;
    print(searchQuery);
    sendRequest(searchQuery);
    notifyListeners();
  }
}
