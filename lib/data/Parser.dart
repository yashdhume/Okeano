import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:okeano/ui/Search.dart';

Future fetchPost([howMany = 5]) async {
  final response = await http.get(
      'http://vincentssecretspot.tk/okeano/products/' + searchQuery + '.json');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

Future loadPosts() async {
  await fetchPost().then((res) async {
    postsController.add(res);
    return res;
  });
}

Widget indicator() {
  if (isOn) {
    return CircularProgressIndicator();
  } else {
    return Text('');
  }
}
Future<Null> handleRefresh() async {

  await fetchPost(searchQuery).then((res) async {
    postsController.add(res);
    return null;
  });
}
