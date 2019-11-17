import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class ViewModel extends Model {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String userName="";
  String emailId="";
  String userUuid="";
  List<Map<String, dynamic>> data = [];

  ViewModel(){
    print("hi WE IN");
    print(data);
  }

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
  List<Map<String, dynamic>> getData(){
    notifyListeners();
    return data;
  }
  void addData(Map<String, dynamic> str){
    print("add");
    print(data.length);
    //str.forEach((k,v) => print('${k}: ${v}'));
    data.add(str);
    notifyListeners();
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
