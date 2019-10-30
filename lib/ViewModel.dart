import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ViewModel extends Model {
  List<String> urls = [
    "https://www.fillmurray.com/640/660",
    "http://lorempixel.com/640/640",
    "https://loremflickr.com/640/640",
    "https://placekitten.com/640/640",
    "https://baconmockup.com/640/640",
    "https://placebeard.it/640x640",
    "https://www.placecage.com/640/660",
    "http://placeimg.com/640/640/any",
  ];
  bool isCollapsed = false;

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
