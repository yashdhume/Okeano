import 'Product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:jsonstreamreader/jsonstreamreader.dart';
import 'dart:convert';
Future<List<Product>> fetchPost(http.Client client, String product) async {
  String link = 'http://vincentssecretspot.tk/okeano/products/'+product+'.json';
  final response = await client.get(link);
  if (response.statusCode == 200) {
    return parse(response.body);
  } else {
    throw Exception('Failed to load post');
  }

}
Future fetch(String product) async {
  final response = await http.get(
      'http://vincentssecretspot.tk/okeano/products/'+product+'.json');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}
List<Product> parse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}